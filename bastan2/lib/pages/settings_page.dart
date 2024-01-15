import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/news_controller.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({super.key});

  final NewsController newsControllerSet = Get.put(NewsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.settings),
              ],
            ),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: () {
                    Get.bottomSheet(
                      Container(
                        child: Wrap(
                          children: <Widget>
                          [
                            ListTile(
                              leading: const Icon(Icons.wb_sunny_outlined),
                              title: const Text('Light Theme'),
                              onTap: () => {Get.changeTheme(ThemeData.light())
                              },
                            ),

                            ListTile(
                              leading: const Icon(Icons.wb_sunny),
                              title: const Text('Dark Theme'),
                              onTap: () => {Get.changeTheme(ThemeData.dark())
                              },
                            )
                          ],
                        ),
                      ),
                      backgroundColor: Colors.green,
                      barrierColor: Colors.blue.withOpacity(0.1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: const BorderSide(
                          color: Colors.white,
                          style: BorderStyle.solid,
                          width: 2.0
                        )
                      )
                      );
                      
                  }, //change theme
                  child: const Text(
                    'change theme',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Color.fromARGB(255, 17, 220, 200)),
                  )),
            ],
          ),
        ));
  }
}
