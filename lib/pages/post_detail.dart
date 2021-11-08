import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


class DetailScreen extends StatefulWidget {
  DetailScreen({Key? key, required this.postDetail, required this.onUnfavorite, required this.onFavorite, required this.favPost}) : super(key: key);

  final postDetail;
  dynamic onUnfavorite;
  dynamic onFavorite;
  List favPost;

  @override
  DetailScreenState createState() => DetailScreenState();
}

class DetailScreenState extends State<DetailScreen> {

  bool isFavourite (){
    return widget.favPost.contains(widget.postDetail["_id"]);
  } 

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.postDetail['title']),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[

                //For Image
                Container(
                  margin: const EdgeInsets.fromLTRB(10,20,10,10),
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: NetworkImage(
                        "https://dummyimage.com/300x300/f7f7f7/fff&text=BeSquaGram"
                      ),
                    fit: BoxFit.cover
                    ),
                    border: Border.all(width: 3,color: Colors.orange),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      "${widget.postDetail["image"]}", 
                      errorBuilder: (_1,_2,_3) {return const SizedBox.shrink();},
                      fit: BoxFit.fill
                    ),
                  )
                ),

                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: (){
                          setState((){
                            if (!isFavourite()) {
                              widget.onFavorite(widget.postDetail['_id']);
                            } else {
                              widget.onUnfavorite(widget.postDetail['_id']);
                            }
                          });
                        }, 
                        icon: Icon(
                          isFavourite() ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                          color: isFavourite() ? Colors.red : null,
                        )
                      ),
                      IconButton(
                        onPressed: () {}, 
                        icon: const Icon(Icons.delete_rounded)
                      )
                    ],
                  )
                ),

                Container(
                  width: 400,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 8),
                        child: Text(
                          'Author: ${widget.postDetail['author']}',
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '${widget.postDetail['title']}',
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          '${widget.postDetail['description']}',
                          textAlign: TextAlign.justify,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '${widget.postDetail['date']}', 
                          style: const TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      )
    );
  }
}