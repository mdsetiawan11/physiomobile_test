import 'package:hive/hive.dart';

part 'post.g.dart'; // akan di-generate

@HiveType(typeId: 0)
class Post extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  int userId;

  @HiveField(2)
  String title;

  @HiveField(3)
  String body;

  Post({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
    id: json['id'],
    userId: json['userId'],
    title: json['title'],
    body: json['body'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'userId': userId,
    'title': title,
    'body': body,
  };
}
