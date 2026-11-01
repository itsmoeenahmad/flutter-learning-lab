import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'post.dart';

/// Keeps the network request outside the screen widget.
class PostService {
  static Future<List<Post>> loadPosts() async {
    const url = 'https://jsonplaceholder.typicode.com/posts?_limit=10';
    debugPrint('Loading posts from $url');

    final response = await http.get(Uri.parse(url));
    if (response.statusCode != 200) {
      throw Exception('Unable to load posts. Status: ${response.statusCode}');
    }

    final rows = jsonDecode(response.body) as List<dynamic>;
    return rows
        .map((row) => Post.fromJson(row as Map<String, dynamic>))
        .toList();
  }
}
