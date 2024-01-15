import 'package:bastan2/controllers/auth_controller.dart';
import 'package:bastan2/pages/login_page.dart';
import 'package:bastan2/pages/register_page.dart';
import 'package:bastan2/pages/web_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../controllers/news_controller.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final NewsController newsController = Get.put(NewsController());
  final AuthController _authService = Get.put(AuthController());
  final LoginPage loginPage = Get.put(LoginPage());
  final RegisterPage registerPage = Get.put(RegisterPage());
  final FirebaseFirestore asd = FirebaseFirestore.instance;
  final _userStream =
      FirebaseFirestore.instance.collection('person').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white60,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/news-icon-18.png',
                height: 10.h, width: 25.w)
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            StreamBuilder(
                stream: _userStream,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Text('connection error');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Text('loading (ben yazdim bunu)');
                  }

                  var docs = snapshot.data!.docs;
                  return Container(
                    color: Colors.red,
                    height: 20.h,
                    width: 10.w,
                    child: ListView.builder(
                        itemCount: 1,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading:
                                const Icon(Icons.person_4_rounded, size: 50),
                            title: Text(
                              docs[index]['userName'],
                              style: const TextStyle(
                                  fontSize: 35, fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              docs[index]['email'],
                              style: const TextStyle(fontSize: 25),
                            ),
                          );
                        }),
                  );
                }),
            ListTile(
              title: const Text(
                'Settings',
                style: TextStyle(fontSize: 30),
              ),
              leading: const Icon(Icons.settings),
              onTap: () {
                Get.toNamed('/settings');
              },
            ),

            ListTile(
              title: const Text(
                'Favourites Page',
                style: TextStyle(fontSize: 30),
              ),
              leading: const Icon(Icons.favorite_outline),
              onTap: () {
                Get.toNamed('/favourite');
              },
            ),
            // ListTile(
            //   title: const Text('PROFILE', style: TextStyle(fontSize: 25)),
            //   onTap: () {
            //     Navigator.pop(context);
            //   },
            //   leading: const Icon(Icons.person),
            // ),
            const Divider(),
            ListTile(
              title: const Text('Log Out'),
              onTap: () {
                _authService.signOut();
                Get.toNamed('/login');
              },
              leading: const Icon(Icons.remove_circle),
            )
          ],
        ),
      ),
      body: Obx(() {
        if (newsController.isLoading.value) {
          return ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return Center(
                child: Container(
                    child: Shimmer.fromColors(
                  baseColor: Colors.grey[400]!,
                  highlightColor: Colors.grey[300]!,
                  child: Container(
                    margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
                    width: 100.w,
                    height: 100.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black12,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Shimmer.fromColors(
                          baseColor: Colors.grey[400]!,
                          highlightColor: Colors.grey[300]!,
                          child: Container(
                            margin: const EdgeInsets.all(10),
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: const DecorationImage(
                                  image: NetworkImage(
                                      'https://img.freepik.com/premium-psd/breaking-news-3d-render-logo_668760-388.jpg'),
                                  fit: BoxFit.cover),
                            ),
                          ),
                        ),
                        Shimmer.fromColors(
                          baseColor: Colors.grey[400]!,
                          highlightColor: Colors.grey[300]!,
                          child: Container(
                            margin: const EdgeInsets.only(
                                left: 20, right: 20, top: 5),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  '',
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 15.sp),
                                ),
                                SizedBox(
                                  height: 8.sp,
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.person,
                                      color: Colors.black26,
                                    ),
                                    Text(
                                      '',
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12.sp),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    const Icon(
                                      Icons.calendar_month,
                                      color: Colors.black26,
                                    ),
                                    Expanded(
                                      // I use expanded here because of the width
                                      child: Text(
                                        '',
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
              );
            },
            itemCount: 3,
          );

          // return const Center(
          //   child: CircularProgressIndicator(),
          // );
        }
//getarguments
        return ListView.separated(
            itemCount: newsController.newsList.length,
            separatorBuilder: (context, index) => SizedBox(height: 1.h),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NewsWebView(
                              url: newsController.newsList[index].url)));
                },
                child: Container(
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
                  width: 90.w,
                  height: 35.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black12,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.all(10),
                        width: 100.w,
                        height: 17.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: const DecorationImage(
                              image: NetworkImage(
                                  'https://img.freepik.com/premium-psd/breaking-news-3d-render-logo_668760-388.jpg'),
                              fit: BoxFit.cover),
                        ),
                      ),
                      Container(
                        margin:
                            const EdgeInsets.only(left: 20, right: 20, top: 5),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 0.01.h,
                            ),
                            Text(
                              newsController.newsList[index].title,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 15.sp),
                            ),
                            SizedBox(
                              height: 8.sp,
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.person,
                                  color: Colors.black26,
                                ),
                                Text(
                                  newsController.newsList[index].author,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12.sp),
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                const Icon(
                                  Icons.calendar_month,
                                  color: Colors.black26,
                                ),
                                Expanded(
                                  // I use expanded here because of the width
                                  child: Text(
                                    newsController.newsList[index].publishedAt
                                        .toString(),
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            });
      }),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       icon: IconButton(
      //         onPressed: () {
      //           Get.to(SettingsPage(),
      //               fullscreenDialog:
      //                   true); //thanks to this I have also a defalut page transition
      //         },
      //         icon: const Icon(Icons.settings),
      //       ),
      //       label: 'SETTINGS',
      //     ),
      //     BottomNavigationBarItem(
      //         icon: IconButton(
      //             onPressed: () {}, icon: const Icon(Icons.account_tree)),
      //         label: 'SAVED') //I gondercem to here kaydedilenler
      //   ],
      // )
    );
  }
}
