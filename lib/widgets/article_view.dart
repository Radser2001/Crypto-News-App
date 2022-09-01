import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Article extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Map data = {};

    data = data.isNotEmpty
        ? data
        : ModalRoute.of(context)!.settings.arguments as Map;

    final Uri url = Uri.parse(data['articleUrl']);

    Future<void> _launchUrl() async {
      if (!await launchUrl(url)) {
        throw 'Could not launch $url';
      }
    }

    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text(data['name']),
        centerTitle: true,
        backgroundColor: Colors.grey[800],
      ),
      body: SingleChildScrollView(
        child: Card(
          color: Colors.grey[800],
          margin: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 10.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 20.0),
            child: Column(
              key: ValueKey(data['key']),
              children: [
                Text(
                  data['title'],
                  style: const TextStyle(
                      fontSize: 30.0,
                      color: Color(0xE0F8F8F8),
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      data['author'],
                      style: const TextStyle(
                          color: Color(0xE0F8F8F8),
                          fontSize: 18.0,
                          fontWeight: FontWeight.w300,
                          fontStyle: FontStyle.italic),
                    ),
                    Text(
                      data['publishedAt'],
                      style: const TextStyle(
                          color: Color(0xE0F8F8F8),
                          fontSize: 18.0,
                          fontWeight: FontWeight.w300,
                          fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: CachedNetworkImage(
                    imageUrl: data['imgUrl'],
                    placeholder: (context, url) {
                      return Image.asset("assets/placeholder.jpg");
                    },
                    errorWidget: (context, url, error) {
                      return Image.asset("assets/placeholder.jpg");
                    },
                  ),
                ),
                const SizedBox(height: 40.0),
                Text(
                  data['content'],
                  style: const TextStyle(
                      fontSize: 20.0,
                      color: Color(0xE0F8F8F8),
                      fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 20.0),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                      onPressed: () {
                        _launchUrl();
                      },
                      child: const Text(
                        'View full article',
                        style: TextStyle(
                          color: Color(0xE0F8F8F8),
                          fontSize: 16.0,
                          fontStyle: FontStyle.italic,
                        ),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
