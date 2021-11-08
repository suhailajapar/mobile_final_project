import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_final_project/pages/about_page.dart';
import 'package:mobile_final_project/pages/create_post.dart';
import 'package:mobile_final_project/pages/favorite_page.dart';
import 'package:mobile_final_project/pages/post_detail.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class HomePage extends StatefulWidget {
  HomePage({required this.homeChannel,
    Key? key}) : super(key: key);

  WebSocketChannel homeChannel;
  
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {

  dynamic decodedResults;
  List _posts = [];
  List _favPost = [];
  bool _newOld = false;

  @override
  initState() {
    super.initState();
    widget.homeChannel.stream.listen((results) {
      decodedResults = jsonDecode(results);
      if(decodedResults['type'] == 'all_posts') {
        _posts = decodedResults['data']['posts'];
        _posts = _posts.reversed.toList();
      }
      setState(() {
      });
    });
    _getPosts();
  }

  void onUnfavourite(id) {
    setState(() {
      _favPost = _favPost.where((i) => i != id).toList();
    });
  }

  void onFavorite(id) {
    setState(() {
      _favPost.add(id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your feed'),
      ),
      body: SafeArea(
        child: Container(
          color: Colors.amber[100],
          child: Center(
            child: Column(
              children: [
                Card(
                    color: Colors.black,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(onPressed: _toSetting, icon: const Icon(Icons.settings_rounded, color: Colors.white,)),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _newOld = !_newOld;
                            });
                          }, 
                        icon: const Icon(
                            Icons.sort_by_alpha_rounded, 
                            color: Colors.white,
                          )
                        ),
                        IconButton(onPressed: _toFavoritePage, icon: const Icon(Icons.favorite_rounded, color: Colors.red,)),
                      ],
                    ),
                  ),

                Expanded(
                  child: ListView.builder(
                    reverse: _newOld,
                    itemCount: _posts.length,
                    itemBuilder: (context, index) {

                      bool isFavorited = _favPost.contains(_posts[index]['_id']);

                      return Card(
                        margin: const EdgeInsets.fromLTRB(10,5,10,5),
                          child: InkWell(
                            borderRadius: const BorderRadius.all(Radius.circular(5)),
                            hoverColor: Colors.yellow[50],

                            // to post Detail page.
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => DetailScreen(
                                    postDetail: _posts[index],
                                    onUnfavorite: onUnfavourite,
                                    onFavorite: onFavorite,
                                    favPost: _favPost,
                                  )
                                ),
                              );
                            },

                            child: Container(
                              height: 130,
                              child: Row(
                                children: <Widget>[

                                  //For Image
                                  Container(
                                    margin: const EdgeInsets.fromLTRB(10,10,20,10),
                                    width: 120,
                                    height: 120,
                                    decoration: BoxDecoration(
                                      image: const DecorationImage(
                                        image: NetworkImage(
                                          "https://dummyimage.com/120x120/ffbc2e/fff&text=BeSquaGram"
                                        ),
                                      fit: BoxFit.cover
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        "${_posts[index]["image"]}", 
                                        errorBuilder: (_1,_2,_3) {return const SizedBox.shrink();},
                                        fit: BoxFit.fill
                                      ),
                                    )
                                  ),

                                  // For user details
                                  Expanded(
                                    child: Container(
                                      margin: const EdgeInsets.fromLTRB(0,10,0,10),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            margin: const EdgeInsets.only(bottom: 10),
                                            child: Text(
                                              _posts[index]["title"],
                                              maxLines: 1,
                                              style: const TextStyle(fontSize: 20),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 50,
                                            child: Text(
                                              _posts[index]["description"],
                                              maxLines: 3,
                                              style: const TextStyle(fontSize: 14),
                                            )
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(top: 10),
                                            child: Text(
                                              "${_posts[index]["date"]}",
                                              style: const TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),

                                  // For favorite & delete post
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[

                                      // to delete
                                      IconButton(
                                        onPressed: () {
                                          widget.homeChannel.sink.add('{"type": "delete_post", "data": {"postId": "${_posts[index]['_id']}"}}');
                                          print('ID: ${_posts[index]['_id']} is deleted ');
                                          setState(() {
                                            _posts.indexOf(_posts[index]);
                                            _posts.removeAt(index);
                                          });
                                        },
                                        icon: const Icon(Icons.delete_rounded)
                                      ),

                                      // to favorite & unfavorite
                                      IconButton(
                                        onPressed: (){
                                          setState(() {
                                            if (isFavorited) {
                                              _favPost.remove(_posts[index]['_id']);
                                            } else {
                                              _favPost.add(_posts[index]['_id']);
                                            }
                                          });
                                        }, 
                                        icon: Icon(
                                          isFavorited? Icons.favorite_rounded : Icons.favorite_border_rounded,
                                          color: isFavorited ? Colors.red : null,
                                        )
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                      );
                    }
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _toCreatePost,
        child: const Icon(Icons.add_rounded),
        backgroundColor: Colors.yellow,
      ),
    );
  }

  void _getPosts() {
    widget.homeChannel.sink.add('{"type": "get_posts"}');
  }

  void _toFavoritePage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FavoritePage(
        favoritePost: _posts.where((p) => _favPost.contains(p['_id'])).toList(), 
        onUnfavourite: onUnfavourite,
        onFavorite: onFavorite
        )
      ),
    );
  }

  void _toSetting() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Setting()),
    );
  }

  void _toCreatePost() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CreatePostPage(createChannel: widget.homeChannel)),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}