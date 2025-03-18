import 'package:flutter_tutoial/models/news.dart';
import 'package:flutter_tutoial/news_service.dart';
import 'package:get/get.dart';

class NewsController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    fetchNews();
  }
  int page = 1;
  final isLoading = false.obs;
  final isLoadingDetail = false.obs;
  final news = <News>[].obs;
  News detailNews = News(title: '', link: '', detial: '', dateTime: '');
  final NewsService _newsService = NewsService();

  void fetchNews({int page = 1}) async {
    if (isLoading.value) return;
    isLoading(true);
    final data = await _newsService.fetchNews(page: page);
    news.addAll(data);
    isLoading(false);
  }

  void fetchDetail(String link) async {
    isLoadingDetail(true);
    final data = await _newsService.fetchDetails(link);

    detailNews = data;
    isLoadingDetail(false);
  }
}
