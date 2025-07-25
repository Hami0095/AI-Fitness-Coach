import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';



class _GreenPill extends StatelessWidget {
  final String text;
  const _GreenPill({required this.text, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFB5FF3B),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.black87,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}




class BodyScanReportPage extends ConsumerWidget {
  const BodyScanReportPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Gradient header box
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF0B1D3A), Color(0xFF005F49)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
            ),
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: () => context.pop(),
                        child: const Icon(Icons.close, color: Colors.white, size: 24),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        _InfoPill(label: 'Scan date', value: '08/17/2023'),
                        _InfoPill(label: 'Time', value: '01:59 PM'),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Hey, Joe',
                      style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700, color: Colors.white),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Your Body Scan Report is ready. Are you?',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white70),
                    ),
                    const SizedBox(height: 20),
                    Column(
                      children: [
                        _MetricRow(
                          label1: 'Sex', value1: 'Male', icon1: Icons.male,
                          label2: 'Age', value2: '36', icon2: Icons.calendar_today,
                        ),
                        const Divider(color: Colors.white24),
                        _MetricRow(
                          label1: 'Height', value1: '175 cm', icon1: Icons.height,
                          label2: 'Weight', value2: '102 kg', icon2: Icons.monitor_weight,
                        ),
                        const Divider(color: Colors.white24),
                        _MetricRow(
                          label1: 'Activity level', value1: 'Sedentary', icon1: Icons.show_chart,
                          label2: 'Goal', value2: 'Lose Weight', icon2: Icons.check,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'This report is only your starting point. When making decisions about your body, always consult with a medical professional.',
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ),
          ),
          // Main content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _GreenPill(text: 'Body composition'),
                const SizedBox(height: 16),
                const Text(
                  'First up, let’s look at your body composition',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: Colors.black87),
                ),
                const SizedBox(height: 24),
                const _GreenPill(text: '147,840 kcal roughly equals:'),
                const SizedBox(height: 16),
                _EquivalencyRow(icon: Icons.fitness_center, label: 'Pushups, reps', value: '422,400'),
                const Divider(),
                _EquivalencyRow(icon: Icons.directions_run, label: 'Running, km', value: '2,365'),
                const Divider(),
                _EquivalencyRow(icon: Icons.self_improvement, label: 'Yoga, hours', value: '321', subtitle: '(Soon in EMCSquare)'),
                const SizedBox(height: 24),
                const _GreenPill(text: 'Nutrition summary'),
                const SizedBox(height: 16),
                const Text(
                  'Your nutrition plan is Cutting',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: Colors.black87),
                ),
                const SizedBox(height: 8),
                const Text(
                  'When it comes to fueling your body, nutrition takes the cake (not literally, of course).',
                  style: TextStyle(fontSize: 16, color: Colors.black87),
                ),
                const SizedBox(height: 16),
                GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    _NutriItem(value: '2,343', label: 'Total (kcal)', highlight: true),
                    _NutriItem(value: '175', label: 'Proteins (grams)', highlight: true),
                    _NutriItem(value: '65', label: 'Fats (grams)', highlight: false),
                    _NutriItem(value: '263', label: 'Carbs (grams)', highlight: false),
                  ],
                ),
                const SizedBox(height: 24),
                const Text('Do', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                const Text('• Monitor protein intake.'),
                const Text('• Fast intermittently on non-exercise days.'),
                const Text('• Cut down on carbs and fats.'),
                const SizedBox(height: 16),
                const Text('Don\'t', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                const Text('• Use food as a reward or compensation for training.'),
                const SizedBox(height: 24),
                const _GreenPill(text: 'Fitness summary'),
                const SizedBox(height: 16),
                const Text(
                  'Body Scan provides the data. You do the working out.',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: Colors.black87),
                ),
                const SizedBox(height: 16),
                const Text('Type of workouts:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                const Text(
                  'Combinations of low-intensity and moderate workouts (e.g., cycling), strength (lifting, power yoga), HIIT, bodyweight exercises, and up to 8 km/day of walking.',
                  style: TextStyle(fontSize: 16, color: Colors.black87),
                ),
                const SizedBox(height: 24),
                _WorkoutRecommRow(icon: Icons.timer, label: 'Duration per session, mins', value: '40-60'),
                const Divider(),
                _WorkoutRecommRow(icon: Icons.calendar_today, label: 'Frequency per week', value: '2-3'),
                const SizedBox(height: 16),
                const Text(
                  'Joe, to feel your absolute best, you need to start slow and increase the intensity gradually.',
                  style: TextStyle(fontSize: 16, color: Colors.black87),
                ),
                const SizedBox(height: 16),
                const Text('Things to do', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                const Text('• Aim for a well-rounded routine: 150 minutes of moderate-intensity aerobic activity and 2–3 strength-training sessions per week.'),
                const SizedBox(height: 16),
                const Text('Things to avoid', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                const Text('• Workouts that make you feel overly tired or hungry — both can lead to overeating. Be especially careful of evening workouts.'),
                const SizedBox(height: 24),
                // Coach Questions Section
                const _GreenPill(text: 'Questions for your Coach'),
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFF7F8FA), Color(0xFFEDEEFF)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 16,
                              backgroundImage: AssetImage('assets/images/coach_dp.png'),
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              'Questions for your Coach',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                      // Question items as white rounded boxes
                      _CoachQuestionItem(
                        text: 'What supplements could support my fitness goals?',
                        onTap: () => context.push('/coach'),                    
                      ),
                      _CoachQuestionItem(
                        text: 'Is my essential fat level healthy for me?',
                        onTap: () => context.push('/coach'),                        
                      ),
                      _CoachQuestionItem(
                        text: 'What exercises target unbeneficial fat more effectively?',
                        onTap: () => context.push('/coach'),
                        
                      ),
                      _CoachQuestionItem(
                        text: 'How can I increase my lean mass effectively?',
                        onTap: () => context.push('/coach'),
                        
                      ),
                      _CoachQuestionItem(
                        text: 'I have another question.',
                        onTap: () => context.push('/coach'),
                        
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Helper Widgets

class _InfoPill extends StatelessWidget {
  final String label;
  final String value;
  const _InfoPill({required this.label, required this.value, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(20)),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(text: '$label: ', style: const TextStyle(color: Colors.white70, fontSize: 12)),
            TextSpan(text: value, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}

class _MetricRow extends StatelessWidget {
  final String label1, value1;
  final IconData icon1;
  final String label2, value2;
  final IconData icon2;
  const _MetricRow({required this.label1, required this.value1, required this.icon1, required this.label2, required this.value2, required this.icon2, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle labelStyle = const TextStyle(color: Colors.white70, fontSize: 12);
    TextStyle valueStyle = const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600);

    Widget item(String label, String value, IconData icon) {
      return Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(color: const Color(0xFFB5FF3B), shape: BoxShape.circle),
            child: Icon(icon, color: Colors.black87, size: 18),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: labelStyle),
              Text(value, style: valueStyle),
            ],
          ),
        ],
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [item(label1, value1, icon1), item(label2, value2, icon2)],
      ),
    );
  }
}

