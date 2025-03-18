import 'package:flutter/material.dart';
import 'package:flutter_tutoial/detail_news_page.dart';
import 'package:flutter_tutoial/news_controller.dart';
import 'package:get/get.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final newsController = Get.put(NewsController());
    final scrollScroller = ScrollController();
    scrollScroller.addListener(() {
      if (scrollScroller.position.pixels ==
          scrollScroller.position.maxScrollExtent) {
        if (!newsController.isLoading.value) {
          newsController.page++;
          newsController.fetchNews(page: newsController.page);
        }
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: Text("News"),
      ),
      body: Obx(
        () => newsController.isLoading.value && newsController.news.isEmpty
            ? Center(child: CircularProgressIndicator())
            : ListView.separated(
                controller: scrollScroller,
                itemBuilder: (context, index) {
                  if(index == newsController.news.length && newsController.isLoading.value){
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  final newsItem = newsController.news[index];
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: GestureDetector(
                      onTap: () {
                        Get.to(DetailNewsPage(link: newsItem.link ?? ''));
                      },
                      child: Text(
                        newsItem.title ?? '',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  );
                },
                separatorBuilder: (_, index) => Divider(),
                itemCount: newsController.isLoading.value ? newsController.news.length + 1:
                 newsController.news.length,
              ),
      ),
    );
  }
}
