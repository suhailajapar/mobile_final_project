import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'pages/signing_in.dart';
import 'package:mobile_final_project/features/sign_in_cubit.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const title = 'BeSquagram';
    return MaterialApp(
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: BlocProvider(
        create: (_) => SignInCubit(),
        child: const SignIn(),
      ),
    );
  }
}

