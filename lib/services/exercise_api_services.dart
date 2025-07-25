import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

/// RapidAPI credentials (set your key here)
// const String rapidApiKey =
//     'ca2e15bcb7msh1021416fff79df1p1436f9jsn20f078d2ec1a'; // mabdurrehman95c
const String rapidApiKey = '32f1b9eddemshd532b87b9ffca1ap1d8994jsn16d821f62559';
const String rapidApiHost = 'exercisedb.p.rapidapi.com';

/// lib/core/models/exercise.dart
class Exercise {
  final String exerciseId;
  final String name;
  final String gifUrl;
  final List<String> targetMuscles;
  final List<String> bodyParts;
  final List<String> equipments;
  final List<String> secondaryMuscles;
  final List<String> instructions;
  final String? description;
  final String difficulty;
  final String category;
  String duration;

  Exercise({
    required this.exerciseId,
    required this.name,
    required this.gifUrl,
    required this.targetMuscles,
    required this.bodyParts,
    required this.equipments,
    required this.secondaryMuscles,
    required this.instructions,
    this.description,
    this.difficulty = 'medium',
    this.category = 'strength',
    this.duration = '30 seconds',
  });

  
  factory Exercise.fromJson(Map<String, dynamic> json) {
    List<String> _toList(dynamic input) {
      if (input == null) return [];
      if (input is List) {
        // already a List → just stringify
        return input.map((e) => e.toString()).toList();
      }
      if (input is Map) {
        // numeric keys (“0”, “1”, …) → sort by key, then stringify values
        final entries =
            input.entries.where((e) => int.tryParse(e.key) != null).toList()
              ..sort((a, b) => int.parse(a.key).compareTo(int.parse(b.key)));
        return entries.map((e) => e.value.toString()).toList();
      }
      // single value → wrap in a one‐element list
      return [input.toString()];
    }

    return Exercise(
      exerciseId: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      gifUrl: json['gifUrl']?.toString() ?? '',
      targetMuscles: _toList(json['target']),
      bodyParts: _toList(json['bodyPart']),
      equipments: _toList(json['equipment']),
      secondaryMuscles: _toList(json['secondaryMuscles']),
      instructions: _toList(json['instructions']),
      description: json['description']?.toString(),
      difficulty: json['difficulty']?.toString() ?? 'medium',
      category: json['category']?.toString() ?? 'strength',
      duration: json['duration']?.toString() ?? '30 seconds',
    );
  }

}


/// Simple model for items like bodyParts, equipment, or target muscles.
class NameItem {
  final String name;
  NameItem({required this.name});

  factory NameItem.fromJson(Map<String, dynamic> json) {
    return NameItem(name: json['name']?.toString() ?? '');
  }

  Map<String, dynamic> toJson() => {'name': name};
}

/// Service to interact with the ExerciseDB RapidAPI endpoint, including direct image fetch.
class ExerciseApiService {
  static const _baseUrl = 'https://$rapidApiHost';
  final http.Client _client;

  // RapidAPI headers
  static const Map<String, String> _headers = {
    'X-RapidAPI-Key': rapidApiKey,
    'X-RapidAPI-Host': rapidApiHost,
  };

  ExerciseApiService({http.Client? client}) : _client = client ?? http.Client();

  /// Fetches the raw GIF bytes for an exercise's thumbnail.
  /// Performs GET https://exercisedb.p.rapidapi.com/image?resolution=180&exerciseId={id}
  Future<Uint8List> fetchExerciseImageBytes(
    String exerciseId, {
    int resolution = 180,
  }) async {
    final uri = Uri.parse(
      '$_baseUrl/image?resolution=$resolution&exerciseId=$exerciseId',
    );
    final response = await _client.get(uri, headers: _headers);
    if (response.statusCode == 200) {
      return response.bodyBytes;
    }
    throw Exception('Failed to load image: ${response.statusCode}');
  }

