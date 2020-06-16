import 'package:intl/intl.dart';

class News {
  final String source;
  final String author;
  final String title;
  final String desc;
  final String urlToImage;
  final String publishedAt;
  final String content;
  final String url;

  News(this.source, this.author, this.title, this.desc, this.urlToImage, this.publishedAt, this.content, this.url);

  String get agoTime {
    DateTime old = DateTime.parse(publishedAt);
    DateTime now = DateTime.now();
    Duration dur = now.difference(old);
    if(dur.inDays == 0) {
      if(dur.inHours > 0) {
        String val = '${dur.inHours} hr ${(dur.inMinutes-(dur.inHours*60))} min ago';
        return val;
      } else {
        String val = '${(dur.inMinutes-(dur.inHours*60))} min ago';
        return val;
      }
    }
    return new DateFormat.yMMMd().format(old);
  }

  String get imageUrl {
    if(urlToImage == null) {
      return "http://atsengg.com/images/not-found.jpg";
    } 
    return urlToImage;
  }

  String get getDesc {
    if(desc == null) {
      return "No Description Available.";
    }
    return desc;
  }
}