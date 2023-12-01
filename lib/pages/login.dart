import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


import '../main.dart';
import '../models/assitantmethods.dart';
import '../utils/constants.dart';
import '../utils/helper.dart';
import '../widgets/app_button.dart';
import '../widgets/input_widget.dart';
import '../widgets/progressDialog.dart';

class Login extends StatelessWidget {

  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.primaryColor,
      body: SafeArea(
        bottom: false,
        child: Container(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                right: 0.0,
                top: -20.0,
                child: Opacity(
                  opacity: 0.3,
                  child: Image.asset(
                    "assets/images/washing_machine_illustration.png",
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 15.0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Icon(
                          Icons.keyboard,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Text(
                              "Log in to your account",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  ?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 40.0,
                      ),
                      Flexible(
                        child: Container(
                          width: double.infinity,
                          constraints: BoxConstraints(
                            minHeight:
                            MediaQuery.of(context).size.height - 180.0,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30.0),
                              topRight: Radius.circular(30.0),
                            ),
                            color: Colors.white,
                          ),
                          padding: EdgeInsets.all(24.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: EdgeInsets.all(16.0),
                                child: TextFormField(
                                  controller: emailcontroller,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.email,
                                      color: Colors.grey,
                                    ),
                                    filled: true,
                                    // Set filled to true for a grey background
                                    fillColor: Colors.grey[200],
                                    hintText: "Email",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                          color: Colors.grey), // Set the border color to grey
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                          color: Colors
                                              .grey), // Set the border color to grey when focused
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(
                                height: 1,
                              ),
                              Padding(
                                padding: EdgeInsets.all(16.0),
                                child: TextFormField(
                                  obscureText: true,
                                  controller: passwordcontroller,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.password,
                                      color: Colors.grey,
                                    ),
                                    filled: true,

                                    // Set filled to true for a grey background
                                    fillColor: Colors.grey[200],
                                    hintText: "Password",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                          color: Colors.grey), // Set the border color to grey
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                          color: Colors
                                              .grey), // Set the border color to grey when focused
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: Text(
                                  "Forgot Password?",
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    color: Constants.primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),

                              Padding(
                                padding: const EdgeInsets.only(top: 21.0),
                                child: SizedBox(
                                  width: 300,
                                  height: 50,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xFFF169F00)),
                                    onPressed: () {
                                      // sendVerificationCode();
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //     builder: (context) => SMSCodeInputScreen("verificationId"),
                                      //   ),
                                      // );
                                      // _sendVerificationCode();

                                      loginAndAuthenticateUser(context);
                                      // Implement Firebase email/password sign-in logic here
                                    },
                                    child: Text(
                                      "Continue",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                              // AppButton(
                              //   type: ButtonType.PRIMARY,
                              //   text: "Log In",
                              //   onPressed: () {
                              //     nextScreen(context, "/dashboard");
                              //   },
                              // )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void loginAndAuthenticateUser(BuildContext context) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return ProgressDialog(
            message: "Logging you ,Please wait.",
          );
        });

    Future signInWithEmailAndPassword(String email, String password) async {
      try {
        UserCredential result = await _firebaseAuth.signInWithEmailAndPassword(
            email: emailcontroller.text.trim(), password: emailcontroller.text.trim());
        User? user = result.user;
        return _firebaseAuth;
      } catch (error) {
        print(error.toString());
        return null;
      }
    }

    final User? firebaseUser = (await _firebaseAuth
        .signInWithEmailAndPassword(
        email: emailcontroller.text.trim(),
        password: passwordcontroller.text.trim())
        .catchError((errMsg) {
      Navigator.pop(context);
      displayToast("Error" + errMsg.toString(), context);
    }))
        .user;
    try {
      UserCredential userCredential =
      await _firebaseAuth.signInWithEmailAndPassword(
          email: emailcontroller.text.trim(), password: passwordcontroller.text.trim());

      if (clients != null) {
        AssistantMethod.getCurrentOnlineUserInfo(context);

        Navigator.of(context).pushNamed("/dashboard");

        displayToast("Logged-in ", context);
      } else {
        displayToast("Error: Cannot be signed in", context);
      }
    } catch (e) {
      // handle error
    }
  }

  displayToast(String message, BuildContext context) {
    Fluttertoast.showToast(msg: message);

// user created
  }

}