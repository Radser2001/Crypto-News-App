import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ArticleCard extends StatelessWidget {
  late final String title;
  late final String description;
  late final String imgUrl;
  late final String articleUrl;
  late final String content;
  late final String name;
  late final String author;
  late final String publishedAt;
  late final String imgKey = imgUrl;

  ArticleCard(
      {required this.title,
      required this.description,
      required this.imgUrl,
      required this.articleUrl,
      required this.content,
      required this.name,
      required this.author,
      required this.publishedAt});

  @override
  Widget build(BuildContext context) {
    String datetime = publishedAt;
    DateTime now = DateTime.parse(datetime);
    // DateTime date = DateTime(now.year, now.month, now.day);
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String date = formatter.format(now);
    // date = DateFormat.jm().format(now);

    return Card(
      color: Colors.grey[800],
      margin: const EdgeInsets.all(15.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: CachedNetworkImage(
                imageUrl: imgUrl,
                placeholder: (context, url) {
                  return Image.asset("assets/placeholder.jpg");
                },
                errorWidget: (context, url, error) {
                  return Image.asset("assets/placeholder.jpg");
                },
              ),
            ),
            const SizedBox(height: 20.0),
            Text(
              title,
              style: const TextStyle(
                  color: Color(0xE0F8F8F8),
                  fontSize: 20.0,
                  letterSpacing: 0.5,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 12.0),
            Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  date,
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: Color(0xE0F8F8F8),
                  ),
                )),
            Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/article', arguments: {
                        'title': title,
                        'description': description,
                        'imgUrl': imgUrl,
                        'articleUrl': articleUrl,
                        'content': content,
                        'name': name,
                        'author': author,
                        'publishedAt': date,
                        'key': imgKey,
                      });
                    },
                    child: const Text(
                      'View full article',
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 16.0,
                        color: Color(0xE0F8F8F8),
                      ),
                    )))
          ],
        ),
      ),
    );
  }
}
