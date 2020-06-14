import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../constVars.dart';
import './News.dart';

class NewsHome extends StatefulWidget {
  @override
  _NewsHomeState createState() => _NewsHomeState();
}

class _NewsHomeState extends State<NewsHome> {
  List<News> _articles = new List();

  @override
  void initState() {
    super.initState();
    _fetchNews();
  }

  _fetchNews() async {
    final url =
        "https://newsapi.org/v2/top-headlines?q=Covid&country=in&apiKey=7f4ed22aa44b4226ab27a1cb363acf85";
    final response = await http.get(url);

    if (response.statusCode == 200) {
      var r = json.decode(response.body);
      if (r['totalResults'] > 0) {
        int total = r['totalResults'];
        List<News> newList = new List();

        r['articles'].forEach((article) {
          News news = new News(
              article['source']['name'],
              article['author'],
              article['title'],
              article['description'],
              article['urlToImage'],
              article['publishedAt']);
          newList.add(news);
        });

        setState(() {
          _articles = newList;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final totalHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final totalWidth = MediaQuery.of(context).size.width;
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 10, top: 30, right: 10),
            height: totalHeight * 0.50,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(_articles[0].urlToImage),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 40,
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).padding.top, bottom: 10),
                  alignment: Alignment.bottomLeft,
                  width: totalWidth * 0.3,
                  decoration: BoxDecoration(
                    color: cPrimaryColor,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Align(
                    child: Text(
                      'Highlights',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _articles.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  elevation: 0.3,
                  child: ListTile(
                    title: Text(
                      _articles[index].title,
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                      maxLines: 2,
                    ),
                    leading: Container(
                      alignment: Alignment.center,
                      height: 100,
                      width: 90,
                      child: Image.network(_articles[index].urlToImage),
                    ),
                    subtitle: Container(
                      padding: EdgeInsets.all(4),
                      child: Text(
                        _articles[index].agoTime,
                        style: TextStyle(fontSize: 15),
                        maxLines: 1,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
