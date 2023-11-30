import 'package:flutter/material.dart';
import 'package:image_gallery/components/image_page.dart';
import 'package:image_gallery/models/item.dart';

class ImageCard extends StatelessWidget {
  final Map<String, dynamic> galleryItem;
  const ImageCard({super.key, required this.galleryItem});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ImagePage(details: galleryItem),
        ));
      },
      child: Container(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Image.network(
            galleryItem['src']['medium'],
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
