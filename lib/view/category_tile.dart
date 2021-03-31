import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/view/category_news.dart';

class CategoryTile extends StatelessWidget {
  final imageUrl;
  final categoryName;

  CategoryTile({this.categoryName, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryNews(
              category: categoryName.toLowerCase(),
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(
          right: 15.0,
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6.0),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                width: 120.0,
                height: 90.0,
                fit: BoxFit.fill,
              ),
            ),
            Container(
              width: 120.0,
              height: 90.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.0),
                color: Colors.black38,
              ),
              child: Text(
                categoryName,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
