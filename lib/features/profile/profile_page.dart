// // lib/features/profile/profile_page.dart
// import 'package:flutter/material.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// /// String extension to capitalize the first letter
// extension StringExtension on String {
//   String capitalize() {
//     if (isEmpty) return this;
//     return substring(0, 1).toUpperCase() + substring(1);
//   }
// }

// /// Available genders
// enum Gender { male, female, other }

// /// Units
// enum UnitSystem { metric, imperial }

// /// Controller for plan settings, persists to SharedPreferences
// class ProfilePageController extends ChangeNotifier {
//   String name = '';
//   Gender gender = Gender.male;
//   int age = 24;
//   double height = 175; // in cm or inches depending on units
//   double weight = 70.0; // in kg or lbs depending on units
//   UnitSystem units = UnitSystem.metric;

//   ProfilePageController() {
//     _loadSettings();
//   }

//   Future<void> _loadSettings() async {
//     final prefs = await SharedPreferences.getInstance();
//     name = prefs.getString('profile_name') ?? name;
//     gender = Gender.values[prefs.getInt('profile_gender') ?? gender.index];
//     age = prefs.getInt('profile_age') ?? age;
//     height = prefs.getDouble('profile_height') ?? height;
//     weight = prefs.getDouble('profile_weight') ?? weight;
//     units = UnitSystem.values[prefs.getInt('profile_units') ?? units.index];
//     notifyListeners();
//   }

//   Future<void> updateName(String newName) async {
//     name = newName;
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString('profile_name', name);
//     notifyListeners();
//   }

//   Future<void> updateGender(Gender newGender) async {
//     gender = newGender;
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setInt('profile_gender', gender.index);
//     notifyListeners();
//   }

//   Future<void> updateAge(int newAge) async {
//     age = newAge;
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setInt('profile_age', age);
//     notifyListeners();
//   }

//   Future<void> updateHeight(double newHeight) async {
//     height = newHeight;
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setDouble('profile_height', height);
//     notifyListeners();
//   }

//   Future<void> updateWeight(double newWeight) async {
//     weight = newWeight;
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setDouble('profile_weight', weight);
//     notifyListeners();
//   }

//   Future<void> updateUnits(UnitSystem newUnits) async {
//     units = newUnits;
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setInt('profile_units', units.index);
//     notifyListeners();
//   }
// }

// final ProfilePageProvider = ChangeNotifierProvider(
//   (_) => ProfilePageController(),
// );

