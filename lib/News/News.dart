import 'package:intl/intl.dart';

class News {
  final String source;
  final String author;
  final String title;
  final String desc;
  final String urlToImage;
  final String publishedAt;

  News(this.source, this.author, this.title, this.desc, this.urlToImage, this.publishedAt);

  String get agoTime {
    DateTime old = DateTime.parse(publishedAt);
    DateTime now = DateTime.now();
    Duration dur = now.difference(old);
    if(dur.inDays > 0) {
      return new DateFormat.yMMMd().format(old);
    } else {
      if(dur.inHours > 0) {
        String val = '${dur.inHours} hr ${(dur.inMinutes/(dur.inHours*60)).round()} min ago';
        return val;
      }
    }
  }
}