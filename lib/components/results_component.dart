import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:image_gallery/components/image_card.dart';
import 'package:image_gallery/utils/text_styles.dart';

class ResultsWidget extends StatefulWidget {
  final String query;
  final dynamic photos;
  const ResultsWidget({super.key, required this.query, required this.photos});

  @override
  State<ResultsWidget> createState() => _ResultsWidgetState();
}

class _ResultsWidgetState extends State<ResultsWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Text(
                  "Results for ${widget.query}",
                  style: TextStyles.h2,
                )),
          ],
        ),
        StaggeredGrid.count(
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          crossAxisCount: 3,
          children: widget.photos
              .map<Widget>((item) => ImageCard(galleryItem: item))
              .toList(),
        )
      ],
    );
  }
}
