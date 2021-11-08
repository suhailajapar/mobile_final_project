import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_final_project/pages/homepage.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:mobile_final_project/features/sign_in_cubit.dart';

class SignIn extends StatefulWidget {
  const SignIn({
    Key? key}) : super(key: key);


  @override
  SignInState createState() => SignInState();
}

class SignInState extends State<SignIn> {

  final channel = WebSocketChannel.connect(
    Uri.parse('ws://besquare-demo.herokuapp.com'),
  );

  final TextEditingController _controller = TextEditingController();

  String _name = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BeSquaGram'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: BlocBuilder<SignInCubit, String>(
              bloc: context.read<SignInCubit>(),
              builder: (context, state) {
                return Container(
                  width: 500,
                  margin: const EdgeInsets.only(top: 20),
                  child: Column(
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Text(
                          'Sign In',
                          style: TextStyle(fontSize: 24)
                        ),
                      ),
                      const Padding(
                        padding:  EdgeInsets.all(2),
                        child: Text(
                          'Welcome to BeSquaGram, please enter your identification',
                          style: TextStyle(fontSize: 12, color: Colors.blueGrey),
                        ),
                      ),

                      Container(
                        margin: const EdgeInsets.fromLTRB(0,20,0,20),
                        width: 150,
                        height: 150,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage('https://cdn-icons-png.flaticon.com/512/4372/4372360.png'),
                            fit: BoxFit.cover
                          )
                        ),
                      ),

                      Container(
                        width: 300,
                        child: Form(
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
                      ),
                      
                      Container(
                        width: 300,
                        margin: const EdgeInsets.only(top: 15),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            fixedSize: const Size(300, 40)
                          ),
                          onPressed: _signIn,
                          child: const Text(
                            'Sign In',
                            style: TextStyle(fontSize: 16),
                          )
                        ),
                      ),
                    ]
                  ),
                );
              }
            ) 
          ),
        ),
      ),
    );
  }

  void _toHomePage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomePage(homeChannel: channel)),
    );
  }

  void _signIn() {
    if (_controller.text.isNotEmpty) {
      channel.sink.add('{"type": "sign_in","data": {"name": "${_controller.text}"}}');
      print('${_controller.text} sign in success');
      _controller.clear();
      _toHomePage();
    }
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }
}