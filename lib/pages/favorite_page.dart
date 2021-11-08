import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobile_final_project/pages/post_detail.dart';

class FavoritePage extends StatefulWidget {
  FavoritePage({Key? key, required this.favoritePost, required this.onUnfavourite, required this.onFavorite}) : super(key: key);

  List favoritePost;
  dynamic onUnfavourite;
  dynamic onFavorite;

  @override
  FavoritePageState createState() => FavoritePageState();
}

class FavoritePageState extends State<FavoritePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BeSquaGram'),
      ),
      body: SafeArea(
        child: Container(
          color: Colors.amber[100],
          child: Center(
            child: ListView.builder(
              itemCount: widget.favoritePost.length,
              itemBuilder: (context, index) {

                return Card(
                  margin: const EdgeInsets.fromLTRB(10,5,10,5),
                  child: InkWell(
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    hoverColor: Colors.yellow[50],

                    // to detail page
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DetailScreen(
                            postDetail: widget.favoritePost[index],
                            onUnfavorite: widget.onUnfavourite,
                            onFavorite: widget.onFavorite,
                            favPost: widget.favoritePost,
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
                                "${widget.favoritePost[index]["image"]}", 
                                errorBuilder: (_1,_2,_3) {return const SizedBox.shrink();},
                                fit: BoxFit.fill
                              ),
                            )
                          ),

                          // For user details
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                    widget.favoritePost[index]["title"],
                                    maxLines: 1,
                                    style: const TextStyle(fontSize: 20),
                                ),
                                Container(
                                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                  child: Text(
                                    widget.favoritePost[index]["description"],
                                    maxLines: 3,
                                    style: const TextStyle(fontSize: 14),
                                  )
                                ),
                                Text(
                                  "${widget.favoritePost[index]["date"]}",
                                  style: const TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
                                )
                              ],
                            ),
                          ),
                          
                          // For unfavorite post
                          IconButton(
                            onPressed: () {
                              widget.onUnfavourite(widget.favoritePost[index]['_id']);
                              setState(() {
                                widget.favoritePost.indexOf(widget.favoritePost[index]);
                                widget.favoritePost.removeAt(index);
                              });
                            }, 
                            icon: const Icon(
                              Icons.favorite_rounded,
                              color: Colors.red
                            )
                          ),

                        ],
                      ),
                    ),
                  ),
                );
              }
            ),
          ),
        ),
      )    
    );
  }
}