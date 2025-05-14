import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/providers/post_provider.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<PostProvider>(context, listen: false);
      provider.fetchPosts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PostProvider>(context);

    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (provider.error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Error: ${provider.error}'),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: provider.fetchPosts,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: provider.refreshPosts,
      child: ListView.builder(
        itemCount: provider.posts.length,
        itemBuilder: (context, index) {
          final post = provider.posts[index];

          return Card(
            color: Colors.white,
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 4,
            shadowColor: Colors.black26,
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              leading: Icon(
                Icons.article_outlined,
                size: 40,
                color: Colors.black87,
              ),
              title: Text(
                post.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              subtitle: Text(
                post.body,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 14, color: Colors.black87),
              ),
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.white,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  isScrollControlled: true,
                  builder:
                      (_) => Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Wrap(
                          children: [
                            Text(
                              post.title,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              post.body,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
