import 'package:flutter/material.dart';
import 'package:sql/dbhelper.dart';
import 'package:sql/post_details.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Enter your name',
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _ageController,
              decoration: const InputDecoration(
                labelText: 'Enter your age',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                String name = _nameController.text;
                String age = _ageController.text;
                if (name.isNotEmpty) {
                  await DBHelper().insert(name, age);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => const PostScreen())));
                } else {
                  // Show error message if the text field is empty
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please enter a post.'),
                    ),
                  );
                }
              },
              child: const Text('Post'),
            ),
          ],
        ),
      ),
    );
  }
}
