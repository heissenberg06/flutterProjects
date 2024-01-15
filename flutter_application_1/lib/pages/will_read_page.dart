import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../extensions/appBar.dart';
import '../model/book_model.dart';

class WillRead extends StatelessWidget {
  const WillRead({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF161A30),
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppBarWidget(title: 'Okuyacaklarım'),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("books")
              .where("toRead", isEqualTo: true)
              .where("isFinish", isEqualTo: false)
              .snapshots(),
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
                      color: Color(0xFFB6BBC4),
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
                          TextButton(
                              onPressed: () {
                                //okuduklarima gonder
                                FirebaseFirestore.instance
                                    .collection('books')
                                    .doc(books.id)
                                    .update({
                                  "isFinish": true,
                                });
                              },
                              child: const Text(
                                'Okudum',
                                style: TextStyle(
                                    fontSize: 15, color: Color(0xFF161A30)),
                              ))
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
        onPressed: () {},
        backgroundColor: Color(0xFFF0ECE5),
        child: const Icon(Icons.add, size: 35),
      ),
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Color(0xFF31304D),
          iconSize: 35,
          unselectedFontSize: 17,
          selectedFontSize: 17,
          selectedItemColor: Color(0xFFF0ECE5),
          unselectedItemColor: Color(0xFFF0ECE5),
          items: [
            BottomNavigationBarItem(
                icon: IconButton(
                    onPressed: () {
                      Get.toNamed('/okuyacaklarim');
                    },
                    icon: Icon(
                      Icons.menu_book,
                      color: Color(0xFFF0ECE5),
                    )),
                label: "Okuyacaklarim"),
            BottomNavigationBarItem(
              icon: IconButton(
                  onPressed: () {
                    Get.toNamed('/okuduklarim');
                  },
                  icon: Icon(
                    Icons.my_library_books,
                    color: Color(0xFFF0ECE5),
                  )),
              label: "Okuduklarim",
            )
          ]),
    );
  }
}
