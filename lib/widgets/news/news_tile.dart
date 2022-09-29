import 'dart:ffi';

import 'package:contra/model/news.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class NewsListTile extends StatefulWidget {
  NewsListTile(this.data, {Key? key}) : super(key: key);
  News data;
  @override
  State<NewsListTile> createState() => _NewsListTileState();
}

class _NewsListTileState extends State<NewsListTile> {
  void onLaunch(String url) async {
    if (!await launchUrlString(url)) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Row(
        children: const [
          Icon(
            Icons.error,
            color: Colors.red,
          ),
          Text('Unable to lauch news')
        ],
      )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onLaunch(widget.data.url),
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(bottom: 20.0),
        padding: EdgeInsets.all(12.0),
        height: 130,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(26.0),
            boxShadow: const [
              BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  blurStyle: BlurStyle.outer,
                  offset: Offset(1, 1),
                  spreadRadius: 2)
            ]),
        child: Row(
          children: [
            Flexible(
              flex: 3,
              child: Container(
                height: 100.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                    image: NetworkImage(widget.data.urlToImage!),
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
            Flexible(
                flex: 5,
                child: Column(
                  children: [
                    Text(
                      widget.data.title,
                      maxLines: 4,
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    // Text(widget.data.content!,
                    //     overflow: TextOverflow.ellipsis,
                    //     style: TextStyle(
                    //       color: Colors.white54,
                    //     ))
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
