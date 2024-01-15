import 'package:bastan2/controllers/auth_controller.dart';
import 'package:bastan2/pages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class PhoneVerificationPage extends StatelessWidget {
  String name, email, password;
  PhoneVerificationPage(this.name, this.email, this.password);

  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  final _phoneNumber = TextEditingController();
  final _takenCode = TextEditingController();

  AuthController authController = Get.put(AuthController());
  RegisterPage registerPage = Get.put(RegisterPage());

  RxBool wait = false.obs;
  RxInt start = 30.obs;
  var buttonName = 'send'.obs;
  var appBarTitle = 'SignUp';
  var smsCode = ''.obs;
  var verificationIdFinal = ''.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text(
          appBarTitle,
          style: const TextStyle(
              color: Colors.black87, fontSize: 25, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: _form,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text(
              'enter 6 digit code',
              style: TextStyle(
                  fontSize: 22,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 10, bottom: 10, left: 50, right: 50),
              child: TextFormField(
                keyboardType: TextInputType.number,
                style: const TextStyle(fontSize: 25),
                controller: _takenCode,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),
            Obx(() {
              return RichText(
                  text: TextSpan(children: [
                const TextSpan(
                    text: 'code will send after 30 seconds ',
                    style: TextStyle(
                        fontSize: 22,
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
                TextSpan(
                    text: '00:$start',
                    style: const TextStyle(
                        fontSize: 22,
                        color: Colors.black,
                        fontWeight: FontWeight.bold))
              ]));
            }),
            const SizedBox(height: 40),
            SizedBox(
              height: 50,
              width: 200,
              child: Padding(
                padding: const EdgeInsets.only(),
                child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.black,
                    ),
                    onPressed: () {
                      if (_form.currentState!.validate()) {
                        authController
                            .verifyOTP(_takenCode.text)
                            .whenComplete(() {
                          authController.createPerson(name, email, password,);
                        }).then((value) {
                          showDialog(
                              context: context,
                              builder: (context) => const AlertDialog(
                                    title: Text("That's it"),
                                    content: Text(
                                        'Your account is created successfuly'),
                                  ));
                        }).then((value) {
                          Navigator.pushNamed(context, '/login');
                        });
                      }
                    },
                    child: const Text(
                      'OK',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
