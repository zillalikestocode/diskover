import 'dart:convert';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_gallery/components/results_component.dart';
import 'package:image_gallery/models/gallery.dart';
import 'package:image_gallery/utils/text_styles.dart';
import 'package:http/http.dart' as http;

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var query;
  static Widget resultComponent = Center(
    child: Text(""),
  );

  @override
  void initState() {
    super.initState();
  }

  late Future<Gallery> results;

  Future<Gallery> fetchResults() async {
    final String url =
        'https://api.pexels.com/v1/search?query=${query}&per_page=80';

    final response = await http.get(Uri.parse(url), headers: {
      "Authorization":
          "ZMZ2agNVfo3fz1w7boIPQaB1bvs819nK6fydXILOUqbpvwTlFsWV79HA"
    });

    if (response.statusCode == 200) {
      return Gallery.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Unable to fetch results from server");
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        Container(
          child: Text(
            "What are you looking for today?",
            style: TextStyles.h2,
          ),
        ),
        const Gap(15),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: Colors.white),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: TextField(
            onChanged: (value) {
              setState(() {
                query = value;
              });
            },
            autofocus: true,
            decoration: InputDecoration(
                hintText: "Explore...",
                icon: const Icon(FluentIcons.search_24_filled),
                border: InputBorder.none,
                hintStyle: TextStyles.normal.copyWith(fontSize: 18)),
          ),
        ),
        const Gap(15),
        InkWell(
          onTap: () async {
            results = fetchResults();
            setState(() {
              resultComponent = FutureBuilder(
                  future: results,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ResultsWidget(
                          query: query, photos: snapshot.data!.photos);
                    }

                    return Column(
                      children: [
                        const Gap(15),
                        const Center(
                          child: Text("Fetching Data..."),
                        ),
                      ],
                    );
                  });
            });
          },
          child: Ink(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 5),
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(20)),
              child: Center(
                child: Text(
                  "Search",
                  style: TextStyles.h4.copyWith(color: Colors.white),
                ),
              )),
        ),
        resultComponent
      ],
    );
  }
}
