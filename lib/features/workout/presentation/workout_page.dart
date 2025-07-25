// lib/features/workout/presentation/workout_page.dart
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
// workout_page.dart
enum WorkoutDayStatus { done, scheduled, rest }

class WorkoutPlan {
  final String trainingPlan; // e.g. "Strength"
  final String workoutType; // e.g. "Full Body"
  final int exercises; // e.g. 3
  final int calories; // e.g. 28

  const WorkoutPlan({
    required this.trainingPlan,
    required this.workoutType,
    required this.exercises,
    required this.calories,
  });
}


class WorkoutPage extends ConsumerWidget {
  const WorkoutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _WorkoutPlannerSection(),
          SizedBox(height: 24),
          _ActivityStreakCard(),
          SizedBox(height: 24),
          _ScanBodyCard(),
          SizedBox(height: 24),
          _CoachQuestionsCard(),
          SizedBox(height: 24),
          _MoreActionsSection(),
          SizedBox(height: 24),
          _SavedWorkoutsTile(),
        ],
      ),
    );
  }
}

class _WorkoutPlannerSection extends StatelessWidget {
  const _WorkoutPlannerSection({Key? key}) : super(key: key);

  // Dummy statuses for the week — hook your real logic here!
  final List<WorkoutDayStatus> _statuses = const [
    WorkoutDayStatus.done,
    WorkoutDayStatus.scheduled,
    WorkoutDayStatus.rest,
    WorkoutDayStatus.scheduled,
    WorkoutDayStatus.scheduled,
    WorkoutDayStatus.rest,
    WorkoutDayStatus.rest,
  ];

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final monday = now.subtract(Duration(days: now.weekday - 1));
    final weekDays = List.generate(7, (i) => monday.add(Duration(days: i)));

    // TODO: Replace with your real user & plan data
    final userName = 'Hami';
    final todayPlan = const WorkoutPlan(
      trainingPlan: 'Strength',
      workoutType: 'Full Body',
      exercises: 3,
      calories: 28,
    );

    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color.fromARGB(255, 0, 11, 10), Color.fromARGB(255, 0, 96, 46), Color.fromARGB(255, 0, 42, 20),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ─── Streak icon above days strip ───────────────────────────────
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.local_fire_department, color: Colors.white),
                  const SizedBox(width: 4),
                  Text(
                    '0', // TODO: wire up real streak count
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ─── Days + “…” button ──────────────────────────────────────────
          SizedBox(
            height: 80,
            child: Row(
              children: [
                Expanded(
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: weekDays.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 12),
                    itemBuilder: (context, i) {
                      final d = weekDays[i];
                      final status = _statuses[i];
                      final isToday =
                          d.day == now.day &&
                          d.month == now.month &&
                          d.year == now.year;

                      Color bg = isToday
                          ? Colors.white.withOpacity(0.2)
                          : Colors.transparent;
                      Widget icon;
                      switch (status) {
                        case WorkoutDayStatus.done:
                          icon =  Icon(Icons.check, color: Colors.white, size: 15,);
                          break;
                        case WorkoutDayStatus.scheduled:
                          icon = const Icon(
                            Icons.fitness_center,
                            color: Colors.white,
                            size: 15,
                          );
                          break;
                        case WorkoutDayStatus.rest:                        
                          icon = Container(
                            width: 6,
                            height: 6,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                          );
                      }

                      return Container(
                        width: 50,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: bg,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [                            
                            Column(
                              children: [
                                Text(
                                  DateFormat('E').format(d),
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  d.day.toString(),
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            icon,
                          ],
                        ),
                      );
                    },
                  ),
                ),
                 InkWell(
                  onTap: () => _openWorkoutOptions(context),
                  borderRadius: BorderRadius.circular(24),
                  child: Container(
                    width: 48,
                    height: 48,
                    margin: const EdgeInsets.only(left: 12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: const Icon(Icons.more_horiz, color: Colors.white),
                  ),
                ),               
              ],
            ),
          ),

          const SizedBox(height: 16),

          // ─── Greeting ───────────────────────────────────────────────────
          Text(
            'Get ready, $userName',
            style: GoogleFonts.poppins(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "Let's smash today's workout!",
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: Colors.white.withOpacity(0.9),
            ),
          ),

          const SizedBox(height: 16),

          // ─── Updated plan card ──────────────────────────────────────────
          GestureDetector(
            onTap: () => context.push('/workout-plan'),
            child: _WorkoutPlanCard(plan: todayPlan),
          ),

          const SizedBox(height: 16),

          // ─── Tags ───────────────────────────────────────────────────────
          Row(
            children: [
              _TagLabel('Special for Hami', isActive: true),
              const SizedBox(width: 8),
              _TagLabel('Gym', isActive: false),
            ],
          ),

          const Spacer(),

          // ─── Custom Workout button ─────────────────────────────────────
          OutlinedButton(
            onPressed: () => GoRouter.of(context).push('/custom_workout'),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.white),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              minimumSize: const Size.fromHeight(48),
            ),
            child: Text(
              'Custom Workout',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}


void _openWorkoutOptions(BuildContext context) {
  showModalBottomSheet(
    context: context,
    // make the sheet itself transparent so we can give it side‐margins
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (sheetContext) => Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        // shrink‐wrap to content
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Plan Details
            ListTile(
              title: Text(
                'Plan Details',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.pop(sheetContext);
                GoRouter.of(context).push('/plan-details');
              },
            ),
            const Divider(height: 1),
            // Full Schedule
            ListTile(
              title: Text(
                'Full Schedule',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.pop(sheetContext);
                GoRouter.of(context).push('/full-schedule');
              },
            ),
            const Divider(height: 1),
            // Plan Settings
            ListTile(
              title: Text(
                'Plan Settings',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.pop(sheetContext);
                GoRouter.of(context).push('/plan-settings');
              },
            ),
          ],
        ),
      ),
    ),
  );
}


