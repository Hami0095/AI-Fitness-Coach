// lib/features/plan/presentation/plan_settings_page.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';

class PlanSettingsPage extends StatefulWidget {
  const PlanSettingsPage({Key? key}) : super(key: key);

  @override
  _PlanSettingsPageState createState() => _PlanSettingsPageState();
}

class _PlanSettingsPageState extends State<PlanSettingsPage> {
  // state fields
  String _goal = 'Lose Weight';
  String _planType = 'Strength training';
  String _planLocation = 'Home';
  int _durationMin = 7;
  String _schedule = '4/week';
  String _fitnessLevel = 'Beginner';
  int _homeEquipmentCount = 0;
  int _homeEquipmentTotal = 14;
  int _gymEquipmentCount = 42;
  int _gymEquipmentTotal = 42;
  Set<String> _healthRestrictions = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // ─── Back arrow + title ───────────────────────
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => GoRouter.of(context).pop(),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.5),
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(8),
                      child: const Icon(Icons.arrow_back, color: Colors.black),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Spacer(),
                ],
              ),
            ),
            
            Align(
              alignment: Alignment.centerLeft,
              
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Plan settings',
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const Divider(height: 1),
            // ─── Settings list ────────────────────────────
            Expanded(
              child: ListView(
                children: [
                  _buildTile(
                    title: 'Profile',
                    trailing: '',
                    onTap: () {
                      // TODO: Navigate to your ProfilePage
                      GoRouter.of(context).push('/profile');
                    },
                  ),
                  _buildTile(
                    title: 'Goal',
                    trailing: _goal,
                    onTap: _showGoalSheet,
                  ),
                  _buildTile(
                    title: 'Workout Plan',
                    trailing: '$_planType, $_planLocation',
                    onTap: _showWorkoutPlanSheet,
                  ),
                  _buildTile(
                    title: 'Workout Duration',
                    trailing: '$_durationMin min',
                    onTap: _showDurationSheet,
                  ),
                  _buildTile(
                    title: 'Workout Schedule',
                    trailing: _schedule,
                    onTap: _showScheduleSheet,
                  ),
                  _buildTile(
                    title: 'Fitness Level',
                    trailing: _fitnessLevel,
                    onTap: _showFitnessLevelSheet,
                  ),
                  _buildTile(
                    title: 'Equipment',
                    trailing: '$_homeEquipmentCount of $_homeEquipmentTotal',
                    onTap: _showEquipmentPage,
                  ),
                  _buildTile(
                    title: 'Health Restrictions',
                    trailing: _healthRestrictions.isEmpty
                        ? ''
                        : _healthRestrictions.join(', '),
                    onTap: _showHealthRestrictionsSheet,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTile({
    required String title,
    required String trailing,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        ListTile(
          title: Text(
            title,
            style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (trailing.isNotEmpty)
                Text(trailing, style: GoogleFonts.poppins()),
              const SizedBox(width: 8),
              const Icon(Icons.chevron_right),
            ],
          ),
          onTap: onTap,
        ),
        const Divider(height: 1),
      ],
    );
  }

  // ─── Goal sheet ──────────────────────────────────
  void _showGoalSheet() {
    final options = [
      'Gain Muscle',
      'Get in Shape',
      'Lose Weight',
      'Be Healthy',
    ];
    String temp = _goal;
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => StatefulBuilder(
        builder: (context, setS) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Change my goal',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                ...options.map(
                  (o) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: InkWell(
                      onTap: () => setS(() => temp = o),
                      child: Container(
                        decoration: BoxDecoration(
                          color: temp == o
                              ? Colors.black
                              : Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 12,
                        ),
                        child: Center(
                          child: Text(
                            o,
                            style: GoogleFonts.poppins(
                              color: temp == o ? Colors.white : Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        'Cancel',
                        style: GoogleFonts.poppins(color: Colors.green),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() => _goal = temp);
                        Navigator.pop(context);
                      },
                      child: Text(
                        'OK',
                        style: GoogleFonts.poppins(color: Colors.green),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // ─── Workout Plan sheet ─────────────────────────
  void _showWorkoutPlanSheet() {
    String tempType = _planType;
    String tempLoc = _planLocation;
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => StatefulBuilder(
        builder: (c, setS) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Workout Plan',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'The workouts that EMCSquare generates for your Workout Plan are affected by your preferred workout location.',
                  style: GoogleFonts.poppins(fontSize: 14),
                ),
                const SizedBox(height: 16),

                Text(
                  'Home',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                InkWell(
                  onTap: () => setS(() => tempLoc = 'Home'),
                  child: Container(
                    decoration: BoxDecoration(
                      color: tempLoc == 'Home'
                          ? Colors.black
                          : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Center(
                      child: Text(
                        _planType == 'Strength training'
                            ? 'Strength Training'
                            : 'Calisthenics',
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                InkWell(
                  onTap: () => setS(() => tempType = 'Calisthenics'),
                  child: Container(
                    decoration: BoxDecoration(
                      color: tempType == 'Calisthenics'
                          ? Colors.grey.shade200
                          : Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Center(
                      child: Text('Calisthenics', style: GoogleFonts.poppins()),
                    ),
                  ),
                ),

                const SizedBox(height: 16),
                Text(
                  'Gym',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                InkWell(
                  onTap: () => setS(() => tempLoc = 'Gym'),
                  child: Container(
                    decoration: BoxDecoration(
                      color: tempLoc == 'Gym'
                          ? Colors.grey.shade200
                          : Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Center(
                      child: Text(
                        'Strength Training',
                        style: GoogleFonts.poppins(),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        'Cancel',
                        style: GoogleFonts.poppins(color: Colors.green),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _planType = tempType;
                          _planLocation = tempLoc;
                        });
                        Navigator.pop(context);
                      },
                      child: Text(
                        'OK',
                        style: GoogleFonts.poppins(color: Colors.green),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // ─── Duration sheet ──────────────────────────────
  void _showDurationSheet() {
    int temp = _durationMin;
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => StatefulBuilder(
        builder: (c, setS) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Workout Duration',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Includes warm-up and cooldown.',
                  style: GoogleFonts.poppins(fontSize: 14),
                ),
                const SizedBox(height: 24),
                // simple NumberPicker style
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: temp > 1 ? () => setS(() => temp--) : null,
                      icon: const Icon(Icons.remove),
                    ),
                    Text('$temp', style: GoogleFonts.poppins(fontSize: 24)),
                    IconButton(
                      onPressed: () => setS(() => temp++),
                      icon: const Icon(Icons.add),
                    ),
                    const SizedBox(width: 8),
                    Text('min', style: GoogleFonts.poppins(fontSize: 16)),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        'Cancel',
                        style: GoogleFonts.poppins(color: Colors.green),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() => _durationMin = temp);
                        Navigator.pop(context);
                      },
                      child: Text(
                        'OK',
                        style: GoogleFonts.poppins(color: Colors.green),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // ─── Schedule sheet ──────────────────────────────
  void _showScheduleSheet() {
    final options = [
      '1/week',
      '2/week',
      '3/week',
      '4/week',
      '5/week',
      '6/week',
      'Every day',
    ];
    String temp = _schedule;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => StatefulBuilder(
        builder: (c, setS) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 16),
                Text(
                  'How often do you want to workout?',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                // segmented control stub
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _SegmentedOption(
                      label: 'Smart schedule ✨',
                      selected: true,
                      onTap: () {},
                    ),
                    _SegmentedOption(
                      label: 'Fixed schedule',
                      selected: false,
                      onTap: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                ...options.map(
                  (o) => Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 4,
                      horizontal: 16,
                    ),
                    child: InkWell(
                      onTap: () => setS(() => temp = o),
                      child: Container(
                        decoration: BoxDecoration(
                          color: temp == o
                              ? Colors.black
                              : Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Center(
                          child: Text(
                            o,
                            style: GoogleFonts.poppins(
                              color: temp == o ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        'Cancel',
                        style: GoogleFonts.poppins(color: Colors.green),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() => _schedule = temp);
                        Navigator.pop(context);
                      },
                      child: Text(
                        'OK',
                        style: GoogleFonts.poppins(color: Colors.green),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // ─── Fitness Level sheet ─────────────────────────
  void _showFitnessLevelSheet() {
    final levels = ['Beginner', 'Intermediate', 'Advanced'];
    String temp = _fitnessLevel;
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Fitness Level', style: GoogleFonts.poppins(fontSize: 20)),
        content: StatefulBuilder(
          builder: (c, setS) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (var lvl in levels)
                  RadioListTile<String>(
                    title: Text(lvl, style: GoogleFonts.poppins()),
                    value: lvl,
                    groupValue: temp,
                    onChanged: (v) => setS(() => temp = v!),
                  ),
              ],
            );
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: GoogleFonts.poppins(color: Colors.green),
            ),
          ),
          TextButton(
            onPressed: () {
              setState(() => _fitnessLevel = temp);
              Navigator.pop(context);
            },
            child: Text('OK', style: GoogleFonts.poppins(color: Colors.green)),
          ),
        ],
      ),
    );
  }

  // ─── Equipment page ──────────────────────────────
  void _showEquipmentPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => EquipmentPage(
          homeCount: _homeEquipmentCount,
          homeTotal: _homeEquipmentTotal,
          gymCount: _gymEquipmentCount,
          gymTotal: _gymEquipmentTotal,
        ),
      ),
    );
  }

  // ─── Health Restrictions sheet ────────────────────
  void _showHealthRestrictionsSheet() {
    final options = {'Back-friendly', 'Knee-friendly', 'Shoulders-friendly'};
    Set<String> temp = Set.from(_healthRestrictions);
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => StatefulBuilder(
        builder: (c, setS) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Health Restrictions',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                for (var o in options)
                  CheckboxListTile(
                    title: Text(o, style: GoogleFonts.poppins()),
                    value: temp.contains(o),
                    onChanged: (v) => setS(() {
                      if (v! && !temp.contains(o)) temp.add(o);
                      if (!v && temp.contains(o)) temp.remove(o);
                    }),
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        'Cancel',
                        style: GoogleFonts.poppins(color: Colors.green),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() => _healthRestrictions = temp);
                        Navigator.pop(context);
                      },
                      child: Text(
                        'OK',
                        style: GoogleFonts.poppins(color: Colors.green),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// ─── EquipmentPage ─────────────────────────────────────
class EquipmentPage extends StatelessWidget {
  final int homeCount, homeTotal, gymCount, gymTotal;
  const EquipmentPage({
    Key? key,
    required this.homeCount,
    required this.homeTotal,
    required this.gymCount,
    required this.gymTotal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Equipment',
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: ListView(
        children: [
          _buildEquipTile('Home Equipment', homeCount, homeTotal, context),
          _buildEquipTile('Gym Equipment', gymCount, gymTotal, context),
        ],
      ),
    );
  }

  Widget _buildEquipTile(String title, int count, int total, BuildContext c) {
    return Column(
      children: [
        ListTile(
          title: Text(title, style: GoogleFonts.poppins()),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('$count of $total', style: GoogleFonts.poppins()),
              const SizedBox(width: 8),
              const Icon(Icons.chevron_right),
            ],
          ),
          onTap: () {
            // handle tap
          },
        ),
        const Divider(height: 1),
      ],
    );
  }
}

// ─── Segmented control helper ─────────────────────────
class _SegmentedOption extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const _SegmentedOption({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: selected ? Colors.white : Colors.transparent,
            border: Border.all(color: Colors.black54),
            borderRadius: BorderRadius.horizontal(
              left: Radius.circular(label.startsWith('Smart') ? 12 : 0),
              right: Radius.circular(label.startsWith('Fixed') ? 12 : 0),
            ),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Center(child: Text(label, style: GoogleFonts.poppins())),
        ),
      ),
    );
  }
}
