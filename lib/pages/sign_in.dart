import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  SignInPageState createState() => SignInPageState();
}

class SignInPageState extends State<SignInPage> {

  final channel = WebSocketChannel.connect(
    Uri.parse('ws://besquare-demo.herokuapp.com'),
  );

  final TextEditingController _controller = TextEditingController();

  String _name = "";

  decoder() {
    channel.stream.listen((results) {
      jsonDecode(results);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(
          width: 300,
          margin: const EdgeInsets.only(top: 20),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 30),
                child: Text(
                  'Sign In',
                  style: TextStyle(fontSize: 24)
                ),
              ),
              Form(
                child: TextFormField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    isDense: true,
                    border: OutlineInputBorder(),
                    labelText: 'Username',
                    hintText: 'e.g John Doe'
                  ),
                  onChanged: (String value) => _name = value,
                ),
              ),
              StreamBuilder(
                stream: decoder(),
                builder: (context, snapshot) {
                  return Text(snapshot.hasData ? '${snapshot.data}' : '');
                },
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(300, 40)
                ),
                onPressed: _signIn,
                child: const Text(
                  'Sign In',
                  style: TextStyle(fontSize: 16),
                )
              )
            ],
          ),
        ),
      ),
    ); 
  }

  void _signIn() {
    if (_controller.text.isNotEmpty) {
      channel.sink.add('{"type": "sign_in","data": {"name": "${_controller.text}"}}');
      print('${_controller.text} sign in success');
      _controller.clear();
    }
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }
}