import 'package:get/get.dart';

import '../controllers/news_controller.dart';

class NewsBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewsController>(() => NewsController());
  }
}