class _WorkoutPlanCard extends StatelessWidget {
  final WorkoutPlan plan;
  const _WorkoutPlanCard({Key? key, required this.plan}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            plan.trainingPlan,
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            plan.workoutType,
            style: GoogleFonts.poppins(fontSize: 16, color: Colors.white),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    const Icon(Icons.directions_run, color: Colors.white),
                    const SizedBox(height: 4),
                    Text(
                      '${plan.exercises}',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Exercises',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 1,
                height: 48,
                color: Colors.white.withOpacity(0.5),
              ),
              Expanded(
                child: Column(
                  children: [
                    const Icon(Icons.bolt, color: Colors.white),
                    const SizedBox(height: 4),
                    Text(
                      '${plan.calories}',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Kcal',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


// Small helper for the two tags
class _TagLabel extends StatelessWidget {
  final String text;
  final bool isActive;
  const _TagLabel(this.text, {required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isActive
            ? Colors.white.withOpacity(0.3)
            : Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: 12,
          color: Colors.white,
        ),
      ),
    );
  }
}

// Small helper for each preview image
// ignore: unused_element
class _PreviewImage extends StatelessWidget {
  final String assetPath;
  const _PreviewImage(this.assetPath);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      margin: const EdgeInsets.only(right: 8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset(
          assetPath,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}


class _ActivityStreakCard extends StatelessWidget {
  const _ActivityStreakCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Activity Streak',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Increase your Activity Streak and make consistent progress to your fitness goal.',
              style: GoogleFonts.poppins(fontSize: 14),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Image.asset('assets/icons/fire.png', width: 24, height: 24),
                const SizedBox(width: 8),
                Text(
                  '0',
                  style: GoogleFonts.poppins(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 4),
                Text('days of ', style: GoogleFonts.poppins(fontSize: 16)),
                Text(
                  'healthy',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 4),
                Text('activity', style: GoogleFonts.poppins(fontSize: 16)),
              ],
            ),
            const SizedBox(height: 16),
            Stack(
              children: [
                Container(
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                Positioned(
                  left: 0,
                  child: Container(
                    height: 20,
                    width: MediaQuery.of(context).size.width * 0.4,
                    decoration: BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Center(
                    child: Text(
                      'UNDERPERFORMING',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Improve Streak Accuracy',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Sync EMCSquare with Health Connect to add all your daily activity data to your Streak.',
              style: GoogleFonts.poppins(fontSize: 14),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: Text(
                  'Connect Health',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ScanBodyCard extends StatelessWidget {
  const _ScanBodyCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue.shade50,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: const DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/body_scan_preview.png'),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Improve Workout Personalization'.toUpperCase(),
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Scan Your Body',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'The more you know about your body, the easier it is to get into great shape.',
              style: GoogleFonts.poppins(fontSize: 14),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      context.push('/scan'); // route to scan page
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: Text(
                      'Try Now',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      context.push('/body-scan-report'); // route to sample report
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      side: const BorderSide(color: Colors.grey),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: Text(
                      'See Sample Report',
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _CoachQuestionsCard extends StatelessWidget {
  const _CoachQuestionsCard();

  final List<String> _questions = const [
    'Is it okay to skip meals for weight loss?',
    'What are the best exercises for fat loss?',
    'What should I eat before and after workouts?',
    'What type of cardio is most effective?',
    'I have another question.',
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Color.fromARGB(200, 0, 103, 96),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/images/coach_dp.png'),
                  radius: 16,
                ),
                const SizedBox(width: 8),
                Text(
                  'Questions for your Coach',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ..._questions.map(
              (q) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: InkWell(
                  onTap: () => context.push('/coach'),
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 16,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            q,
                            style: GoogleFonts.poppins(fontSize: 14),
                          ),
                        ),
                        Icon(Icons.arrow_forward_ios, size: 16),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MoreActionsSection extends StatelessWidget {
  const _MoreActionsSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'More actions',
          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        ListTile(
          title: Text(
            'Plan settings',
            style: GoogleFonts.poppins(fontSize: 14),
          ),
          trailing: Icon(Icons.chevron_right),
          onTap: () => context.push('/plan-settings'),
        ),
        ListTile(
          title: Text('App settings', style: GoogleFonts.poppins(fontSize: 14)),
          trailing: Icon(Icons.chevron_right),
          onTap: () => context.push('/app-settings'),
        ),
      ],
    );
  }
}

class _SavedWorkoutsTile extends StatelessWidget {
  const _SavedWorkoutsTile();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      tileColor: Colors.white,
      leading: Icon(Icons.bookmark_border),
      title: Text('Saved Workouts', style: GoogleFonts.poppins(fontSize: 14)),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('0', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
          const SizedBox(width: 8),
          Icon(Icons.chevron_right),
        ],
      ),
      onTap: () => context.push('/saved-workouts'),
    );
  }
}