// /// UI for Plan Settings Page
// class ProfilePage extends ConsumerWidget {
//   const ProfilePage({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final ctrl = ref.watch(ProfilePageProvider);
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: Text(
//           'Profile',
//           style: GoogleFonts.poppins(
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//             color: Colors.black,
//           ),
//         ),
//       ),
//       body: ctrl.name.isEmpty && ctrl.age == 0
//           ? const Center(child: CircularProgressIndicator())
//           : ListView(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               children: [
//                 _buildNameField(context, ctrl),
//                 _buildDivider(),
//                 _buildGenderField(context, ctrl),
//                 _buildDivider(),
//                 _buildAgeField(context, ctrl),
//                 _buildDivider(),
//                 _buildHeightField(context, ctrl),
//                 _buildDivider(),
//                 _buildWeightField(context, ctrl),
//                 _buildDivider(),
//                 _buildUnitsField(context, ctrl),
//                 const SizedBox(height: 24),
//                 Text(
//                   'These settings affect your personal program. We store it on our servers to better understand our audience but never share any of this information with anyone else.',
//                   style: GoogleFonts.poppins(
//                     fontSize: 14,
//                     color: Colors.grey[600],
//                   ),
//                 ),
//                 const SizedBox(height: 24),
//               ],
//             ),
//     );
//   }

//   Widget _buildDivider() {
//     return Divider(color: Colors.grey.shade300, thickness: 1);
//   }

//   Widget _buildNameField(BuildContext context, ProfilePageController ctrl) {
//     return ListTile(
//       title: Text(
//         'Name',
//         style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
//       ),
//       subtitle: TextField(
//         controller: TextEditingController(text: ctrl.name),
//         decoration: const InputDecoration(
//           border: InputBorder.none,
//           isDense: true,
//         ),
//         style: GoogleFonts.poppins(fontSize: 16),
//         onSubmitted: ctrl.updateName,
//       ),
//     );
//   }

//   Widget _buildGenderField(BuildContext context, ProfilePageController ctrl) {
//     return ListTile(
//       title: Text(
//         'Gender',
//         style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
//       ),
//       subtitle: Text(
//         ctrl.gender.name.capitalize(),
//         style: GoogleFonts.poppins(fontSize: 16),
//       ),
//       onTap: () async {
//         final result = await showDialog<Gender>(
//           context: context,
//           builder: (_) => AlertDialog(
//             title: const Text('Gender'),
//             content: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: Gender.values
//                   .map(
//                     (g) => RadioListTile<Gender>(
//                       value: g,
//                       groupValue: ctrl.gender,
//                       title: Text(g.name.capitalize()),
//                       onChanged: (val) => Navigator.pop(context, val),
//                     ),
//                   )
//                   .toList(),
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () => Navigator.pop(context),
//                 child: const Text('Cancel'),
//               ),
//               TextButton(
//                 onPressed: () => Navigator.pop(context, ctrl.gender),
//                 child: const Text('OK'),
//               ),
//             ],
//           ),
//         );
//         if (result != null && result != ctrl.gender) {
//           ctrl.updateGender(result);
//         }
//       },
//     );
//   }

//   Widget _buildAgeField(BuildContext context, ProfilePageController ctrl) {
//     return ListTile(
//       title: Text(
//         'Age',
//         style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
//       ),
//       subtitle: Text('${ctrl.age}', style: GoogleFonts.poppins(fontSize: 16)),
//       onTap: () async {
//         final result = await showModalBottomSheet<int>(
//           context: context,
//           builder: (_) => _NumberPickerSheet(
//             title: 'Age',
//             min: 10,
//             max: 100,
//             initial: ctrl.age,
//             suffix: '',
//           ),
//         );
//         if (result != null && result != ctrl.age) ctrl.updateAge(result);
//       },
//     );
//   }

//   Widget _buildHeightField(BuildContext context, ProfilePageController ctrl) {
//     return ListTile(
//       title: Text(
//         'Height',
//         style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
//       ),
//       subtitle: Text(
//         '${ctrl.height.toStringAsFixed(0)} ${ctrl.units == UnitSystem.metric ? 'cm' : 'in'}',
//         style: GoogleFonts.poppins(fontSize: 16),
//       ),
//       onTap: () async {
//         final result = await showModalBottomSheet<double>(
//           context: context,
//           builder: (_) => _NumberPickerSheet(
//             title: 'Height',
//             min: ctrl.units == UnitSystem.metric ? 100 : 40,
//             max: ctrl.units == UnitSystem.metric ? 220 : 90,
//             initial: ctrl.height.toInt(),
//             suffix: ctrl.units == UnitSystem.metric ? 'cm' : 'in',
//           ),
//         );
//         if (result != null) ctrl.updateHeight(result);
//       },
//     );
//   }

//   Widget _buildWeightField(BuildContext context, ProfilePageController ctrl) {
//     return ListTile(
//       title: Text(
//         'Weight',
//         style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
//       ),
//       subtitle: Text(
//         '${ctrl.weight.toStringAsFixed(1)} ${ctrl.units == UnitSystem.metric ? 'kg' : 'lb'}',
//         style: GoogleFonts.poppins(fontSize: 16),
//       ),
//       onTap: () async {
//         final result = await showModalBottomSheet<double>(
//           context: context,
//           builder: (_) => _NumberPickerSheet(
//             title: 'Weight',
//             min: ctrl.units == UnitSystem.metric ? 30 : 60,
//             max: ctrl.units == UnitSystem.metric ? 200 : 400,
//             initial: ctrl.weight.toInt(),
//             suffix: ctrl.units == UnitSystem.metric ? 'kg' : 'lb',
//             fractionDigits: ctrl.units == UnitSystem.metric ? 1 : 0,
//           ),
//         );
//         if (result != null) ctrl.updateWeight(result);
//       },
//     );
//   }

//   Widget _buildUnitsField(BuildContext context, ProfilePageController ctrl) {
//     return ListTile(
//       title: Text(
//         'Units',
//         style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
//       ),
//       subtitle: Text(
//         ctrl.units == UnitSystem.metric ? 'Metric' : 'Imperial',
//         style: GoogleFonts.poppins(fontSize: 16),
//       ),
//       onTap: () async {
//         final result = await showDialog<UnitSystem>(
//           context: context,
//           builder: (_) => AlertDialog(
//             title: const Text('Units'),
//             content: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: UnitSystem.values
//                   .map(
//                     (u) => RadioListTile<UnitSystem>(
//                       value: u,
//                       groupValue: ctrl.units,
//                       title: Text(
//                         u == UnitSystem.metric ? 'Metric' : 'Imperial',
//                       ),
//                       onChanged: (val) => Navigator.pop(context, val),
//                     ),
//                   )
//                   .toList(),
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () => Navigator.pop(context),
//                 child: const Text('Cancel'),
//               ),
//               TextButton(
//                 onPressed: () => Navigator.pop(context, ctrl.units),
//                 child: const Text('OK'),
//               ),
//             ],
//           ),
//         );
//         if (result != null && result != ctrl.units) ctrl.updateUnits(result);
//       },
//     );
//   }
// }

// /// Bottom sheet widget for picking numbers
// class _NumberPickerSheet extends StatefulWidget {
//   final String title;
//   final int min;
//   final int max;
//   final int initial;
//   final String suffix;
//   final int fractionDigits;

//   const _NumberPickerSheet({
//     required this.title,
//     required this.min,
//     required this.max,
//     required this.initial,
//     required this.suffix,
//     this.fractionDigits = 0,
//   });

//   @override
//   State<_NumberPickerSheet> createState() => _NumberPickerSheetState();
// }

// class _NumberPickerSheetState extends State<_NumberPickerSheet> {
//   late int selectedInt;
//   late int selectedFrac;

//   @override
//   void initState() {
//     super.initState();
//     selectedInt = widget.initial;
//     selectedFrac = 0;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 300,
//       padding: const EdgeInsets.only(top: 16),
//       decoration: const BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//       ),
//       child: Column(
//         children: [
//           Text(
//             widget.title,
//             style: GoogleFonts.poppins(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           Expanded(
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 // Integer picker
//                 Expanded(
//                   child: ListWheelScrollView.useDelegate(
//                     itemExtent: 40,
//                     onSelectedItemChanged: (i) =>
//                         setState(() => selectedInt = widget.min + i),
//                     physics: const FixedExtentScrollPhysics(),
//                     controller: FixedExtentScrollController(
//                       initialItem: widget.initial - widget.min,
//                     ),
//                     childDelegate: ListWheelChildBuilderDelegate(
//                       builder: (context, idx) {
//                         final value = widget.min + idx;
//                         if (value > widget.max) return null;
//                         return Center(
//                           child: Text(
//                             '$value',
//                             style: GoogleFonts.poppins(fontSize: 16),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 ),
//                 if (widget.fractionDigits > 0)
//                   Expanded(
//                     child: ListWheelScrollView(
//                       itemExtent: 40,
//                       onSelectedItemChanged: (i) =>
//                           setState(() => selectedFrac = i),
//                       physics: const FixedExtentScrollPhysics(),
//                       children: List.generate(
//                         10,
//                         (i) => Center(
//                           child: Text(
//                             '.\$i',
//                             style: GoogleFonts.poppins(fontSize: 16),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 8),
//                   child: Text(
//                     widget.suffix,
//                     style: GoogleFonts.poppins(fontSize: 16),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               TextButton(
//                 onPressed: () => Navigator.pop(context),
//                 child: Text(
//                   'Cancel',
//                   style: GoogleFonts.poppins(color: Colors.green),
//                 ),
//               ),
//               TextButton(
//                 onPressed: () {
//                   final double value = widget.fractionDigits > 0
//                       ? selectedInt +
//                             selectedFrac / (10 * widget.fractionDigits)
//                       : selectedInt.toDouble();
//                   Navigator.pop(context, value);
//                 },
//                 child: Text(
//                   'OK',
//                   style: GoogleFonts.poppins(color: Colors.green),
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 16),
//         ],
//       ),
//     );
//   }
// }




