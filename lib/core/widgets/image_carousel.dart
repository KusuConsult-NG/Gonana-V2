import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

/// Image carousel widget with page indicators and zoom capability
class ImageCarousel extends StatefulWidget {
  final List<String> imageUrls;
  final double height;
  final bool enableZoom;

  const ImageCarousel({
    super.key,
    required this.imageUrls,
    this.height = 300,
    this.enableZoom = true,
  });

  @override
  State<ImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    if (widget.imageUrls.isEmpty) {
      return Container(
        height: widget.height,
        color: Colors.grey[200],
        child: const Center(child: Icon(Icons.image_not_supported, size: 60)),
      );
    }

    return Stack(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: widget.height,
            viewportFraction: 1.0,
            enableInfiniteScroll: widget.imageUrls.length > 1,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          items: widget.imageUrls.map((url) {
            return Builder(
              builder: (BuildContext context) {
                return GestureDetector(
                  onTap: widget.enableZoom
                      ? () => _showFullScreenImage(context, url)
                      : null,
                  child: CachedNetworkImage(
                    imageUrl: url,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    placeholder: (context, url) => Container(
                      color: Colors.grey[200],
                      child: const Center(child: CircularProgressIndicator()),
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: Colors.grey[200],
                      child: const Icon(
                        Icons.broken_image,
                        size: 60,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),

        // Page indicators
        if (widget.imageUrls.length > 1)
          Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: widget.imageUrls.asMap().entries.map((entry) {
                return Container(
                  width: 8.0,
                  height: 8.0,
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentIndex == entry.key
                        ? Colors.white
                        : Colors.white.withValues(alpha: 0.4),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
      ],
    );
  }

  void _showFullScreenImage(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.black,
        insetPadding: EdgeInsets.zero,
        child: Stack(
          children: [
            Center(
              child: InteractiveViewer(
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Positioned(
              top: 40,
              right: 16,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white, size: 30),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
