// lib/main.dart
import 'package:fitness_app/constants/api_key.dart';
import 'package:fitness_app/core/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';

/// A simple provider that holds our initialRoute based on onboarding.
final initialLocationProvider = Provider<String>((ref) {
  // default, will be overridden in main()
  return '/onboarding';
});

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // init Gemini
  Gemini.init(apiKey: apiKey);

  // load shared prefs
  final prefs = await SharedPreferences.getInstance();
  // ignore: unused_local_variable
  final done = prefs.getBool('onboardingDone') ?? false;

  // decide initialRoute
  // final initialLocation = done ? '/onboarding' : '/main';
  final initialLocation = '/main';
  runApp(
    ProviderScope(
      overrides: [
        // override the default
        initialLocationProvider.overrideWithValue(initialLocation),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // read the initial location
    final initialLoc = ref.watch(initialLocationProvider);

    // now create your router, passing that initial location in.
    // You will need to adjust your appRouterProvider to accept it.
    final router = ref.watch(appRouterProvider(initialLoc));

    return MaterialApp.router(
      title: 'EMCSQUARE AI',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
      ),
      routerConfig: router,
      
      debugShowCheckedModeBanner: false,
    );
  }
}
