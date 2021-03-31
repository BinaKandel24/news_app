import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:news_app/model/login_model.dart';
import 'package:news_app/model/news_model.dart';
import 'package:path_provider/path_provider.dart';

class APIService {
  //login part(jsonplaceholder)
  Future<LoginResponseModel> loginResponseModel(
      LoginRequestModel loginRequestModel) async {
    final response = await http.post(Uri.parse('https://reqres.in/api/login'),
        body: loginRequestModel.toJson());

    if (response.statusCode == 200 || response.statusCode == 400) {
      var responseMap = json.decode(response.body);

      return LoginResponseModel.fromJson(responseMap);
    } else {
      throw Exception('Something went wrong');
    }
  }
}

class News {
  List<Article> articleList = [];
  Future<void> getNewsModel({bool isRefresh}) async {
    String url =
        'https://newsapi.org/v2/everything?q=tesla&from=2021-02-28&sortBy=publishedAt&apiKey=57017a795e8a4b788626e2de3b54ac66';

    final cacheDir = await getTemporaryDirectory();
    var cachedFileName = 'Cachedata.json';

    if (isRefresh) {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonNewsMap = json.decode(jsonString);
        print('Refreshing :got response from API');
        for (var article in NewsResponseModel.fromJson(jsonNewsMap).articles) {
          articleList.add(article);
        }

        File file = new File(cacheDir.path + "/" + cachedFileName);
        file.writeAsString(jsonString, flush: true, mode: FileMode.write);
      } else {
        throw Exception('Something went wrong');
      }
    } else {
      if (await File(cacheDir.path + '/' + cachedFileName).exists()) {
        var jsonString =
            File(cacheDir.path + '/' + cachedFileName).readAsStringSync();
        var jsonNewsMap = json.decode(jsonString);
        print('Loading from cache');
        for (var article in NewsResponseModel.fromJson(jsonNewsMap).articles) {
          articleList.add(article);
        }
      } else {
        //api-key: '57017a795e8a4b788626e2de3b54ac66';
        // if (token == 'QpwL5tke4Pnpja7X4') {
        //   token = '4973c567a7844dba8cd3d622a1138438';
        final response = await http.get(Uri.parse(url));

        if (response.statusCode == 200) {
          var jsonString = response.body;
          var jsonNewsMap = json.decode(jsonString);
          print('got response from API');
          for (var article
              in NewsResponseModel.fromJson(jsonNewsMap).articles) {
            articleList.add(article);
          }

          File file = new File(cacheDir.path + "/" + cachedFileName);
          file.writeAsString(jsonString, flush: true, mode: FileMode.write);
        } else {
          throw Exception('Something went wrong');
        }
      }
    }
  }
}

class CategoryNewsClass {
  List<Article> articleList = [];
  Future<void> getNews(String category) async {
    String url =
        'https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=57017a795e8a4b788626e2de3b54ac66';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      print('got response from category');
      var jsonString = response.body;
      var jsonNewsMap = json.decode(jsonString);

      for (var article in NewsResponseModel.fromJson(jsonNewsMap).articles) {
        articleList.add(article);
      }
    } else {
      throw Exception('Something went wrong');
    }
  }
}
