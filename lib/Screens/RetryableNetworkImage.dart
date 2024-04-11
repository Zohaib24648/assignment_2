import 'dart:async';
import 'package:flutter/material.dart';

class RetryableNetworkImage extends StatefulWidget {
  final String imageUrl;
  final int maxRetries;

  const RetryableNetworkImage({
    super.key,
    required this.imageUrl,
    required this.maxRetries,
  });

  @override
  RetryableNetworkImageState createState() => RetryableNetworkImageState();
}

class RetryableNetworkImageState extends State<RetryableNetworkImage> {
  int _retryCount = 0;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Image>(
      future: _loadImage(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting || snapshot.hasError) {
          return Container(); // Show an empty container while loading or on error
        }
        return snapshot.data!;
      },
    );
  }

  Future<Image> _loadImage() async {
    final image = NetworkImage(widget.imageUrl);
    final listener = ImageStreamListener(
          (ImageInfo info, bool synchronousCall) {
        // Image loaded successfully
      },
      onError: (dynamic error, StackTrace? stackTrace) {
        if (_retryCount < widget.maxRetries) {
          _retryCount++;
          print("Retrying to load image, retry count: $_retryCount");
          setState(() {});
        } else {
          // Max retries reached, could log error or set a flag to show a fallback image
        }
      },
    );
    image.resolve(const ImageConfiguration()).addListener(listener);
    return Image(image: image); // Return the image widget
  }
}
