import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:news_app/model/news_model.dart';
import 'package:news_app/service/api_service.dart';
import 'package:news_app/service/data.dart';
import 'package:news_app/model/category_model.dart';
import 'package:news_app/view/blog_tile.dart';
import 'category_tile.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CategoryModel> categories = [];
  List<Article> articles = [];

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    categories = getCategories();
    getNewsModel(false);
  }

  getNewsModel(bool isRefresh) async {
    _isLoading = true;

    setState(() {
      if (_isLoading) {
        CircularProgressIndicator();
      }
    });
    News news = News();
    await news.getNewsModel(isRefresh: isRefresh);
    articles = news.articleList;

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TODAY'S NEWS"),
        actions: [
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text(
                      'Are you sure you want to logout?',
                    ),
                    actions: <Widget>[
                      FlatButton(
                        onPressed: () {
                          Navigator.of(context).popAndPushNamed('/login');
                        },
                        child: Text('Yes'),
                      ),
                      FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('No'),
                      ),
                    ],
                  ),
                );

                getNewsModel(true);
              }),
        ],
        backgroundColor: Colors.red,
        elevation: 0.0,
      ),
      body: WillPopScope(
        onWillPop: () {
          return showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: Text(
                      'Are you sure?',
                    ),
                    content: Text('It will close the application.'),
                    actions: <Widget>[
                      FlatButton(
                        onPressed: () {
                          SystemNavigator.pop();
                        },
                        child: Text('Yes'),
                      ),
                      FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('No'),
                      ),
                    ],
                  ));
        },
        child: _isLoading
            ? Center(
                child: Container(
                  child: CircularProgressIndicator(),
                ),
              )
            : RefreshIndicator(
                onRefresh: () async => getNewsModel(true),
                child: SingleChildScrollView(
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        //categories
                        Container(
                          height: 90.0,
                          padding: EdgeInsets.all(10.0),
                          child: ListView.builder(
                            itemCount: categories.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return CategoryTile(
                                imageUrl: categories[index].imageUrl,
                                categoryName: categories[index].categoryName,
                              );
                            },
                          ),
                        ),

                        //Blogs
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
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
                                publishedAt:
                                    (articles[index].publishedAt).toString(),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
