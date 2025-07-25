import 'dart:async';
import 'dart:ui';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';

class PoseDetectorService {
  final PoseDetector _detector = PoseDetector(
    options: PoseDetectorOptions(mode: PoseDetectionMode.stream, 
                                  ),
  );

Future<Pose?> processImage(
    CameraImage image,
    InputImageRotation rotation,
  ) async {
    // assemble bytes buffer as before…
    final WriteBuffer allBytes = WriteBuffer();
    for (final plane in image.planes) {
      allBytes.putUint8List(plane.bytes);
    }
    final bytes = allBytes.done().buffer.asUint8List();

    // map Flutter’s ImageFormatGroup to ML-Kit’s InputImageFormat
    late final InputImageFormat imageFormat;
    switch (image.format) {
      // ignore: constant_pattern_never_matches_value_type
      case ImageFormatGroup.bgra8888:
        imageFormat = InputImageFormat.bgra8888;
        break;
      // ignore: constant_pattern_never_matches_value_type
      case ImageFormatGroup.jpeg:
        imageFormat = InputImageFormat.nv21;
        break;
      default:
        imageFormat = InputImageFormat.nv21;
    }

    final metadata = InputImageMetadata(
      size: Size(image.width.toDouble(), image.height.toDouble()),
      rotation: rotation,
      format: imageFormat,
      bytesPerRow: image.planes[0].bytesPerRow,
    );

    final inputImage = InputImage.fromBytes(bytes: bytes, metadata: metadata);

    final poses = await _detector.processImage(inputImage);
    return poses.isNotEmpty ? poses.first : null;
  }

  void dispose() {
    _detector.close();
  }
}
