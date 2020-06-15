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
    print(old);
    print(now);
    print(dur);
    if(dur.inDays == 0) {
      if(dur.inHours > 0) {
        String val = '${dur.inHours} hr ${(dur.inMinutes-(dur.inHours*60))} min ago';
        print(val);
        return val;
      } else {
        String val = '${(dur.inMinutes-(dur.inHours*60))} min ago';
        print(val);
        return val;
      }
    }
    return new DateFormat.yMMMd().format(old);
  }
}