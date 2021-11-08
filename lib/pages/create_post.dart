import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobile_final_project/pages/homepage.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class CreatePostPage extends StatefulWidget {
  CreatePostPage({Key? key, required this.createChannel}) : super(key: key);
  
  WebSocketChannel createChannel;

  @override
  CreatePostPageState createState() => CreatePostPageState();
}

class CreatePostPageState extends State<CreatePostPage> {

  late WebSocketChannel createChannel;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _imageURLController = TextEditingController();

  String _title = "";
  String _description = "";
  String _ImageURL = "";

  postCreated() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          '🐣 Yay! New post created. 🐣',
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        )
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create New Post'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              margin: const EdgeInsets.only(top: 30),
              width: 350,
              child: Form(
                child: Column(
                  children: [

                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 8, 0, 10),
                      width: 150,
                      height: 150,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage('https://cdn-icons-png.flaticon.com/512/1027/1027530.png'),
                          fit: BoxFit.cover
                        )
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        controller: _titleController,
                        onChanged: (String value) => _title = value,
                        decoration: const InputDecoration(
                          isDense: true,
                          border: OutlineInputBorder(),
                          labelText: 'Title'
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        controller: _descriptionController,
                        onChanged: (String value) => _description = value,
                        decoration: const InputDecoration(
                          isDense: true,
                          border: OutlineInputBorder(),
                          labelText: 'Description'
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        controller: _imageURLController,
                        onChanged: (String value) => _ImageURL = value,
                        decoration: const InputDecoration(
                          isDense: true,
                          border: OutlineInputBorder(),
                          labelText: 'Image URL'
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(350, 40)
                        ),
                        onPressed: _createPost,
                        child: const Text(
                          'Create Post',
                          style: TextStyle(fontSize: 16),
                        )
                      ),
                    ),
                  ],
                )
              ),
            )
          ),
        )
      ),
    );
  }

  void _toHomePage() {
    Navigator.pop(
      context,
      MaterialPageRoute(builder: (context) => HomePage(homeChannel: widget.createChannel)),
    );
  }

  void _createPost() {
    if (_titleController.text.isNotEmpty && _descriptionController.text.isNotEmpty && _imageURLController.text.isNotEmpty ) {
      widget.createChannel.sink.add('{"type": "create_post","data": {"title": "${_titleController.text}", "description": "${_descriptionController.text}", "image": "${_imageURLController.text}"}}');
      print('New post created!');
      _titleController.clear();
      _descriptionController.clear();
      _imageURLController.clear();
      postCreated();
    }
  }
}