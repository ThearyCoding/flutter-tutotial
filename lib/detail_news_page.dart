import 'package:flutter/material.dart';
import 'package:flutter_tutoial/news_controller.dart';
import 'package:get/get.dart';
import 'package:flutter_html/flutter_html.dart';

class DetailNewsPage extends StatefulWidget {
  final String link;
  const DetailNewsPage({super.key, required this.link});

  @override
  State<DetailNewsPage> createState() => _DetailNewsPageState();
}

class _DetailNewsPageState extends State<DetailNewsPage> {
  final newsController = Get.put(NewsController());

  @override
  void initState() {
    super.initState();
    newsController.fetchDetail(widget.link);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail"),
      ),
      body: Obx(()=>
       Padding(
          padding: const EdgeInsets.all(10.0),
          child: newsController.isLoadingDetail.value? Center(child: CircularProgressIndicator(),): SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  newsController.detailNews.title ?? '',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  newsController.detailNews.dateTime,
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Html(data: newsController.detailNews.detial),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