class _EquivalencyRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final String? subtitle;

  const _EquivalencyRow({required this.icon, required this.label, required this.value, this.subtitle, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: const Color(0xFFB5FF3B), shape: BoxShape.circle),
            child: Icon(icon, size: 24, color: Colors.black87),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(fontSize: 16, color: Colors.black87)),
              Row(
                children: [
                  Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
                  if (subtitle != null) ...[
                    const SizedBox(width: 8),
                    Text(subtitle!, style: const TextStyle(fontSize: 14, color: Colors.black45)),
                  ]
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _NutriItem extends StatelessWidget {
  final String value;
  final String label;
  final bool highlight;

  const _NutriItem({required this.value, required this.label, required this.highlight, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: highlight ? const Color(0xFFB5FF3B) : const Color(0xFFF7F8FA),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: Colors.black87)),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(fontSize: 14, color: Colors.black87)),
        ],
      ),
    );
  }
}

class _WorkoutRecommRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _WorkoutRecommRow({required this.icon, required this.label, required this.value, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: const Color(0xFFB5FF3B), shape: BoxShape.circle),
            child: Icon(icon, size: 24, color: Colors.black87),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(fontSize: 14, color: Colors.black45)),
              Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.black87)),
            ],
          ),
        ],
      ),
    );
  }
}

// ignore: unused_element
class _SummaryItem extends StatelessWidget {
  final String label;
  final String description;

  const _SummaryItem({required this.label, required this.description, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
          if (description.isNotEmpty) ...[
            const SizedBox(height: 6),
            Text(description, style: const TextStyle(fontSize: 16, color: Colors.black87)),
          ]
        ],
      ),
    );
  }
}

class _CoachQuestionItem extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const _CoachQuestionItem({required this.text, required this.onTap, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Expanded(child: Text(text, style: const TextStyle(fontSize: 16, color: Colors.black87))),
            const Icon(Icons.chevron_right, color: Colors.black45),
          ],
        ),
      ),
    );
  }
}
