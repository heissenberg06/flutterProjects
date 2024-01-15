import 'package:bastan2/controllers/auth_controller.dart';
import 'package:bastan2/pages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'home_page.dart';

class LoginPage extends StatelessWidget {
  final _display = true.obs;

  LoginPage({super.key});

  final mailController = TextEditingController();
  final _passwordController = TextEditingController();

  final obscureText = false.obs;

  final mail = ''.obs;
  final password = ''.obs;
  final AuthController _authService = AuthController();
  final _validateMail = false.obs;
  final _validatePassword = false.obs;

  final _mailConsept = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(248, 229, 89, 1),
      body: Obx(() {
        return SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 14.h,
              ),
              const Text(
                'WELCOME',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 8.h,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                child: TextField(
                  style: const TextStyle(fontSize: 25),
                  controller: mailController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)),
                    errorText: _validateMail.value ? 'cannot be empty' : null,
                    labelText: 'mail',
                    labelStyle: const TextStyle(fontSize: 22),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                child: TextField(
                  obscureText: _display.value,
                  style: const TextStyle(fontSize: 25),
                  controller: _passwordController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)),
                      errorText:
                          _validatePassword.value ? 'cannot be empty' : null,
                      labelText: 'password',
                      labelStyle: const TextStyle(fontSize: 22),
                      suffixIcon: GestureDetector(
                          onTap: () {
                            _display.value = !_display.value;
                            // if (_display.value) {
                            //   _display.value = false;
                            // } else {
                            //   _display.value = true;
                            // }
                          },
                          child: Icon(_display.value
                              ? Icons.visibility
                              : Icons.visibility_off))),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              SizedBox(
                height: 50,
                width: 200,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                        shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                width: 0, color: Colors.deepPurple),
                            borderRadius: BorderRadius.circular(15))),
                    onPressed: () {
                      mailController.text.isEmpty
                          ? _validateMail.value = true
                          : _validateMail.value = false;
              
                      mailController.text.isEmail //furkan abiye sor
                          ? _mailConsept.value = true
                          : _mailConsept.value = false;
              
                      _passwordController.text.isEmpty
                          ? _validatePassword.value = true
                          : _validatePassword.value = false;
              
                      //Im gonna add an alert dialog here that
                      //displays wrong password
              
                      _authService
                          .signIn(mailController.text, _passwordController.text)
                          // ignore: body_might_complete_normally_catch_error
                          .catchError((err) {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('ERROR'),
                                content: Text(err.message),
                              );
                            });
                      });
              
                      _authService
                          .signIn(mailController.text, _passwordController.text)
                          .then((value) {
                        return Navigator.push(context,
                            MaterialPageRoute(builder: (context) => HomePage()));
                      });
                    }, //textfielda validation eklenecek, outline border
                    //min karakter gibi mevzulari dialog
                    child: const Text(
                      'LOG IN',
                      style: TextStyle(fontSize: 27, color: Colors.black87),
                    )
                    ),
              ),
              SizedBox(height: 3.h),
              GestureDetector(
                child: const Text(
                  'Forgot Password?',
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 17,
                      color: Colors.blue),
                ),
                onTap: () {
                  Get.toNamed('/forgot');
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => ForgotPasswordPage()));
                },
              ),
              SizedBox(
                height: 5.h,
              ),
              TextButton(
                  style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15))),
                  onPressed: () {
                    Get.to(() => RegisterPage());
                  },
                  child: const Text(
                    'REGISTER',
                    style: TextStyle(fontSize: 20, color: Colors.black54),
                  )),
            ],
          ),
        );
      }),
    );
  }
}
