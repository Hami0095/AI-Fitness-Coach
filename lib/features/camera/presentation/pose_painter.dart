import 'package:flutter/material.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';

class PosePainter extends CustomPainter {
  final Pose pose;
  PosePainter(this.pose, {required bool mirror});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.greenAccent
      ..strokeWidth = 4.0
      ..style = PaintingStyle.stroke;

    // Draw joints
    for (final landmark in pose.landmarks.values) {
      canvas.drawCircle(Offset(landmark.x, landmark.y), 5, paint);
    }

    // Draw bones (example: left-side chain)
    void drawLine(PoseLandmarkType a, PoseLandmarkType b) {
      final p1 = pose.landmarks[a]!;
      final p2 = pose.landmarks[b]!;
      canvas.drawLine(Offset(p1.x, p1.y), Offset(p2.x, p2.y), paint);
    }

    drawLine(PoseLandmarkType.leftShoulder, PoseLandmarkType.leftElbow);
    drawLine(PoseLandmarkType.leftElbow, PoseLandmarkType.leftWrist);
    drawLine(PoseLandmarkType.leftHip, PoseLandmarkType.leftKnee);
    drawLine(PoseLandmarkType.leftKnee, PoseLandmarkType.leftAnkle);
    // …and so on for right side / torso
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
