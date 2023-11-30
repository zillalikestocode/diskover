import 'package:image_gallery/models/item.dart';

class Gallery {
  final int page;
  final int perPage;
  final List<Map<String, dynamic>> photos;

  const Gallery(
      {required this.page, required this.perPage, required this.photos});

  factory Gallery.fromJson(Map<String, dynamic> json) {
    return Gallery(
        page: json['page'],
        perPage: json['per_page'],
        photos: List<Map<String, dynamic>>.from(json['photos']));
  }
}