  /// Fetch a single exercise by ID.
  Future<Exercise> fetchExerciseById(String id) async {
    final uri = Uri.parse('$_baseUrl/exercises/exercise/$id');
  print("Inside Fetch Exercise By ID");  
    final response = await _client.get(uri, headers: _headers);
    if (response.statusCode == 200) {
      final jsonMap = json.decode(response.body) as Map<String, dynamic>;
      return Exercise.fromJson(jsonMap);

    }
    throw Exception('Failed to load exercise: ${response.statusCode}');
  }

  /// Fetch all exercises.
  Future<List<Exercise>> fetchAllExercises() async {
    final uri = Uri.parse('$_baseUrl/exercises');
    final response = await _client.get(uri, headers: _headers);
    if (response.statusCode == 200) {
      final list = json.decode(response.body) as List<dynamic>;
      return list
          .map((e) => Exercise.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    throw Exception('Failed to load exercises: ${response.statusCode}');
  }

  /// Fetch exercises targeting a specific muscle.
  Future<List<Exercise>> fetchExercisesByMuscle(String muscle) async {
    final uri = Uri.parse('$_baseUrl/exercises/target/$muscle');
    final response = await _client.get(uri, headers: _headers);
    if (response.statusCode == 200) {
      final list = json.decode(response.body) as List<dynamic>;
      return list
          .map((e) => Exercise.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    throw Exception(
      'Failed to load exercises for muscle: ${response.statusCode}',
    );
  }

  /// Fetch exercises for a given body part.
  Future<List<Exercise>> fetchExercisesByBodyPart(String part) async {
    final uri = Uri.parse('$_baseUrl/exercises/bodyPart/$part');
    final response = await _client.get(uri, headers: _headers);
    if (response.statusCode == 200) {
      final list = json.decode(response.body) as List<dynamic>;
      return list
          .map((e) => Exercise.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    throw Exception(
      'Failed to load exercises for body part: ${response.statusCode}',
    );
  }

  /// Fetch exercises using specific equipment.
  Future<List<Exercise>> fetchExercisesByEquipment(String equipment) async {
    final uri = Uri.parse('$_baseUrl/exercises/equipment/$equipment');
    final response = await _client.get(uri, headers: _headers);
    if (response.statusCode == 200) {
      final list = json.decode(response.body) as List<dynamic>;
      return list
          .map((e) => Exercise.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    throw Exception(
      'Failed to load exercises for equipment: ${response.statusCode}',
    );
  }

  /// Fetch list of all body parts.
  Future<List<NameItem>> fetchBodyParts() async {
    final uri = Uri.parse('$_baseUrl/exercises/bodyPartList');
    final response = await _client.get(uri, headers: _headers);
    if (response.statusCode == 200) {
      final list = json.decode(response.body) as List<dynamic>;
      return list.map((e) => NameItem(name: e as String)).toList();
    }
    throw Exception('Failed to load body parts: ${response.statusCode}');
  }

  /// Fetch list of all equipment.
  Future<List<NameItem>> fetchEquipments() async {
    final uri = Uri.parse('$_baseUrl/exercises/equipmentList');
    final response = await _client.get(uri, headers: _headers);
    if (response.statusCode == 200) {
      final list = json.decode(response.body) as List<dynamic>;
      return list.map((e) => NameItem(name: e as String)).toList();
    }
    throw Exception('Failed to load equipments: ${response.statusCode}');
  }

  /// Fetch list of all target muscles.
  Future<List<NameItem>> fetchTargetMuscles() async {
    final uri = Uri.parse('$_baseUrl/exercises/targetList');
    final response = await _client.get(uri, headers: _headers);
    if (response.statusCode == 200) {
      final list = json.decode(response.body) as List<dynamic>;
      return list.map((e) => NameItem(name: e as String)).toList();
    }
    throw Exception('Failed to load target muscles: ${response.statusCode}');
  }

  /// Search exercises by name (returns list of exercise names).
  Future<List<String>> searchExercisesByName(String name) async {
    final uri = Uri.parse('$_baseUrl/exercises/name/$name');
    final response = await _client.get(uri, headers: _headers);
    if (response.statusCode == 200) {
      final list = json.decode(response.body) as List<dynamic>;
      return list
          .map((e) => (e as Map<String, dynamic>)['name'] as String)
          .toList();
    }
    throw Exception('Failed to search exercises: ${response.statusCode}');
  }
}
