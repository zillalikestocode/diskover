import 'dart:convert';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_gallery/components/image_card.dart';
import 'package:image_gallery/components/item_list.dart';
import 'package:image_gallery/components/search_page.dart';
import 'package:image_gallery/components/setting_page.dart';
import 'package:image_gallery/utils/text_styles.dart';
import 'package:image_gallery/models/gallery.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

Future<Gallery> fetchGallery() async {
  final response = await http.get(
      Uri.parse('https://api.pexels.com/v1/curated?per_page=50'),
      headers: {
        "Authorization":
            "ZMZ2agNVfo3fz1w7boIPQaB1bvs819nK6fydXILOUqbpvwTlFsWV79HA"
      });
  if (response.statusCode == 200) {
    return Gallery.fromJson(jsonDecode(response.body));
  } else {
    throw Exception("Unable to fetch results from server");
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<Gallery> futureGallery;
  int _currentIndex = 0;

  static const List<Widget> _pages = [ItemList(), SearchPage(), SettingsPage()];

  void changePage(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        child: SalomonBottomBar(
            onTap: changePage,
            currentIndex: _currentIndex,
            items: [
              SalomonBottomBarItem(
                  icon: const Icon(FluentIcons.home_24_regular),
                  title: const Text("Home"),
                  activeIcon: const Icon(FluentIcons.home_32_filled)),
              SalomonBottomBarItem(
                  icon: const Icon(FluentIcons.search_24_regular),
                  title: const Text("Search"),
                  activeIcon: const Icon(FluentIcons.search_32_filled)),
            ]),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              FluentIcons.globe_32_regular,
              size: 30,
              color: Colors.blueAccent,
            ),
            const Gap(10),
            Text(
              "Diskover",
              style: TextStyles.h2,
            ),
          ],
        ),
      ),
      body: SafeArea(child: _pages[_currentIndex]),
    );
  }
}
