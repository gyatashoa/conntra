import 'package:contra/constants/api.dart';

class News {
  final String title;
  final String urlToImage;
  final String url;

  News.fromJson(Map<String, dynamic> data)
      : title = data['title'],
        urlToImage = data['urlToImage'] ??
            'https://guwahatiplus.com/public/web/images/default-news.png',
        url = data['url'];
}
