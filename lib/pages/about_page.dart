import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Setting extends StatefulWidget {
  Setting({ Key? key }) : super(key: key);

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {

  bool _visibleAbout = false;

  void _toggle() {
    setState(() {
      _visibleAbout = !_visibleAbout;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setting'),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(0, 30, 0, 20),
                child: ElevatedButton(
                  onPressed: _toggle, 
                  child: const
                  Text('About')
                ),
              ),
              Visibility(
                child: Column(
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Welcome to BeSquaGram',
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                    const Padding(
                      padding:  EdgeInsets.all(8.0),
                      child:  Text(
                        'Created by Suhaila Japar for Mobile Development Final Project',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RichText(
                        text: const TextSpan(
                          children: <InlineSpan>[
                            WidgetSpan(
                              child: Icon(Icons.copyright_outlined, size: 16),
                            ),
                            TextSpan(
                              text: " 2021 BeSquare by Deriv",
                              style: TextStyle(fontSize: 14)
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                maintainSize: true, 
                maintainAnimation: true,
                maintainState: true,
                visible: _visibleAbout, 
              )
            ],
          ),
        ),
      ),
    );
  }
}