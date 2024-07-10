import 'package:flutter/material.dart';
import 'package:sql/dbhelper.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  PostScreenState createState() => PostScreenState();
}

class PostScreenState extends State<PostScreen> {
  Future<List<Map<String, dynamic>>>? _posts;
  DBHelper db = DBHelper();
  @override
  void initState() {
    super.initState();
    _posts = DBHelper().getData();
  }

  void _updatePost(String oldData) async {
    TextEditingController currentPost = TextEditingController(
        text: oldData); // Initialize controller with oldData

    String? updatedPost = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Update Post'),
        content: TextFormField(
          controller: currentPost,
          decoration: const InputDecoration(
            labelText: 'Enter updated post',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              String newPost = currentPost.text.toString();
              Navigator.pop(
                  context, newPost); // Close the dialog and return new post
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );

    if (updatedPost != null) {
      await DBHelper().updateData(oldData, updatedPost);
      setState(() {
        _posts = DBHelper().getData();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _posts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<Map<String, dynamic>>? posts = snapshot.data;
            return ListView.builder(
              itemCount: posts!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(posts[index]['studentName']),
                  trailing: PopupMenuButton(
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: 'delete',
                        child: Row(
                          children: [
                            Icon(Icons.delete),
                            SizedBox(width: 8),
                            Text('Delete'),
                          ],
                        ),
                      ),
                      const PopupMenuItem(
                        value: 'update',
                        child: Row(
                          children: [
                            Icon(Icons.edit),
                            SizedBox(width: 8),
                            Text('Update'),
                          ],
                        ),
                      ),
                    ],
                    onSelected: (String value) {
                      if (value == 'delete') {
                        db.delete(posts[index]['studentAge']);
                        setState(() {});
                        _posts = DBHelper().getData();
                      } else if (value == 'update') {
                        _updatePost(posts[index]['studentName']);
                        print(posts[index]['studentName']);
                      }
                    },
                  ),
                  subtitle: Text(posts[index]['studentAge']),
                );
              },
            );
          }
        },
      ),
    );
  }
}
