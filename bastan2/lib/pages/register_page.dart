import 'package:bastan2/controllers/auth_controller.dart';
import 'package:bastan2/controllers/regist_controller.dart';
import 'package:bastan2/pages/phone_verif_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

// ignore: must_be_immutable
class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final GlobalKey<FormState> _formRegister = GlobalKey<FormState>();

  RegisterController registerController = Get.put(RegisterController());
  AuthController authController = Get.put(AuthController());

  final _mailRegisterController = TextEditingController();
  final _passwordRegisterController = TextEditingController();
  final _usernameRegisterController = TextEditingController();
  final _passwordConfirmController = TextEditingController();
  final _phoneController = TextEditingController(); //bunu kullanacam

  final isLoading = true.obs;

  final _displayRegister = true.obs;
  final _displayRegisterConfirm = true.obs;
  final obscureText = true.obs;

  final _registerValidateMail = false.obs;
  final _registerValidateName = false.obs;
  final _registerValidatePassword = false.obs;
  final _registerValidatePhone = false.obs;

  final AuthController _authService = AuthController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey,
          title: const Center(
              child: Text(
            'REGISTER',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          )),
        ),
        body: Obx(() {
          return SingleChildScrollView(
            child: Form(
              key: _formRegister,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // SizedBox(
                  //   height: 2.h,
                  // ),
                  // const Text(
                  //   'REGISTER',
                  //   style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  // ),
                  SizedBox(
                    height: 3.h,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: 15, left: 40, right: 40),
                    child: TextField(
                      style: const TextStyle(fontSize: 25),
                      controller: _mailRegisterController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30)),
                        errorText: _registerValidateMail.value
                            ? 'cannot be empty'
                            : null,
                        labelText: 'mail',
                        helperText: 'example@gmail.com',
                        helperStyle: const TextStyle(fontSize: 15),
                        labelStyle: const TextStyle(fontSize: 22),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: 15, left: 40, right: 40),
                    child: TextField(
                      style: const TextStyle(fontSize: 25),
                      controller: _usernameRegisterController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30)),
                          errorText: _registerValidateName.value
                              ? 'cannot be empty'
                              : null,
                          labelText: 'name',
                          labelStyle: const TextStyle(fontSize: 22)),
                    ),
                  ),

                  // TextFormField(
                  //   controller: _passwordRegisterController,
                  //   validator: (val){
                  //     if(val!.isEmpty)
                  //     return 'Empty';
                  //     return null;
                  //   },
                  // ),

                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: 15, left: 40, right: 40),
                    child: TextFormField(
                      obscureText: _displayRegister.value,
                      style: const TextStyle(fontSize: 25),
                      controller: _passwordRegisterController,
                      // validator: (val) {
                      //   if (val!.isEmpty) {
                      //     return 'empty';
                      //   } else {
                      //     return null;
                      //   }
                      // },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30)),
                          helperText:
                              'password should include more than 6 chars',
                          helperStyle: const TextStyle(fontSize: 15),
                          errorText: _registerValidateMail.value
                              ? 'cannot be empty'
                              : null,
                          labelText: 'password',
                          labelStyle: const TextStyle(fontSize: 22),
                          suffix: IconButton(
                              onPressed: () {
                                if (_displayRegister.value) {
                                  _displayRegister.value = false;
                                } else {
                                  _displayRegister.value = true;
                                }
                              },
                              icon: Icon(_displayRegister.value == true
                                  ? Icons.visibility
                                  : Icons.visibility_off))),
                    ),
                  ),

                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: 15, left: 40, right: 40),
                    child: TextFormField(
                      obscureText: _displayRegisterConfirm.value,
                      style: const TextStyle(fontSize: 25),
                      controller: _passwordConfirmController,

                      // validator: (val) {
                      //   if (val != _passwordRegisterController.text) {
                      //     return 'NOT MATCH !!!';
                      //   } else {
                      //     return null;
                      //   }
                      // },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30)),
                          helperText:
                              'password should include more than 6 chars',
                          helperStyle: const TextStyle(fontSize: 15),
                          errorText: _registerValidateMail.value
                              ? 'cannot be empty'
                              : null,
                          labelText: 'password',
                          labelStyle: const TextStyle(fontSize: 22),
                          suffix: IconButton(
                              onPressed: () {
                                if (_displayRegisterConfirm.value) {
                                  _displayRegisterConfirm.value = false;
                                } else {
                                  _displayRegisterConfirm.value = true;
                                }
                              },
                              icon: Icon(_displayRegisterConfirm.value == true
                                  ? Icons.visibility
                                  : Icons.visibility_off))),
                    ),
                  ),

                  Padding(
                    padding:
                        const EdgeInsets.only(left: 40, right: 40, bottom: 15),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      style: const TextStyle(fontSize: 25),
                      controller: _phoneController,
                      decoration: InputDecoration(
                        prefixIcon: const Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                          child: Text(
                            '(+90)',
                            style: TextStyle(fontSize: 25),
                          ),
                        ),
                        helperText: 'please insert phone number',
                        helperStyle: const TextStyle(fontSize: 15),
                        labelText: 'phone',
                        labelStyle: const TextStyle(fontSize: 22),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30)),
                        errorText: _registerValidateMail.value
                            ? 'cannot be empty'
                            : null,
                      ),
                    ),
                  ),

                  // Padding(
                  //   padding:
                  //       const EdgeInsets.only(left: 40, right: 40, bottom: 15),
                  //   child: TextFormField(
                  //     style: const TextStyle(fontSize: 25),
                  //     controller: _phoneController,
                  //     decoration: InputDecoration(
                  //         prefixIcon: const Padding(
                  //           padding: EdgeInsetsDirectional.symmetric(
                  //               vertical: 8, horizontal: 8),
                  //           child: Text(
                  //             '(+90)',
                  //             style: TextStyle(fontSize: 25),
                  //           ),
                  //         ),
                  //         suffixIcon: InkWell(
                  //           onTap: () {
                  //             if (_formRegister.currentState!.validate()) {
                  //               authController.phoneAuthentication(
                  //                   '+90${_phoneController.text}');
                  //             }
                  //           },
                  //         ),
                  //         helperText: 'please insert phone number',
                  //         helperStyle: const TextStyle(fontSize: 15),
                  //         labelText: 'phone',
                  //         labelStyle: const TextStyle(fontSize: 22),
                  //         border: OutlineInputBorder(
                  //             borderRadius: BorderRadius.circular(30))),
                  //   ),
                  // ),

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

                        //contains methoduyla kontrol
                        onPressed: () {
                          registerController.isLoading.value = true;

                          _mailRegisterController.text.isEmpty
                              ? _registerValidateMail.value = true
                              : _registerValidateMail.value = false;

                          _usernameRegisterController.text.isEmpty
                              ? _registerValidateName.value = true
                              : _registerValidateName.value = false;

                          _passwordRegisterController.text.isEmpty
                              ? _registerValidatePassword.value = true
                              : _registerValidatePassword.value = false;

                          _phoneController.text.isEmpty
                              ? _registerValidatePhone.value = true
                              : _registerValidatePhone.value = false;

                          if (_passwordRegisterController.text !=
                              _passwordConfirmController.text) {
                            showDialog(
                                context: context,
                                builder: (context) => const AlertDialog(
                                      title:
                                          Text('passwords are not matched!!!'),
                                      content: Text('please try again'),
                                    )).whenComplete(() {
                              registerController.isLoading.value = false;
                            });
                          } else if (_mailRegisterController.text.isEmpty &&
                              _usernameRegisterController.text.isEmpty &&
                              _passwordRegisterController.text.isEmpty) {
                            showDialog(
                                context: context,
                                builder: (context) => const AlertDialog(
                                      title: Text('please fill the blanks!!!'),
                                      content: Text('please try again'),
                                    )).whenComplete(() {
                              // ignore: avoid_print
                              print('DENEME');
                              registerController.isLoading.value = false;
                            });
                          } else if (_phoneController.text.isEmpty) {
                            showDialog(
                                context: context,
                                builder: (context) => const AlertDialog(
                                      title: Text(
                                          'YOU MUST INSERT A PHONE NUMBER'),
                                      content: Text(
                                          'as I sad you must insert a phone number'),
                                    ));
                                    registerController.isLoading.value = false;
                          }

                          // else if (_form.currentState!.validate()) {
                          // if(_form.currentState!.validate()){
                          // _authController.phoneAuthentication(_phoneController.text)
                          // .then((value) {authController.createPerson(
                          // name,
                          // mail,
                          // password)});
                          // }
                          //
                          // kafamdaki phone number ve registeri
                          // baglama isi boyle

                          else if (_formRegister.currentState!.validate() &&
                              _phoneController.text.isEmpty == false) {
                            authController
                                .phoneAuthentication('+90${_phoneController.text}')
                                .then((value) {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(
                                      builder: (context) =>
                                          PhoneVerificationPage(
                                              _usernameRegisterController.text,
                                              _mailRegisterController.text,
                                              _phoneController.text)))
                                  .whenComplete(() {
                                registerController.isLoading.value = false;
                              });
                            });
                          }
                          // else {
                          //   _authService
                          //       .createPerson(
                          //           _usernameRegisterController.text,
                          //           _mailRegisterController.text,
                          //           _passwordRegisterController.text)
                          //       .then((value) {
                          //     Navigator.pushNamed(context, '/login')
                          //         .whenComplete(() {
                          //       // ignore: avoid_print
                          //       print("DENEME");
                          //       //buraya girip false yapmiyor, galiba girmiyor, IM not sure
                          //       registerController.isLoading.value = false;
                          //     });
                          //   }); //telefona bildirim gelsin haberle alakali
                          // }
                        },
                        child: registerController.isLoading.value
                            ? const CircularProgressIndicator()
                            : Text(registerController.text.toString(),
                                style: const TextStyle(
                                    fontSize: 27, color: Colors.black87))
                        // const Text(
                        //   'CREATE',
                        //   style: TextStyle(fontSize: 27, color: Colors.black87),
                        // )
                        ),
                  ),
                ],
              ),
            ),
          );
        }));
  }
}
