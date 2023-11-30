import 'dart:io';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:gap/gap.dart';
import 'package:image_gallery/utils/text_styles.dart';
// import 'package:image_gallery/utils/extensions.dart';
import 'package:http/http.dart' as http;

class ImagePage extends StatefulWidget {
  final Map<String, dynamic> details;
  const ImagePage({super.key, required this.details});

  @override
  State<ImagePage> createState() => _ImagePageState();
}

Future<void> _saveImage(BuildContext context, String _url) async {
  String? message;
  final scaffoldMessenger = ScaffoldMessenger.of(context);

  try {
    // Download image
    final http.Response response = await http.get(Uri.parse(_url));

    // Get temporary directory
    final dir = Directory('/storage/emulated/0/Download');
    final int time = DateTime.now().millisecondsSinceEpoch;
    // Create an image name
    var filename = '${dir.path}/image-${time}.png';

    // Save to filesystem
    final file = File(filename);
    await file.writeAsBytes(response.bodyBytes);

    // Ask the user to save it
    // final params = SaveFileDialogParams(sourceFilePath: file.path);
    // final finalPath = await FlutterFileDialog.saveFile(params: params);

    // if (finalPath != null) {
    message = 'Image downloaded';
    // }
  } catch (e) {
    message = 'An error occurred while saving the image';
  }

  if (message != null) {
    scaffoldMessenger.showSnackBar(SnackBar(content: Text(message)));
  }
}

class _ImagePageState extends State<ImagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black, size: 30),
      ),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 12),
              children: [
                Container(
                  height: 400,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                          image:
                              NetworkImage(widget.details['src']['portrait']),
                          fit: BoxFit.cover)),
                ),
                Gap(15),
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: widget.details['alt'] != ""
                              ? Text(
                                  widget.details['alt'],
                                  style: TextStyles.h2,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                )
                              : Text(
                                  "Untitled",
                                  style: TextStyles.h2,
                                ),
                        ),
                      ],
                    )
                  ],
                )),
                Row(
                  children: [
                    Text(
                      widget.details['photographer'],
                      style: TextStyles.normal
                          .copyWith(color: Colors.grey.shade600),
                    )
                  ],
                ),
                const Gap(20),
                InkWell(
                  onTap: () {
                    _saveImage(context, widget.details['src']['original']);
                  },
                  child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(20)),
                      child: Flex(
                        direction: Axis.horizontal,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Download",
                            style: TextStyles.h3.copyWith(
                              color: Colors.white,
                            ),
                          ),
                          Gap(5),
                          Icon(
                            FluentIcons.arrow_download_24_filled,
                            color: Colors.white,
                            size: 20,
                          )
                        ],
                      )),
                )
              ]),
        ),
      ),
    );
  }
}
