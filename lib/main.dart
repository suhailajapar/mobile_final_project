import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'dart:io';
import 'package:web_socket_channel/io.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'pages/sign_in.dart';
import 'pages/log_in.dart';
import 'package:mobile_final_project/features/sign_in_cubit.dart';

/* void main(List<String> arguments) {
  
  //Establishing connection
  final channel = IOWebSocketChannel.connect('ws://besquare-demo.herokuapp.com');

  channel.stream.listen((results) {

    //getting access to json
    final decodedResults = jsonDecode(results);
  });

  //sending request to server 

  // Signing in --------------------------
  channel.sink.add('{"type": "sign_in","data": {"name": String}}');
  
  //Create new post
  channel.sink.add('{"type": "create_post","data": {"title": String, "description": String ,"image": String}}');

  //Get all post
  channel.sink.add('{"type": "get_posts","data": {"lastId": string "limit": int}}');

  //Delete post
  channel.sink.add('{"type": "delete_post","data": {"postId": string}}');
} */

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const title = 'BeSquagram';
    return MaterialApp(
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.purple
      ),
      home: BlocProvider(
        create: (_) => SignInCubit(),
        child: const SignIn(),
      ),
    );
  }
}

