import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gap/gap.dart';
import 'package:image_gallery/components/image_card.dart';
import 'package:image_gallery/models/gallery.dart';
import 'package:image_gallery/screens/home_screen.dart';
import 'package:image_gallery/utils/text_styles.dart';

class ItemList extends StatefulWidget {
  const ItemList({super.key});

  @override
  State<ItemList> createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  late Future<Gallery> futureGallery;

  @override
  void initState() {
    super.initState();
    futureGallery = fetchGallery();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Gallery>(
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                margin: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: "Search...",
                            icon: const Icon(FluentIcons.search_24_filled),
                            border: InputBorder.none,
                            hintStyle:
                                TextStyles.normal.copyWith(fontSize: 18)),
                      ),
                    )
                  ],
                ),
              ),
              const Gap(15),
              Expanded(
                child: MasonryGridView.count(
                  padding: const EdgeInsets.all(16),
                  physics: const ScrollPhysics(
                      parent: BouncingScrollPhysics(
                          decelerationRate: ScrollDecelerationRate.normal)),
                  crossAxisCount: 3,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  itemCount: snapshot.data!.photos.length,
                  itemBuilder: (context, index) {
                    return ImageCard(galleryItem: snapshot.data!.photos[index]);
                  },
                ),
              ),
            ],
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text("An error has occured"),
          );
        }
        return const Center(
          child: Text("Loading..."),
        );
      },
      future: futureGallery,
    );
  }
}
