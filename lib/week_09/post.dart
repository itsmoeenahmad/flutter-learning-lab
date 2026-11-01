/// A small model for one item returned by the sample API.
class Post {
  const Post({required this.id, required this.title, required this.body});

  final int id;
  final String title;
  final String body;

  factory Post.fromJson(Map<String, dynamic> data) => Post(
    id: data['id'] as int,
    title: data['title'] as String,
    body: data['body'] as String,
  );
}
