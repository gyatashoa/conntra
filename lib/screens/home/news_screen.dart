import 'package:contra/model/news.dart';
import 'package:contra/service/api_service.dart';
import 'package:contra/widgets/news/news_tile.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<News>>(
        future: GetIt.instance<ApiService>().getNews(),
        builder: (_, value) {
          if (value.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (value.hasError) {
            return const Center(
              child: Text('Error loading data'),
            );
          }
          if (value.hasData) {
            if (value.data is List<News>) {
              return ListView.builder(
                  itemCount: value.data!.length,
                  itemBuilder: (_, i) => NewsListTile(value.data![i]));
            }
          }
          return Container();
        });
  }
}
