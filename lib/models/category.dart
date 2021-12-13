import 'dart:convert';

import 'package:baseproject/configs/app_config.dart';

class Category {
  final int id;
  final String name;
  final String? thumbnail;

  Category({required this.id, required this.name, this.thumbnail});

  factory Category.fromJson(Map json) {
    String? thumb;
    try {
      Map thumbMap = jsonDecode(json['thumbnail']);
      thumb = AppConfig.baseUrl + thumbMap['path'];
    } catch (_) {}

    return Category(
      id: int.parse(json['id']),
      name: json['name'],
      thumbnail: thumb,
    );
  }
}
