import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:fitness_app/services/exercise_api_services.dart';
import 'package:go_router/go_router.dart';
import 'replace_exercise_page.dart';

class WorkoutPlanPage extends StatefulWidget {
  final String target;
  const WorkoutPlanPage({super.key, this.target = 'quads'});

  @override
  // ignore: library_private_types_in_public_api
  _WorkoutPlanPageState createState() => _WorkoutPlanPageState();
}

class _WorkoutPlanPageState extends State<WorkoutPlanPage> {
  final ScrollController _scrollController = ScrollController();
  bool _headerCollapsed = false;
  late Future<List<Exercise>> _futureExercises;
  final _apiService = ExerciseApiService();

  @override
  void initState() {
    super.initState();
    _futureExercises = _apiService
        .fetchExercisesByMuscle(widget.target)
        .then((list) => list.take(6).toList());

    _scrollController.addListener(() {
      final collapsed = _scrollController.offset > 200;
      if (collapsed != _headerCollapsed) {
        setState(() => _headerCollapsed = collapsed);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onReorder(int oldIndex, int newIndex, List<Exercise> items) {
    setState(() {
      if (newIndex > oldIndex) newIndex--;
      final item = items.removeAt(oldIndex);
      items.insert(newIndex, item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder<List<Exercise>>(
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
                  child: Text('No exercises found for ${widget.target}'),
                );
              }
              print("Exercises: ${exercises}");
              // Aggregate secondary muscles
              final secondarySet = <String>{};
              for (var ex in exercises) {
                print("${ex.secondaryMuscles}");
                secondarySet.addAll(ex.secondaryMuscles);
              }
              final secondaryList = secondarySet.join(', ');
              final primaryLabel =
                  widget.target[0].toUpperCase() + widget.target.substring(1);

              return CustomScrollView(
                controller: _scrollController,
                slivers: [
                  SliverAppBar(
                    pinned: true,
                    expandedHeight: 260,
                    elevation: 0,
                    automaticallyImplyLeading: false,
                    backgroundColor: Colors.transparent,
                    flexibleSpace: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [ui.Color.fromARGB(255, 10, 61, 0),  ui.Color.fromARGB(255, 21, 23, 21)],
                        ),
                      ),
                      child: FlexibleSpaceBar(
                        collapseMode: CollapseMode.pin,
                        titlePadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                        title: AnimatedOpacity(
                          duration: const Duration(milliseconds: 200),
                          opacity: _headerCollapsed ? 1.0 : 0.0,
                          child: const Text(
                            'Workout',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        background: Padding(
                          padding: const EdgeInsets.fromLTRB(16, 80, 16, 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                '8 min',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 48,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Core, Quadriceps, Triceps',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 12),
                              Row(
                                children: [
                                  Icon(
                                    Icons.fitness_center,
                                    color: Colors.white70,
                                    size: 16,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    'Medium Intensity',
                                    style: TextStyle(color: Colors.white70),
                                  ),
                                  SizedBox(width: 16),
                                  Icon(
                                    Icons.whatshot,
                                    color: Colors.white70,
                                    size: 16,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    'Strength',
                                    style: TextStyle(color: Colors.white70),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    actions: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close, color: Colors.white),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.bookmark_border,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),

                  SliverToBoxAdapter(
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(24),
                        ),
                      ),
                      transform: Matrix4.translationValues(0, -24, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 32),
                          // "What you'll need" and Add section unchanged...
                          const SizedBox(height: 24),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${exercises.length} Exercises',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => context.push('/add-exercise'),                                  
                                  child: Row(
                                    children: const [
                                      Text(
                                        'Add',
                                        style: TextStyle(
                                          color: Color(0xFF1E88E5),
                                        ),
                                      ),
                                      SizedBox(width: 4),
                                      Icon(
                                        Icons.add_circle,
                                        color: Color(0xFF1E88E5),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              'CIRCUIT, 1 ROUNDS',
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Reorderable list of exercises
                          ReorderableListView(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            onReorder: (o, n) => _onReorder(o, n, exercises),
                            children: [
                              for (int i = 0; i < exercises.length; i++)
                                Dismissible(
                                  key: ValueKey(exercises[i].exerciseId),
                                  direction: DismissDirection.endToStart,
                                  onDismissed: (_) =>
                                      setState(() => exercises.removeAt(i)),
                                  background: Container(
                                    alignment: Alignment.centerRight,
                                    color: Colors.red,
                                    padding: const EdgeInsets.only(right: 24),
                                    child: const Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                    ),
                                  ),
                                  child: ListTile(
                                    key: ValueKey('exercise_\$i'),
                                    leading: SizedBox(
                                      width: 64,
                                      height: 64,
                                      child: Stack(
                                        alignment: Alignment.bottomRight,
                                        children: [
                                          FutureBuilder<Uint8List>(
                                            future: _apiService
                                                .fetchExerciseImageBytes(
                                                  exercises[i].exerciseId,
                                                ),
                                            builder: (ctx, snap) {
                                              if (snap.connectionState !=
                                                      ConnectionState.done ||
                                                  !snap.hasData) {
                                                return Container(
                                                  width: 64,
                                                  height: 64,
                                                  color: Colors.grey.shade200,
                                                );
                                              }
                                              return FutureBuilder<ui.Image>(
                                                future: decodeImageFromList(
                                                  snap.data!,
                                                ),
                                                builder: (ctx2, frameSnap) {
                                                  if (frameSnap
                                                              .connectionState !=
                                                          ConnectionState
                                                              .done ||
                                                      frameSnap.data == null) {
                                                    return Container(
                                                      width: 64,
                                                      height: 64,
                                                      color:
                                                          Colors.grey.shade200,
                                                    );
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
                                          Image.asset(
                                            'assets/images/muscles.jpg',
                                            width: 24,
                                            height: 24,
                                          ),
                                        ],
                                      ),
                                    ),
                                    onTap: () => context.push(
                                      '/exercise/${exercises[i].exerciseId}',
                                    ),
                                    title: Text(
                                      exercises[i].name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    subtitle: Text(
                                      exercises[i].targetMuscles.join(', '),
                                      style: TextStyle(
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          icon: const Icon(Icons.autorenew),
                                          onPressed: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) =>
                                                  const ReplaceExercisePage(),
                                            ),
                                          ),
                                        ),
                                        ReorderableDragStartListener(
                                          index: i,
                                          child: const Icon(Icons.drag_handle),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                            ],
                          ),

                          const SizedBox(height: 100),

                          // Muscles visualization & lists
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'MUSCLES',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/muscle_front.png',
                                      width: 120,
                                    ),
                                    const SizedBox(width: 16),
                                    Image.asset(
                                      'assets/images/muscle_back.png',
                                      width: 120,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),

                                // Primary with icon
                                Row(
                                  children: [
                                    Icon(
                                      Icons.info_outline,
                                      size: 16,
                                      color: Colors.grey,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Primary',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: Colors.grey.shade800,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Padding(
                                  padding: const EdgeInsets.only(left: 24),
                                  child: Text(
                                    primaryLabel,
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ),
                                const SizedBox(height: 12),

                                // Secondary with icon
                                Row(
                                  children: [
                                    Icon(
                                      Icons.info_outline,
                                      size: 16,
                                      color: Colors.grey,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Secondary',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: Colors.grey.shade800,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Padding(
                                  padding: const EdgeInsets.only(left: 24),
                                  child: Text(
                                    secondaryList,
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ),
                                const SizedBox(height: 174),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),

          // Bottom action buttons
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        'Start Workout',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.white,
                        side: BorderSide(color: Colors.grey.shade300),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        'Adapt Workout',
                        style: TextStyle(fontSize: 16, color: Colors.black87),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