// lib/features/profile/profile_page.dart

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// String extension to capitalize the first letter
extension StringExtension on String {
  String capitalize() {
    if (isEmpty) return this;
    return substring(0, 1).toUpperCase() + substring(1);
  }
}

/// Available genders
enum Gender { male, female, other }

/// Units
enum UnitSystem { metric, imperial }

/// Controller for profile settings, persists to SharedPreferences
class ProfilePageController extends ChangeNotifier {
  String name = '';
  Gender gender = Gender.male;
  int age = 24;
  double height = 175; // cm or in
  double weight = 70.0; // kg or lb
  UnitSystem units = UnitSystem.metric;

  ProfilePageController() {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    name = prefs.getString('profile_name') ?? name;
    gender = Gender.values[prefs.getInt('profile_gender') ?? gender.index];
    age = prefs.getInt('profile_age') ?? age;
    height = prefs.getDouble('profile_height') ?? height;
    weight = prefs.getDouble('profile_weight') ?? weight;
    units = UnitSystem.values[prefs.getInt('profile_units') ?? units.index];
    notifyListeners();
  }

  Future<void> updateName(String newName) async {
    name = newName;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('profile_name', name);
    notifyListeners();
  }

  Future<void> updateGender(Gender newGender) async {
    gender = newGender;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('profile_gender', gender.index);
    notifyListeners();
  }

