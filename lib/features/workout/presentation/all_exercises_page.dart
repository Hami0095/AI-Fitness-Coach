import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:fitness_app/services/exercise_api_services.dart';

class AllExercisesPage extends StatefulWidget {
  const AllExercisesPage({Key? key}) : super(key: key);

  @override
  _AllExercisesPageState createState() => _AllExercisesPageState();
}

class _AllExercisesPageState extends State<AllExercisesPage> {
  final _apiService = ExerciseApiService();
  late Future<List<Exercise>> _futureAll;
  final Set<String> _selectedIds = {};
  String _searchTerm = '';

  @override
  void initState() {
    super.initState();
    _futureAll = _apiService.fetchAllExercises();
  }

  void _toggleSelection(String id) {
    setState(() {
      if (_selectedIds.contains(id)) {
        _selectedIds.remove(id);
      } else {
        _selectedIds.add(id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isAny = _selectedIds.isNotEmpty;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context, _selectedIds.toList()),
        ),
        title: Text('All Exercises', style: TextStyle(color: Colors.black87)),
      ),
      body: FutureBuilder<List<Exercise>>(
        future: _futureAll,
        builder: (context, snap) {
          if (snap.connectionState != ConnectionState.done)
            return Center(child: CircularProgressIndicator());
          if (snap.hasError)
            return Center(child: Text('Error: \${snap.error}'));

          // filter & sort
          final list =
              snap.data!
                  .where(
                    (e) => e.name.toLowerCase().contains(
                      _searchTerm.toLowerCase(),
                    ),
                  )
                  .toList()
                ..sort((a, b) => a.name.compareTo(b.name));

          // group by first letter
          final Map<String, List<Exercise>> sections = {};
          for (var ex in list) {
            final letter = ex.name[0].toUpperCase();
            sections.putIfAbsent(letter, () => []).add(ex);
          }
          final sortedKeys = sections.keys.toList()..sort();

          return Column(
            children: [
              // Search bar
              Padding(
                padding: EdgeInsets.all(16),
                child: TextField(
                  onChanged: (val) => setState(() => _searchTerm = val),
                  decoration: InputDecoration(
                    hintText: 'Search',
                    prefixIcon: Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    contentPadding: EdgeInsets.symmetric(vertical: 0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.only(bottom: 120),
                  itemCount: sortedKeys.fold<int>(
                    0,
                    (prev, key) => prev + 1 + sections[key]!.length,
                  ),
                  itemBuilder: (context, i) {
                    int count = 0;
                    for (var key in sortedKeys) {
                      // header
                      if (i == count) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          child: Text(
                            key,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      }
                      count++;
                      // items
                      final items = sections[key]!;
                      if (i < count + items.length) {
                        final ex = items[i - count];
                        final sel = _selectedIds.contains(ex.exerciseId);
                        return ListTile(
                          leading: SizedBox(
                            width: 64,
                            height: 64,
                            child: FutureBuilder<Uint8List>(
                              future: _apiService.fetchExerciseImageBytes(
                                ex.exerciseId,
                              ),
                              builder: (ctx, snap2) {
                                if (!snap2.hasData)
                                  return Container(color: Colors.grey.shade200);
                                return FutureBuilder<ui.Image>(
                                  future: decodeImageFromList(snap2.data!),
                                  builder: (_, frame) {
                                    if (!frame.hasData)
                                      return Container(
                                        color: Colors.grey.shade200,
                                      );
                                    return RawImage(
                                      image: frame.data,
                                      fit: BoxFit.cover,
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                          title: Text(
                            ex.name,
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          trailing: Checkbox(
                            value: sel,
                            onChanged: (_) => _toggleSelection(ex.exerciseId),
                          ),
                          onTap: () => _toggleSelection(ex.exerciseId),
                        );
                      }
                      count += items.length;
                    }
                    return SizedBox.shrink();
                  },
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: isAny
                    ? () => Navigator.pop(context, _selectedIds.toList())
                    : null,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 16),
                  minimumSize: Size(double.infinity, 0),
                ),
                child: Text('Add Exercise'),
              ),
              SizedBox(height: 8),
              OutlinedButton(
                onPressed: isAny ? () {} : null,
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 16),
                  side: BorderSide(color: Colors.grey.shade300),
                  minimumSize: Size(double.infinity, 0),
                ),
                child: Text('Group as Circuit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
