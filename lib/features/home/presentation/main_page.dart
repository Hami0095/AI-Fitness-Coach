// lib/features/home/presentation/main_page.dart
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '/features/workout/presentation/workout_page.dart';
import '/features/analytics/presentation/analytics_page.dart';
import '/features/coach/presentation/coach_page.dart';

/// A provider to hold the current index of the bottom navigation bar.
final bottomNavIndexProvider = StateProvider<int>((ref) => 0);

/// MainPage hosts the three primary tabs: Workout, Analytics, Coach.
class MainPage extends ConsumerWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(bottomNavIndexProvider);
    final pages = <Widget>[
      const WorkoutPage(),
      const AnalyticsScreen(),
      const CoachPage(),
    ];

    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) =>
            ref.read(bottomNavIndexProvider.notifier).state = index,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: 'Workout',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics_rounded),
            label: 'Analytics',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_rounded),
            label: 'Coach',
          ),
        ],
        selectedItemColor: Color.fromARGB(255, 0, 125, 115),
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
      ),
    );
  }
}
