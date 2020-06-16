import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import '../constVars.dart';
import './News.dart';

class NewsHome extends StatefulWidget {
  @override
  _NewsHomeState createState() => _NewsHomeState();
}

class _NewsHomeState extends State<NewsHome> {
  List<News> _articles = new List();
  News _selectedNews;
  bool _loading;

  @override
  void initState() {
    super.initState();
    _loading = false;
    _fetchNews();
  }

  _fetchNews() async {
    final url =
        "https://newsapi.org/v2/top-headlines?q=Covid&country=in&apiKey=7f4ed22aa44b4226ab27a1cb363acf85";
    final response = await http.get(url);

    if (response.statusCode == 200) {
      var r = json.decode(response.body);
      if (r['totalResults'] > 0) {
        List<News> newList = new List();

        r['articles'].forEach((article) {
          News news = new News(
            article['source']['name'],
            article['author'],
            article['title'],
            article['description'],
            article['urlToImage'],
            article['publishedAt'],
            article['content'],
            article['url'],
          );
          newList.add(news);
        });

        setState(() {
          _articles = newList;
          _selectedNews = newList[0];
          _loading = true;
        });
      }
    }
  }

  _launchBrowser() async {
    String url = _selectedNews.url;
    print(url);
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final totalHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final totalWidth = MediaQuery.of(context).size.width;
    return _loading
        ? Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 10, top: 30, right: 10),
                  height: totalHeight * 0.50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(_selectedNews.urlToImage),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(Colors.black38, BlendMode.darken),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 30,
                        margin: EdgeInsets.only(
                          top: MediaQuery.of(context).padding.top,
                          bottom: 10,
                          left: 5,
                        ),
                        width: totalWidth * 0.22,
                        decoration: BoxDecoration(
                          color: cPrimaryColor,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Align(
                          child: Text(
                            'Highlights',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "In Brief",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          _selectedNews.desc,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: GestureDetector(
                          onTap: _launchBrowser,
                          child: RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                text: "Read More ",
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.8),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              WidgetSpan(
                                alignment: PlaceholderAlignment.middle,
                                child: Icon(
                                  Icons.arrow_right,
                                  color: Colors.white.withOpacity(0.7),
                                ),
                              ),
                            ]),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 10, left: 10),
                  child: Text(
                    "Related News",
                    style: cTitleTextstyle,
                  ),
                ),
                Expanded(
                  child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: ListView.builder(
                      itemCount: _articles.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Stack(
                          children: <Widget>[
                            Card(
                              elevation: 0.4,
                              margin: EdgeInsets.only(bottom: 10),
                              child: ListTile(
                                isThreeLine: true,
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 8.0),
                                title: Text(
                                  _articles[index].title,
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500),
                                  maxLines: 2,
                                ),
                                leading: Container(
                                  height: 90,
                                  width: 90,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          _articles[index].urlToImage),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                subtitle: Container(
                                  padding: EdgeInsets.symmetric(vertical: 4),
                                  child: Text(
                                    _articles[index].agoTime,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: bodyTextColor.withOpacity(0.6),
                                    ),
                                    maxLines: 1,
                                  ),
                                ),
                              ),
                            ),
                            new Positioned.fill(
                              child: new Material(
                                color: Colors.transparent,
                                child: new InkWell(
                                  borderRadius: BorderRadius.circular(15),
                                  splashColor: cPrimaryColor.withOpacity(0.4),
                                  highlightColor: Colors.transparent,
                                  onTap: () {
                                    setState(() {
                                      _selectedNews = _articles[index];
                                    });
                                  },
                                ),
                              ),
                            )
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          )
        : Center(
            child: new CircularProgressIndicator(),
          );
  }
}
