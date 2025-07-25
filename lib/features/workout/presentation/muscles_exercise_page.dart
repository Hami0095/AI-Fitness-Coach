import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:fitness_app/services/exercise_api_services.dart';

class MuscleExercisesPage extends StatefulWidget {
  final String muscle;
  const MuscleExercisesPage({Key? key, required this.muscle}) : super(key: key);

  @override
  _MuscleExercisesPageState createState() => _MuscleExercisesPageState();
}

class _MuscleExercisesPageState extends State<MuscleExercisesPage> {
  final _apiService = ExerciseApiService();
  late Future<List<Exercise>> _futureExercises;
  final Set<String> _selectedIds = {};

  @override
  void initState() {
    super.initState();
    _futureExercises = _apiService.fetchExercisesByBodyPart(widget.muscle);
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
    final count = _selectedIds.length;
    final btnText = count > 0
        ? 'Add $count Exercise${count > 1 ? 's' : ''}'
        : 'Add Exercises';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context, _selectedIds.toList()),
        ),
        title: Text(
          '${widget.muscle} Exercises',
          style: const TextStyle(color: Colors.black87),
        ),
      ),
      body: FutureBuilder<List<Exercise>>(
        future: _futureExercises,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final exercises = snapshot.data!;
          if (exercises.isEmpty) {
            return Center(
              child: Text('No exercises found for ${widget.muscle}'),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.only(bottom: 100),
            itemCount: exercises.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final ex = exercises[index];
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
                    future: _apiService.fetchExerciseImageBytes(ex.exerciseId),
                    builder: (ctx, snap) {
                      if (snap.connectionState != ConnectionState.done ||
                          !snap.hasData) {
                        return Container(color: Colors.grey.shade200);
                      }
                      return FutureBuilder<ui.Image>(
                        future: decodeImageFromList(snap.data!),
                        builder: (ctx2, frame) {
                          if (frame.connectionState != ConnectionState.done ||
                              frame.data == null) {
                            return Container(color: Colors.grey.shade200);
                          }
                          return RawImage(
                            image: frame.data,
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
            },
          );
        },
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _selectedIds.isNotEmpty
                      ? () => Navigator.pop(context, _selectedIds.toList())
                      : null,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(btnText),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: _selectedIds.isNotEmpty ? () {} : null,
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    side: BorderSide(color: Colors.grey.shade300),
                  ),
                  child: const Text('Group Circuit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
