import 'dart:math';

import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';
import 'package:vector_math/vector_math_64.dart';

enum ExerciseType { squat, pushUp }

class ExerciseClassifier {
  int repCount = 0;
  bool _inRep = false;

  /// Given a pose, decide if a rep is completed and return feedback
  String classifyAndCount(Pose pose, ExerciseType type) {
    final landmarks = pose.landmarks;
    String feedback = '';

    double angle(Point<double> a, Point<double> b, Point<double> c) {
      final ab = Vector2(a.x - b.x, a.y - b.y);
      final cb = Vector2(c.x - b.x, c.y - b.y);
      final dot = ab.dot(cb);
      final cosA = dot / (ab.length * cb.length);
      return acos(cosA) * 180 / pi;
    }

    if (type == ExerciseType.squat) {
      final hip = landmarks[PoseLandmarkType.leftHip]!;
      final knee = landmarks[PoseLandmarkType.leftKnee]!;
      final ankle = landmarks[PoseLandmarkType.leftAnkle]!;
      final kneeAngle = angle(
        Point(hip.x, hip.y),
        Point(knee.x, knee.y),
        Point(ankle.x, ankle.y),
      );

      if (kneeAngle < 70) {
        feedback = 'Go deeper';
        _inRep = true;
      } else if (kneeAngle > 160 && _inRep) {
        repCount++;
        feedback = 'Good squat 👍 ($repCount)';
        _inRep = false;
      } else {
        feedback = 'Depth OK';
      }
    } else if (type == ExerciseType.pushUp) {
      final shoulder = landmarks[PoseLandmarkType.leftShoulder]!;
      final elbow = landmarks[PoseLandmarkType.leftElbow]!;
      final wrist = landmarks[PoseLandmarkType.leftWrist]!;
      final elbowAngle = angle(
        Point(shoulder.x, shoulder.y),
        Point(elbow.x, elbow.y),
        Point(wrist.x, wrist.y),
      );

      if (elbowAngle < 50) {
        feedback = 'Lower down';
        _inRep = true;
      } else if (elbowAngle > 160 && _inRep) {
        repCount++;
        feedback = 'Nice push-up 👍 ($repCount)';
        _inRep = false;
      } else {
        feedback = 'Good form';
      }
    }

    return feedback;
  }
}
