import 'package:flutter/material.dart';
import 'package:fitness_app/services/exercise_api_services.dart';
import 'package:go_router/go_router.dart';

class ExercisesByEquipmentPage extends StatefulWidget {
  const ExercisesByEquipmentPage({Key? key}) : super(key: key);

  @override
  _ExercisesByEquipmentPageState createState() =>
      _ExercisesByEquipmentPageState();
}

class _ExercisesByEquipmentPageState extends State<ExercisesByEquipmentPage> {
  final _apiService = ExerciseApiService();
  late Future<List<NameItem>> _futureEquip;
  String _searchTerm = '';

  @override
  void initState() {
    super.initState();
    _futureEquip = _apiService.fetchEquipments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'By Equipment',
          style: TextStyle(color: Colors.black87),
        ),
      ),
      body: FutureBuilder<List<NameItem>>(
        future: _futureEquip,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          // Filter and sort
          final list =
              snapshot.data!
                  .where(
                    (e) => e.name.toLowerCase().contains(
                      _searchTerm.toLowerCase(),
                    ),
                  )
                  .toList()
                ..sort((a, b) => a.name.compareTo(b.name));

          // Group by first letter
          final Map<String, List<NameItem>> sections = {};
          for (var eq in list) {
            final letter = eq.name[0].toUpperCase();
            sections.putIfAbsent(letter, () => []).add(eq);
          }
          final sortedKeys = sections.keys.toList()..sort();

          // Total count including headers
          final itemCount = sortedKeys.fold<int>(
            0,
            (sum, key) => sum + 1 + sections[key]!.length,
          );

          return ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: itemCount + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                // Search bar
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    onChanged: (val) => setState(() => _searchTerm = val),
                    decoration: InputDecoration(
                      hintText: 'Search',
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      contentPadding: const EdgeInsets.symmetric(vertical: 0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                );
              }

              int cursor = 0;
              for (var key in sortedKeys) {
                // Section header
                if (index == cursor + 1) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Text(
                      key,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }
                cursor += 1;

                final items = sections[key]!;
                // Equipment items
                if (index <= cursor + items.length) {
                  final eq = items[index - cursor - 1];
                  return ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    title: Text(
                      eq.name,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    trailing: const Icon(Icons.chevron_right),  
                    onTap: () => context.push('/equipment/${eq.name}'),
                  );
                }
                cursor += items.length;
              }

              return const SizedBox.shrink();
            },
          );
        },
      ),
    );
  }
}
