import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/model/bookModel.dart';

import '../extensions/appBar.dart';

class AddingPage extends StatelessWidget {
  AddingPage({super.key});

  var nameController = TextEditingController();
  var authorController = TextEditingController();
  var yearController = TextEditingController();
  var urlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF0ECE5),
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppBarWidget(title: 'Kitap Ekle'),
      ),
      body: SingleChildScrollView(
        //renderflexten kurtulmak icin
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 200,
              child: Image.network(
                  'https://w7.pngwing.com/pngs/33/272/png-transparent-football-ball-game-soccer-ball-soccer-ball-artwork-miscellaneous-sport-sports-equipment-thumbnail.png'),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 30, bottom: 10, right: 20, left: 20),
              child: TextFormField(
                //buna text giriliyo
                controller: nameController,
                decoration: InputDecoration(
                    label: const Text(
                      "Kitap Adını",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30))),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(
                  top: 10, bottom: 10, right: 20, left: 20),
              child: TextFormField(
                controller: authorController,
                decoration: InputDecoration(
                    label: const Text(
                      "Kitabın Yazarı",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30))),
              ),
            ), //author

            Padding(
              padding: const EdgeInsets.only(
                  top: 10, bottom: 10, right: 20, left: 20),
              child: TextFormField(
                controller: yearController,
                decoration: InputDecoration(
                    label: const Text(
                      "Yazıldığı Yıl",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30))),
              ),
            ), //author

            Padding(
              padding: const EdgeInsets.only(
                  top: 10, bottom: 10, right: 20, left: 20),
              child: TextFormField(
                controller: urlController,
                decoration: InputDecoration(
                    label: const Text(
                      "Image Url",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 10, bottom: 10, right: 60, left: 60),
              child: Center(
                child: TextButton(
                    style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Color(0xFF161A30))),
                    onPressed: () {
                      FirebaseFirestore.instance.collection('books').add({
                        "name": nameController.text,
                        "author": authorController.text,
                        "year": yearController.text,
                        "url": urlController.text,
                        "toRead": false,
                        "isFinish": false,
                      }).then(
                          (value) => ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    "Kitap Başarıyla Eklendi",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.green),
                                  ),
                                ),
                              ));
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.menu_book,
                          color: Color(0xFFF0ECE5),
                          size: 25,
                        ),
                        SizedBox(
                          height: 10,
                          width: 10,
                        ),
                        Text(
                          'Kitap Ekle',
                          style:
                              TextStyle(color: Color(0xFFF0ECE5), fontSize: 18),
                        )
                      ],
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