  Future<void> updateAge(int newAge) async {
    age = newAge;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('profile_age', age);
    notifyListeners();
  }

  Future<void> updateHeight(double newHeight) async {
    height = newHeight;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('profile_height', height);
    notifyListeners();
  }

  Future<void> updateWeight(double newWeight) async {
    weight = newWeight;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('profile_weight', weight);
    notifyListeners();
  }

  Future<void> updateUnits(UnitSystem newUnits) async {
    units = newUnits;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('profile_units', units.index);
    notifyListeners();
  }
}

final profileControllerProvider = ChangeNotifierProvider(
  (_) => ProfilePageController(),
);

class ProfilePage extends ConsumerWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ctrl = ref.watch(profileControllerProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(color: Colors.black),
        // title: Text(
        //   'Profile',
        //   style: GoogleFonts.poppins(
        //     fontSize: 24,
        //     fontWeight: FontWeight.bold,
        //     color: Colors.black,
        //   ),
        // ),
      ),
      body: ctrl.name.isEmpty && ctrl.age == 0
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                Text(
                  'Profile',
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Divider(),
                _buildRow(
                  context,
                  label: 'Name',
                  value: ctrl.name,
                  onTap: () => _editName(context, ctrl),
                ),
                _divider(),
                _buildRow(
                  context,
                  label: 'Gender',
                  value: ctrl.gender.name.capitalize(),
                  onTap: () => _editGender(context, ctrl),
                ),
                _divider(),
                _buildRow(
                  context,
                  label: 'Age',
                  value: '${ctrl.age}',
                  onTap: () => _editAge(context, ctrl),
                ),
                _divider(),
                _buildRow(
                  context,
                  label: 'Height',
                  value:
                      '${ctrl.height.toStringAsFixed(0)} ${ctrl.units == UnitSystem.metric ? 'cm' : 'in'}',
                  onTap: () => _editHeight(context, ctrl),
                ),
                _divider(),
                _buildRow(
                  context,
                  label: 'Weight',
                  value:
                      '${ctrl.weight.toStringAsFixed(1)} ${ctrl.units == UnitSystem.metric ? 'kg' : 'lb'}',
                  onTap: () => _editWeight(context, ctrl),
                ),
                _divider(),
                _buildRow(
                  context,
                  label: 'Units',
                  value: ctrl.units == UnitSystem.metric
                      ? 'Metric'
                      : 'Imperial',
                  onTap: () => _editUnits(context, ctrl),
                ),
                const SizedBox(height: 24),
                Text(
                  'These settings affect your personal program. We store it on our servers to better understand our audience but never share any of this information with anyone else.',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
    );
  }

  Widget _divider() => Divider(color: Colors.grey.shade300, thickness: 1);

  Widget _buildRow(
    BuildContext context, {
    required String label,
    required String value,
    required VoidCallback onTap,
  }) => ListTile(
    contentPadding: EdgeInsets.zero,
    title: Text(
      label,
      style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
    ),
    trailing: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(value, style: GoogleFonts.poppins(fontSize: 16)),
        const SizedBox(width: 8),
        const Icon(Icons.chevron_right, color: Colors.black54),
      ],
    ),
    onTap: onTap,
  );

  // --- Field editors below ---

  void _editName(BuildContext context, ProfilePageController ctrl) {
    final tc = TextEditingController(text: ctrl.name);
    showDialog<String>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Name', style: GoogleFonts.poppins(fontSize: 18)),
        content: TextField(
          controller: tc,
          decoration: const InputDecoration(border: OutlineInputBorder()),
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
              ctrl.updateName(tc.text.trim());
              Navigator.pop(context);
            },
            child: Text('OK', style: GoogleFonts.poppins(color: Colors.green)),
          ),
        ],
      ),
    );
  }

  void _editGender(BuildContext context, ProfilePageController ctrl) async {
    final result = await showDialog<Gender>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Gender', style: GoogleFonts.poppins(fontSize: 18)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: Gender.values
              .map(
                (g) => RadioListTile<Gender>(
                  value: g,
                  groupValue: ctrl.gender,
                  title: Text(g.name.capitalize()),
                  onChanged: (v) => Navigator.pop(context, v),
                ),
              )
              .toList(),
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
            onPressed: () => Navigator.pop(context, ctrl.gender),
            child: Text('OK', style: GoogleFonts.poppins(color: Colors.green)),
          ),
        ],
      ),
    );
    if (result != null && result != ctrl.gender) {
      ctrl.updateGender(result);
    }
  }

  void _editAge(BuildContext context, ProfilePageController ctrl) async {
    final result = await showModalBottomSheet<int>(
      context: context,
      builder: (_) => _NumberPickerSheet(
        title: 'Age',
        min: 10,
        max: 100,
        initial: ctrl.age,
        suffix: '',
      ),
    );
    if (result != null && result != ctrl.age) {
      ctrl.updateAge(result);
    }
  }

  void _editHeight(BuildContext context, ProfilePageController ctrl) async {
    final result = await showModalBottomSheet<double>(
      context: context,
      builder: (_) => _NumberPickerSheet(
        title: 'Height',
        min: ctrl.units == UnitSystem.metric ? 100 : 40,
        max: ctrl.units == UnitSystem.metric ? 220 : 90,
        initial: ctrl.height.toInt(),
        suffix: ctrl.units == UnitSystem.metric ? 'cm' : 'in',
      ),
    );
    if (result != null) ctrl.updateHeight(result);
  }

  void _editWeight(BuildContext context, ProfilePageController ctrl) async {
    final result = await showModalBottomSheet<double>(
      context: context,
      builder: (_) => _NumberPickerSheet(
        title: 'Weight',
        min: ctrl.units == UnitSystem.metric ? 30 : 60,
        max: ctrl.units == UnitSystem.metric ? 200 : 400,
        initial: ctrl.weight.toInt(),
        suffix: ctrl.units == UnitSystem.metric ? 'kg' : 'lb',
        fractionDigits: ctrl.units == UnitSystem.metric ? 1 : 0,
      ),
    );
    if (result != null) ctrl.updateWeight(result);
  }

  void _editUnits(BuildContext context, ProfilePageController ctrl) async {
    final result = await showDialog<UnitSystem>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Units', style: GoogleFonts.poppins(fontSize: 18)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: UnitSystem.values
              .map(
                (u) => RadioListTile<UnitSystem>(
                  value: u,
                  groupValue: ctrl.units,
                  title: Text(u == UnitSystem.metric ? 'Metric' : 'Imperial'),
                  onChanged: (v) => Navigator.pop(context, v),
                ),
              )
              .toList(),
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
            onPressed: () => Navigator.pop(context, ctrl.units),
            child: Text('OK', style: GoogleFonts.poppins(color: Colors.green)),
          ),
        ],
      ),
    );
    if (result != null && result != ctrl.units) {
      ctrl.updateUnits(result);
    }
  }
}

