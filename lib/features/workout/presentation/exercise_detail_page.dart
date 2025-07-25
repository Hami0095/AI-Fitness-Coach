// import 'dart:typed_data';
// import 'package:fitness_app/services/exercise_api_services.dart';
// import 'package:flutter/material.dart';


// class ExerciseDetailPage extends StatefulWidget {
//   final String exerciseId;

//   const ExerciseDetailPage({Key? key, required this.exerciseId}) : super(key: key);

//   @override
//   _ExerciseDetailPageState createState() => _ExerciseDetailPageState();
// }

// class _ExerciseDetailPageState extends State<ExerciseDetailPage> {
//   late final ExerciseApiService _apiService;
//   late Future<Exercise> _exerciseFuture;
//   late Future<Uint8List> _imageFuture;

//   @override
//   void initState() {
//     super.initState();
//     _apiService = ExerciseApiService();
//     _exerciseFuture = _apiService.fetchExerciseById(widget.exerciseId);
//     _imageFuture = _apiService.fetchExerciseImageBytes(widget.exerciseId);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title:  Text('Exercise Details'),
//         backgroundColor: Colors.black,
//         foregroundColor: Colors.white,
//       ),
//       body: FutureBuilder<Exercise>(
//         future: _exerciseFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           }
//           final exercise = snapshot.data!;
//           return SingleChildScrollView(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // GIF Image
//                 FutureBuilder<Uint8List>(
//                   future: _imageFuture,
//                   builder: (context, imgSnap) {
//                     if (imgSnap.connectionState == ConnectionState.waiting) {
//                       return const SizedBox(
//                         height: 200,
//                         child: Center(child: CircularProgressIndicator()),
//                       );
//                     } else if (imgSnap.hasError) {
//                       return const SizedBox(
//                         height: 200,
//                         child: Center(child: Icon(Icons.broken_image)),
//                       );
//                     }
//                     return Image.memory(
//                       imgSnap.data!,
//                       width: double.infinity,
//                       height: MediaQuery.of(context).size.height * 0.3,
//                       fit: BoxFit.fitHeight,
//                     );
//                   },
//                 ),
//                 const SizedBox(height: 16),
//                 // Body Part
//                 Text(
//                   'Body Part: ${exercise.bodyParts.join(', ')}',
//                   style: Theme.of(context).textTheme.labelLarge,
//                 ),
//                 const SizedBox(height: 8),
//                 // Primary Muscles
//                 Divider(
//                   color: Colors.grey,
//                   thickness: 1,
//                   indent: 16,
//                   endIndent: 16,
//                 ),
//                 Text(
//                   'Primary Muscles: ${exercise.targetMuscles.join(', ')}',
//                   style: Theme.of(context).textTheme.labelLarge,
//                 ),
//                 const SizedBox(height: 8),
//                 Divider(
//                   color: Colors.grey,
//                   thickness: 1,
//                   indent: 16,
//                   endIndent: 16,
//                 ),
//                 // Secondary Muscles
//                 if (exercise.secondaryMuscles.isNotEmpty) ...[
//                   Text(
//                     'Secondary Muscles: ${exercise.secondaryMuscles.join(', ')}',
//                     style: Theme.of(context).textTheme.labelLarge,
//                   ),
//                   const SizedBox(height: 8),
//                   Divider(
//                     color: Colors.grey,
//                     thickness: 1,
//                     indent: 16,
//                     endIndent: 16,
//                   ),
//                 ],
//                 // Equipment
//                 if (exercise.equipments.isNotEmpty) ...[
//                   Text(
//                     'Equipment: ${exercise.equipments.join(', ')}',
//                     style: Theme.of(context).textTheme.labelLarge,
//                   ),
//                   const SizedBox(height: 16),
//                   Divider(
//                     color: Colors.black,
//                     thickness: 2,

//                   ),
//                 ],
//                 // Description
//                 Text(
//                   'Description',
//                   style: Theme.of(context).textTheme.headlineSmall,
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   exercise.description ?? '',
//                   style: Theme.of(context).textTheme.bodyMedium,
//                 ),
//                 const SizedBox(height: 16),
//                 // Instructions
//                 Text(
//                   'Instructions',
//                   style: Theme.of(context).textTheme.headlineSmall,
//                 ),
//                 const SizedBox(height: 4),
//                 ...List.generate(
//                   exercise.instructions.length,
//                   (index) => Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 4),
//                     child: Text(
//                       '${index + 1}. ${exercise.instructions[index]}',
//                       style: Theme.of(context).textTheme.bodyMedium,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 // Category & Difficulty
//                 Wrap(
//                   spacing: 8,
//                   children: [
//                     Chip(label: Text('Category: ${exercise.category}', style: TextStyle(color: const Color.fromARGB(255, 26, 234, 15),
//                         ),), backgroundColor: const Color.fromARGB(255, 97, 97, 97),),
//                     Chip(label: Text('Difficulty: ${exercise.difficulty}', style: TextStyle(color: const Color.fromARGB(255, 26, 234, 15)),), backgroundColor: const Color.fromARGB(255, 97, 97, 97),),  
//                   ],
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }




import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fitness_app/services/exercise_api_services.dart';

class ExerciseDetailPage extends StatefulWidget {
  final String exerciseId;

  const ExerciseDetailPage({Key? key, required this.exerciseId})
    : super(key: key);

  @override
  _ExerciseDetailPageState createState() => _ExerciseDetailPageState();
}

class _ExerciseDetailPageState extends State<ExerciseDetailPage> {
  late final ExerciseApiService _apiService;
  late Future<Exercise> _exerciseFuture;
  late Future<Uint8List> _imageFuture;

  @override
  void initState() {
    super.initState();
    _apiService = ExerciseApiService();
    _exerciseFuture = _apiService.fetchExerciseById(widget.exerciseId);
    _imageFuture = _apiService.fetchExerciseImageBytes(widget.exerciseId);
  }

  Widget _detailTile(IconData icon, String label, String value) {
    return ListTile(
      leading: Icon(icon, color: Colors.teal),
      title: Text(
        label,
        style: GoogleFonts.lato(fontWeight: FontWeight.bold, fontSize: 14),
      ),
      subtitle: Text(value, style: GoogleFonts.lato(fontSize: 13, height: 1.3)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      
      body: FutureBuilder<Exercise>(
        future: _exerciseFuture,
        builder: (context, snapEx) {
          if (snapEx.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapEx.hasError) {
            return Center(child: Text('Error: ${snapEx.error}'));
          }
          final exercise = snapEx.data!;
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                expandedHeight: MediaQuery.of(context).size.height * 0.4,
                backgroundColor: Colors.black,
                iconTheme: const IconThemeData(color: Colors.green),
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.parallax,
                  background: FutureBuilder<Uint8List>(
                    future: _imageFuture,
                    builder: (ctx, snapImg) {
                      if (snapImg.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapImg.hasError) {
                        return const Center(
                          child: Icon(Icons.broken_image, size: 60),
                        );
                      }
                      return Image.memory(
                        snapImg.data!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      );
                    },
                  ),
                ),
              ),

              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Text(
                        exercise.name.toUpperCase(),
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lato(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              SliverPadding(
                padding: const EdgeInsets.all(16),
                
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    // Metadata card
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      color: Colors.white,
                      elevation: 4,
                      child: Column(
                        children: [
                          _detailTile(
                            Icons.accessibility,
                            'Body Part',
                            exercise.bodyParts.join(', '),
                          ),
                          const Divider(height: 1),
                          _detailTile(
                            Icons.fitness_center,
                            'Primary Muscles',
                            exercise.targetMuscles.join(', '),
                          ),
                          if (exercise.secondaryMuscles.isNotEmpty) ...[
                            const Divider(height: 1),
                            _detailTile(
                              Icons.star_outline,
                              'Secondary Muscles',
                              exercise.secondaryMuscles.join(', '),
                            ),
                          ],
                          const Divider(height: 1),
                          _detailTile(
                            Icons.build,
                            'Equipment',
                            exercise.equipments.join(', '),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Description card
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Description',
                              style: GoogleFonts.lato(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              exercise.description ?? '',
                              style: GoogleFonts.lato(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Instructions expansion
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                      color: Colors.white,
                      child: ExpansionTile(
                        title: Text(
                          'Instructions',
                          style: GoogleFonts.lato(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        children: exercise.instructions
                            .asMap()
                            .entries
                            .map(
                              (e) => ListTile(
                                leading: CircleAvatar(
                                  radius: 12,
                                  backgroundColor: Colors.teal,
                                  child: Text(
                                    '${e.key + 1}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                title: Text(
                                  e.value,
                                  style: GoogleFonts.lato(fontSize: 14),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 4,
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Chips
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        Chip(
                          label: Text(
                            'Category: ${exercise.category}',
                            style: GoogleFonts.lato(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          backgroundColor: Colors.teal,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                        ),
                        Chip(
                          label: Text(
                            'Difficulty: ${exercise.difficulty}',
                            style: GoogleFonts.lato(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          backgroundColor: Colors.orange,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 32),
                  ]),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
