import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:fitness_app/services/exercise_api_services.dart';
import 'package:go_router/go_router.dart';

class AddExercisePage extends StatefulWidget {
  final String target;
  const AddExercisePage({Key? key, this.target = 'quads'}) : super(key: key);

  @override
  _AddExercisePageState createState() => _AddExercisePageState();
}

class _AddExercisePageState extends State<AddExercisePage> {
  final _apiService = ExerciseApiService();
  late Future<List<Exercise>> _futureExercises;
  final Set<String> _selectedIds = {};

  @override
  void initState() {
    super.initState();
    _futureExercises = _apiService.fetchExercisesByMuscle(widget.target);
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
    final isAnySelected = _selectedIds.isNotEmpty;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Add Exercise', style: TextStyle(color: Colors.black87, fontSize: 20, fontWeight: FontWeight.w600)),
      ),
      body: FutureBuilder<List<Exercise>>(
        future: _futureExercises,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: \${snapshot.error}'));
          }
          final exercises = snapshot.data!;
          // total items = exercises + 3 footer options
          final totalCount = exercises.length + 3;
          return ListView.separated(
            padding: const EdgeInsets.only(bottom: 120),
            itemCount: totalCount + 2, // +2 for search bar & header
            separatorBuilder: (_, __) => const SizedBox(height: 1),
            itemBuilder: (context, index) {
              if (index == 0) {
                // Search bar
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.search, color: Colors.grey.shade600),
                        const SizedBox(width: 8),
                        Text(
                          'Search',
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                  ),
                );
              }
              if (index == 1) {
                // Header text
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'EXERCISES WITH SIMILAR MUSCLE FOCUS',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              }
              // Exercise items
              final itemIndex = index - 2;
              if (itemIndex < exercises.length) {
                final ex = exercises[itemIndex];
                final isSelected = _selectedIds.contains(ex.exerciseId);
                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  leading: SizedBox(
                    width: 64,
                    height: 64,
                    child: FutureBuilder<Uint8List>(
                      future: _apiService.fetchExerciseImageBytes(
                        ex.exerciseId,
                      ),
                      builder: (ctx, snap) {
                        if (snap.connectionState != ConnectionState.done ||
                            !snap.hasData) {
                          return Container(color: Colors.grey.shade200);
                        }
                        return FutureBuilder<ui.Image>(
                          future: decodeImageFromList(snap.data!),
                          builder: (ctx2, frameSnap) {
                            if (frameSnap.connectionState !=
                                    ConnectionState.done ||
                                frameSnap.data == null) {
                              return Container(color: Colors.grey.shade200);
                            }
                            return RawImage(
                              image: frameSnap.data,
                              width: 64,
                              height: 64,
                              fit: BoxFit.cover,
                            );
                          },
                        );
                      },
                    ),
                  ),
                  title: Text(
                    ex.name,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  trailing: Checkbox(
                    value: isSelected,
                    onChanged: (_) => _toggleSelection(ex.exerciseId),
                  ),
                  onTap: () => _toggleSelection(ex.exerciseId),
                );
              }
              // Footer items
              final footerIndex = itemIndex - exercises.length;
              switch (footerIndex) {
                case 0:
                  return ListTile(
                    leading: const Icon(Icons.fitness_center),
                    title: const Text('All Exercises'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => context.push('/all-exercises'),
                  );
                case 1:
                  return ListTile(
                    leading: const Icon(Icons.accessibility),
                    title: const Text('By Muscle Group'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => context.push(
                      '/exercises-by-muscles',
                    ),
                  );
                case 2:
                  return ListTile(
                    leading: const Icon(Icons.build),
                    title: const Text('By Equipment'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: ()=> context.push(
                      '/exercises-by-equipement',
                    ),
                  );
                default:
                  return const SizedBox.shrink();
              }
            },
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isAnySelected
                      ? () => Navigator.pop(context, _selectedIds.toList())
                      : null,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      
                    ),
                    backgroundColor: isAnySelected ? Colors.black : Colors.grey.shade300,
                  ),
                  child: Text(isAnySelected ? 'Add Exercise' : 'Add Exercises', style: TextStyle(color: isAnySelected
                          ? Colors.white
                          : Colors.black,
                      )),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: isAnySelected ? () {} : null,
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    side: BorderSide(color: Colors.grey.shade300),
                  ),
                  child: const Text('Group as Circuit', style: TextStyle(color: Colors.black),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
