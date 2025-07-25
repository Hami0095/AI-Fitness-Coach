// lib/features/camera/presentation/camera_page.dart

import 'dart:ui';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';

import '../../../core/pose_detection/pose_detector_service.dart';
import '../../../core/pose_detection/exercise_classifier.dart';
import 'pose_painter.dart';

class CameraPage extends StatefulWidget {
  final ExerciseType exerciseType;
  const CameraPage({Key? key, required this.exerciseType}) : super(key: key);

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  CameraController? _controller;
  late final InputImageRotation _rotation;
  bool _isProcessing = false;

  /// Holds the last detected pose
  Pose? _lastPose;

  /// Real-time textual feedback (“Go deeper”, “Good form”, etc.)
  String _feedback = '';

  /// The current rep count from ExerciseClassifier
  int _repCount = 0;

  final _poseService = PoseDetectorService();
  final _classifier = ExerciseClassifier();

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  InputImageRotation _rotationFromDegrees(int degrees) {
    switch (degrees) {
      case 90:
        return InputImageRotation.rotation90deg;
      case 180:
        return InputImageRotation.rotation180deg;
      case 270:
        return InputImageRotation.rotation270deg;
      case 0:
      default:
        return InputImageRotation.rotation0deg;
    }
  }

  Future<void> _initCamera() async {
    final cams = await availableCameras();
    final frontCam = cams.firstWhere(
      (c) => c.lensDirection == CameraLensDirection.front,
      orElse: () => cams.first,
    );

    final ctl = CameraController(
      frontCam,
      ResolutionPreset.medium,
      imageFormatGroup: ImageFormatGroup.yuv420,
    );

    try {
      await ctl.initialize();
      _rotation = _rotationFromDegrees(ctl.description.sensorOrientation);

      setState(() => _controller = ctl);
      ctl.startImageStream(_processCameraImage);
    } catch (e) {
      debugPrint('Camera init error: $e');
    }
  }

  Future<void> _processCameraImage(CameraImage image) async {
    if (_isProcessing) return;
    _isProcessing = true;

    final pose = await _poseService.processImage(image, _rotation);
    if (pose != null) {
      // classify & update repCount
      final fb = _classifier.classifyAndCount(pose, widget.exerciseType);
      setState(() {
        _lastPose = pose;
        _feedback = fb;
        _repCount = _classifier.repCount;
      });
    }

    _isProcessing = false;
  }

  @override
  void dispose() {
    _controller?.dispose();
    _poseService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null || !_controller!.value.isInitialized) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final isFront =
        _controller!.description.lensDirection == CameraLensDirection.front;
    final title = widget.exerciseType == ExerciseType.squat
        ? 'Squat Detector'
        : 'Push-Up Detector';
    final label = widget.exerciseType == ExerciseType.squat
        ? 'Squats'
        : 'Push-Ups';

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Stack(
        children: [
          CameraPreview(_controller!),

          // mirrored skeleton overlay
          if (_lastPose != null)
            CustomPaint(painter: PosePainter(_lastPose!, mirror: isFront)),

          // rep count display at top
          Positioned(
            top: 32,
            left: 16,
            right: 16,
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '$label x $_repCount',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          // real-time feedback at bottom
          Positioned(
            bottom: 32,
            left: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                _feedback,
                style: const TextStyle(color: Colors.white, fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
