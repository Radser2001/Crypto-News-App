import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:newsapp/screens/loading.dart';
import 'package:newsapp/widgets/article_list.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Map<String, dynamic>> articles = [];
  late bool isLoading = true;
  String apiKey = "ad162ccb45404220a1c3f254dcdde0a1";

  Future<void> getNews() async {
    try {
      Response response = await get(Uri.parse(
          "https://newsapi.org/v2/everything?q=bitcoin&language=en&sortBy=publishedAt&apiKey=$apiKey"));
      Map jsondata = jsonDecode(response.body);
      // print(data);
      if (jsondata['status'] == 'ok') {
        jsondata['articles'].forEach((element) {
          // if (element['imageUrl'] != null) {
          articles.add(element);
          // }
        });
      }
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    getNews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Loading()
        : Scaffold(
            backgroundColor: Colors.grey[900],
            appBar: AppBar(
              title: const Text(
                'Crypto News',
                style: TextStyle(fontSize: 25.0),
              ),
              centerTitle: true,
              backgroundColor: Colors.grey[800],
            ),
            body: ListView.builder(
                itemCount: articles.length,
                itemBuilder: (context, index) {
                  return ArticleCard(
                    title: articles[index]['title'] ?? "unknown",
                    description: articles[index]['description'] ?? "unknown",
                    imgUrl: articles[index]['urlToImage'] ??
                        "https://media.istockphoto.com/photos/world-news-background-for-broadcast-picture-id1374346439?b=1&k=20&m=1374346439&s=170667a&w=0&h=3O1zN3cdDe8GKD-XeQ8fDH6fZbx2pwkGOyA68drFk1s=",
                    articleUrl: articles[index]['url'] ?? "unknown",
                    content: articles[index]['content'] ?? "unknown",
                    name: articles[index]['source']['name'] ?? 'unknown',
                    author: articles[index]['author'] ?? 'unknown',
                    publishedAt: articles[index]['publishedAt'] ?? 'unknown',
                  );
                }),
          );
  }
}
