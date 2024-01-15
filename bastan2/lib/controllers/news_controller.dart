import 'package:get/get.dart';

import '../models/news_model.dart';
import '../services/news_service.dart';

class NewsController extends GetxController {
  var isLoading = true.obs;
  var newsList = <Article>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchNews();
  }

  void fetchNews() async {
    try {
      isLoading(true);
      var news = await NewsService.fetchNews();
      newsList.assignAll(news.articles);
    } finally {
      isLoading(false);
    }
  }
}