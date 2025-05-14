import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

import '../../models/post.dart';

class PostProvider extends ChangeNotifier {
  List<Post> _posts = [];
  bool _isLoading = false;
  String? _error;

  List<Post> get posts => _posts;
  bool get isLoading => _isLoading;
  String? get error => _error;

  final _box = Hive.box<Post>('postsBox');

  Future<void> fetchPosts() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    final connectivityResult = await Connectivity().checkConnectivity();
    final isOnline = connectivityResult != ConnectivityResult.none;

    try {
      if (isOnline) {
        final response = await http.get(
          Uri.parse('https://jsonplaceholder.typicode.com/posts'),
        );
        if (response.statusCode == 200) {
          final List data = json.decode(response.body);
          _posts = data.map((json) => Post.fromJson(json)).toList();

          // simpan ke Hive
          await _box.clear();
          await _box.addAll(_posts);
        } else {
          _error = 'Gagal fetch data (status ${response.statusCode})';
        }
      } else {
        // offline: ambil dari Hive
        _posts = _box.values.toList();
        if (_posts.isEmpty) {
          _error = 'Tidak ada koneksi & tidak ada data lokal.';
        }
      }
    } catch (e) {
      _error = 'Terjadi kesalahan: $e';
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> refreshPosts() async {
    await fetchPosts();
  }
}