/// Bottom sheet widget for picking numbers
class _NumberPickerSheet extends StatefulWidget {
  final String title;
  final int min;
  final int max;
  final int initial;
  final String suffix;
  final int fractionDigits;

  const _NumberPickerSheet({
    required this.title,
    required this.min,
    required this.max,
    required this.initial,
    required this.suffix,
    this.fractionDigits = 0,
  });

  @override
  _NumberPickerSheetState createState() => _NumberPickerSheetState();
}

class _NumberPickerSheetState extends State<_NumberPickerSheet> {
  late int selectedInt;
  late int selectedFrac;

  @override
  void initState() {
    super.initState();
    selectedInt = widget.initial;
    selectedFrac = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      padding: const EdgeInsets.only(top: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        children: [
          Text(
            widget.title,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // integer wheel
                Expanded(
                  child: ListWheelScrollView.useDelegate(
                    itemExtent: 40,
                    onSelectedItemChanged: (i) =>
                        setState(() => selectedInt = widget.min + i),
                    physics: const FixedExtentScrollPhysics(),
                    controller: FixedExtentScrollController(
                      initialItem: widget.initial - widget.min,
                    ),
                    childDelegate: ListWheelChildBuilderDelegate(
                      builder: (ctx, idx) {
                        final v = widget.min + idx;
                        return v > widget.max
                            ? null
                            : Center(
                                child: Text(
                                  '$v',
                                  style: GoogleFonts.poppins(fontSize: 16),
                                ),
                              );
                      },
                    ),
                  ),
                ),
                if (widget.fractionDigits > 0)
                  Expanded(
                    child: ListWheelScrollView(
                      itemExtent: 40,
                      onSelectedItemChanged: (i) =>
                          setState(() => selectedFrac = i),
                      physics: const FixedExtentScrollPhysics(),
                      children: List.generate(
                        10,
                        (i) => Center(
                          child: Text(
                            '.$i',
                            style: GoogleFonts.poppins(fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text(
                    widget.suffix,
                    style: GoogleFonts.poppins(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
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
                  final val = widget.fractionDigits > 0
                      ? selectedInt + selectedFrac / 10
                      : selectedInt.toDouble();
                  Navigator.pop(context, val);
                },
                child: Text(
                  'OK',
                  style: GoogleFonts.poppins(color: Colors.green),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
// This code defines a profile page for a fitness app where users can set their personal information