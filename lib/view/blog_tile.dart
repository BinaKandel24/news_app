import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/view/article_view.dart';

class BlogTile extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String decsription;
  final String url;

  BlogTile(
      {@required this.imageUrl,
      @required this.decsription,
      @required this.title,
      @required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ArticleView(
              blogUrl: this.url,
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(
          bottom: 15.0,
        ),
        child: Column(
          children: <Widget>[
            Container(
              child: CachedNetworkImage(
                imageUrl: imageUrl ??
                    'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/600px-No_image_available.svg.png',
                width: double.infinity,
                height: 250.0,
                fit: BoxFit.cover,
                placeholder: (context, url) {
                  return Container(
                    height: 250,
                    width: double.infinity,
                    child: Center(child: CircularProgressIndicator()),
                  );
                },
                errorWidget: (context, url, error) => new Icon(Icons.error),
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            Text(
              title ?? '',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            Text(
              decsription ?? '',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
