import 'package:flutter/material.dart';

import 'post.dart';
import 'post_service.dart';

/// Week 09: loading JSON data and displaying loading, error, and success states.
class PostBrowserPage extends StatefulWidget {
  const PostBrowserPage({super.key});

  @override
  State<PostBrowserPage> createState() => _PostBrowserPageState();
}

class _PostBrowserPageState extends State<PostBrowserPage> {
  late Future<List<Post>> _postsFuture;

  @override
  void initState() {
    super.initState();
    _postsFuture = PostService.loadPosts();
  }

  void _retry() {
    setState(() => _postsFuture = PostService.loadPosts());
    debugPrint('Retrying post request.');
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Post Browser')),
    body: FutureBuilder<List<Post>>(
      future: _postsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Posts could not be loaded.'),
                const SizedBox(height: 8),
                FilledButton(onPressed: _retry, child: const Text('Retry')),
              ],
            ),
          );
        }

        final posts = snapshot.data ?? [];
        if (posts.isEmpty) {
          return const Center(child: Text('No posts found.'));
        }

        return ListView.builder(
          itemCount: posts.length,
          itemBuilder: (context, index) {
            final post = posts[index];
            return Card(
              child: ListTile(
                title: Text(post.title),
                subtitle: Text(
                  post.body,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: Text('#${post.id}'),
              ),
            );
          },
        );
      },
    ),
  );
}
