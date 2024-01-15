import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:flutter_application_1/extensions/appBar.dart';

import '../model/book_model.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0ECE5),
      appBar: AppBar(
        title: const Text(
          'Aylık Liste',
          style:
              TextStyle(color: Color(0xfFF0ECE5), fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF161A30),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: StreamBuilder<QuerySnapshot>(

          // StreamBuilder<QuerySnapshot>(
          //   stream: FirebaseFirestore.instance.collection("books").snapshots(),
          //   builder: (context, snapshot) {
          //     if(snapshot.hasError){
          //       return Text("Error")
          //     }
          //     if(!snapshot.hasData){
          //       return Text("Loading data");
          //     }

          //     return
          //   },
          stream: FirebaseFirestore.instance.collection("books").snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text("Error");
            }
            if (!snapshot.hasData) {
              return Text("Loading data");
            }
            return ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                final books = snapshot.data!.docs[index];

                return Container(
                  decoration: BoxDecoration(
                      color: const Color(0xFFB6BBC4),
                      borderRadius: BorderRadius.circular(15)),
                  padding: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                  ),
                  width: 100,
                  height: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.network(
                          books["url"],
                          fit: BoxFit.fill,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        children: [
                          Text(
                            books["author"],
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF161A30)),
                          ),
                          Text(
                            books["name"],
                            style: const TextStyle(
                                fontSize: 18, color: Color(0xFF161A30)),
                          ),
                          Text(
                            books["year"],
                          )
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(
                              onPressed: () async {
                                FirebaseFirestore.instance
                                    .collection('books')
                                    .doc(books.id)
                                    .update({
                                  "toRead": true,
                                });
                              },
                              icon: const Icon(Icons.add)),
                          IconButton(
                              onPressed: () async {
                                FirebaseFirestore.instance
                                    .collection('books')
                                    .doc(books.id)
                                    .delete();
                              },
                              icon: const Icon(Icons.remove))
                        ],
                      )
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) => const SizedBox(
                height: 10,
                width: 50,
              ),
              itemCount: snapshot.data!.size,
            );
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed('/adding');
        },
        backgroundColor: const Color(0xFFF0ECE5),
        child: const Icon(Icons.add, size: 35),
      ),
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: const Color(0xFF31304D),
          iconSize: 35,
          unselectedFontSize: 17,
          selectedFontSize: 17,
          selectedItemColor: const Color(0xFFF0ECE5),
          unselectedItemColor: const Color(0xFFF0ECE5),
          items: [
            BottomNavigationBarItem(
                icon: IconButton(
                    onPressed: () {
                      Get.toNamed('/okuyacaklarim');
                    },
                    icon: const Icon(
                      Icons.menu_book,
                      color: Color(0xFFF0ECE5),
                    )),
                label: "Okuyacaklarım"),
            BottomNavigationBarItem(
              icon: IconButton(
                  onPressed: () {
                    Get.toNamed('/okuduklarim');
                  },
                  icon: const Icon(
                    Icons.my_library_books,
                    color: Color(0xFFF0ECE5),
                  )),
              label: "Okuduklarım",
            )
          ]),
    );
  }
}
