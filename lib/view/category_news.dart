import 'package:flutter/material.dart';
import 'package:news_app/model/news_model.dart';
import 'package:news_app/service/api_service.dart';
import 'package:news_app/view/blog_tile.dart';

class CategoryNews extends StatefulWidget {
  final String category;

  CategoryNews({this.category});

  @override
  _CategoryNewsState createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  List<Article> articles = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    getCategoryNews();
  }

  getCategoryNews() async {
    CategoryNewsClass newsClass = CategoryNewsClass();
    await newsClass.getNews(widget.category);
    articles = newsClass.articleList;
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('${widget.category.toUpperCase()} NEWS')),
        backgroundColor: Colors.red,
        elevation: 0.0,
        actions: <Widget>[
          Opacity(
            opacity: 0,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 16.0,
              ),
              child: Icon(
                Icons.save,
              ),
            ),
          ),
        ],
      ),
      body: _isLoading
          ? Center(
              child: Container(
                child: CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
              child: Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(top: 16.0),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemCount: articles.length,
                        itemBuilder: (snapshot, index) {
                          return BlogTile(
                            imageUrl: articles[index].urlToImage,
                            decsription: articles[index].description,
                            title: articles[index].title,
                            url: articles[index].url,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
