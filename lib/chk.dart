// import 'package:flutter/material.dart';
// import 'package:your_app_name/db_helper.dart'; // Import your DBHelper class

// class PostDisplayScreen extends StatefulWidget {
//   @override
//   _PostDisplayScreenState createState() => _PostDisplayScreenState();
// }

// class _PostDisplayScreenState extends State<PostDisplayScreen> {
//   Future<List<Map<String, dynamic>>>? _posts;

//   @override
//   void initState() {
//     super.initState();
//     _posts = DBHelper().getData();
//   }

//   void _deletePost(int postId) async {
//     await DBHelper().delete(postId);
//     setState(() {
//       _posts = DBHelper().getData();
//     });
//   }

//   void _updatePost(int postId, String currentPost) async {
//     String? updatedPost = await showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('Update Post'),
//         content: TextFormField(
//           initialValue: currentPost,
//           decoration: InputDecoration(
//             labelText: 'Enter updated post',
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.pop(context); // Close the dialog
//             },
//             child: Text('Cancel'),
//           ),
//           TextButton(
//             onPressed: () {
//               String newPost = (context as Element).findAncestorStateOfType<_PostDisplayScreenState>()._textEditingController.text;
//               Navigator.pop(context, newPost); // Close the dialog and return new post
//             },
//             child: Text('Update'),
//           ),
//         ],
//       ),
//     );

//     if (updatedPost != null) {
//       await DBHelper().update(postId, updatedPost);
//       setState(() {
//         _posts = DBHelper().getData();
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Posts'),
//       ),
//       body: FutureBuilder<List<Map<String, dynamic>>>(
//         future: _posts,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else {
//             List<Map<String, dynamic>>? posts = snapshot.data;
//             return ListView.builder(
//               itemCount: posts!.length,
//               itemBuilder: (context, index) {
//                 final post = posts[index];
//                 return ListTile(
//                   title: Text(post['datas']),
//                   trailing: PopupMenuButton(
//                     itemBuilder: (context) => [
//                       PopupMenuItem(
//                         value: 'delete',
//                         child: Row(
//                           children: [
//                             Icon(Icons.delete),
//                             SizedBox(width: 8),
//                             Text('Delete'),
//                           ],
//                         ),
//                       ),
//                       PopupMenuItem(
//                         value: 'update',
//                         child: Row(
//                           children: [
//                             Icon(Icons.edit),
//                             SizedBox(width: 8),
//                             Text('Update'),
//                           ],
//                         ),
//                       ),
//                     ],
//                     onSelected: (String value) {
//                       if (value == 'delete') {
//                         _deletePost(post['id']);
//                       } else if (value == 'update') {
//                         _updatePost(post['id'], post['datas']);
//                       }
//                     },
//                   ),
//                 );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
// }
