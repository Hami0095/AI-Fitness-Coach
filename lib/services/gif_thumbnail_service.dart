/// Service to extract a thumbnail (first frame) from a GIF URL using the `image` package
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;

class GifThumbnailService {
  /// Downloads the GIF at [gifUrl], decodes its first frame, and returns it as PNG bytes.
  Future<Uint8List> extractThumbnail(String gifUrl) async {
    final response = await http.get(Uri.parse(gifUrl));
    if (response.statusCode != 200) {
      throw Exception(
        'Failed to download GIF (status: \${response.statusCode})',
      );
    }
    // Decode the full animation
    final animation = img.decodeGif(response.bodyBytes);
    if (animation == null || animation.frames.isEmpty) {
      throw Exception('Failed to decode GIF frames');
    }
    // Take the first frame
    final frame = animation.frames.first;
    // Encode to PNG for display as a thumbnail
    final pngBytes = img.encodePng(frame);
    return Uint8List.fromList(pngBytes);
  }
}
