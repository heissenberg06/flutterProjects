import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class CustomAppBarWidget extends StatelessWidget {
  final String title;
  const CustomAppBarWidget({required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
          onPressed: () {
            Get.toNamed('/okuyorum');
          },
          icon: const Icon(Icons.arrow_back),color: Colors.white,),
      title: Text(
        title,
        style: const TextStyle(
            color: Color(0xfFF0ECE5), fontWeight: FontWeight.bold),
      ),
      backgroundColor: const Color(0xFF161A30),
      centerTitle: true,
      automaticallyImplyLeading: false,
    );
  }
}
//hocam appbari tekrar tekrar yazmak yerine bir tane class yaptim onu cektim