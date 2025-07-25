// lib/features/analytics/presentation/analytics_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitness_app/constants/global_constants.dart';
import 'package:go_router/go_router.dart';

/// Providers for demo data; replace with real Firestore or API data
final daysSinceLastWorkoutProvider = StateProvider<int>((ref) => 0);
final muscleRecoveryProgressProvider = StateProvider<double>((ref) => 0.5);
final freshMuscleGroupsProvider = StateProvider<int>((ref) => 10);

class AnalyticsScreen extends ConsumerWidget {
  const AnalyticsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final days = ref.watch(daysSinceLastWorkoutProvider);
    final recovery = ref.watch(muscleRecoveryProgressProvider);
    final groups = ref.watch(freshMuscleGroupsProvider);

    final headingStyle = Theme.of(context).textTheme.headlineLarge;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top bar: Premium badge + settings
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Chip(
                    avatar: const Icon(Icons.diamond, color: Colors.white),
                    label: const Text('PREMIUM', style: TextStyle(color: Colors.white)),
                    backgroundColor: Color.fromARGB(255, 0, 125, 115),
                  ),
                  IconButton(
                    icon: const Icon(Icons.settings),
                    onPressed: () {},
                  ),
                ],
              ),

              const SizedBox(height: 16),
              Text('Analytics', style: headingStyle),
              const SizedBox(height: 16),

              // Muscle Recovery Card
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                color: Color.fromARGB(255, 245, 253, 253),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Muscle Recovery', style: Theme.of(context).textTheme.headlineSmall),
                      const SizedBox(height: 8),
                      Text(
                        '$days days since your last workout',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(color: Colors.grey),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset('assets/images/muscle_front.png', width: 100, height: 150),
                          Image.asset('assets/images/muscle_back.png', width: 100, height: 150),
                        ],
                      ),
                      const SizedBox(height: 8),
                      LinearProgressIndicator(value: recovery),
                      const SizedBox(height: 4),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [Text('0%'), Text('50%'), Text('100%')],
                        ),
                      ),
                      const Divider(),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Fresh Muscle Groups'),
                        trailing: Text('$groups'),
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Fitness Score Card with background image
              InkWell(
                onTap: () => context.push('/camera/squat'),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: SizedBox(
                    height: 200,
                    child: Stack(
                      children: [
                        // Background image
                        Positioned.fill(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16.0),
                            child: Image.asset(
                              'assets/images/fitness_test.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        // Overlay content
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.greenAccent,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  aiVisionName,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Fitness Test',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineLarge
                                    ?.copyWith(color: Colors.white),
                              ),
                              Text(
                                '5 min',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge
                                    ?.copyWith(color: Colors.white70),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Test your overall fitness levels in 3 exercises.',
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
