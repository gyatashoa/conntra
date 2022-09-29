class News {
  final String title;
  final String urlToImage;
  final String url;

  News.fromJson(Map<String, dynamic> data)
      : title = data['title'],
        urlToImage = data['urlToImage'],
        url = data['url'];
}
