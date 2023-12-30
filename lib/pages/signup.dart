
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:laundry/pages/login.dart';

import '../main.dart';
import '../utils/constants.dart';
import '../widgets/progressDialog.dart';

class signup extends StatefulWidget {
  const signup({super.key});

  @override
  State<signup> createState() => _signupState();
}
TextEditingController _emailcontroller = TextEditingController();
TextEditingController _usernamecontroller = TextEditingController();
TextEditingController _phonecontroller = TextEditingController();
TextEditingController _passwordcontroller = TextEditingController();
File? _riderImage;


final ImagePicker _imagePicker = ImagePicker();
class _signupState extends State<signup> {
  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery
        .of(context)
        .size;
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
                              "Sign Up",
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
                              Column(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  // Padding(
                                  //   padding: EdgeInsets.only(
                                  //     top: size.width * .1,
                                  //     bottom: size.width * .1,
                                  //   ),
                                  //   child: SizedBox(
                                  //     height: 70,
                                  //     child: Image.asset(
                                  //       'assets/images/logo.png',
                                  //       // #Image Url: https://unsplash.com/photos/bOBM8CB4ZC4
                                  //       fit: BoxFit.fitHeight,
                                  //     ),
                                  //   ),
                                  // ),

                                  //Username

                                  Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          height: size.width / 7,
                                          width: size.width /1,
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.only(right: size.width / 30),
                                          decoration: BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          child: TextField(
                                            style: TextStyle(
                                              color: Colors.white.withOpacity(.9),
                                            ),
                                            controller: _usernamecontroller,
                                            // onChanged: (value){
                                            //   _firstName = value;
                                            // },
                                            // obscureText: isPassword,
                                            // keyboardType: isEmail ? TextInputType.name : TextInputType.text,
                                            decoration: InputDecoration(
                                              prefixIcon: Icon(
                                                Icons.account_circle_outlined,
                                                color: Colors.white.withOpacity(.8),
                                              ),
                                              border: InputBorder.none,
                                              hintMaxLines: 1,
                                              hintText:'UserName',
                                              hintStyle: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white.withOpacity(.5),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          height: size.width / 7,
                                          width: size.width / 1,
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.only(
                                              right: size.width / 30),
                                          decoration: BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          child: TextField(
                                            style: TextStyle(
                                              color: Colors.white.withOpacity(.9),
                                            ),
                                            controller: _phonecontroller,
                                            // onChanged: (value){
                                            //   _phonecontroller = value as TextEditingController;
                                            // },

                                            keyboardType:  TextInputType.phone ,
                                            decoration: InputDecoration(
                                              prefixIcon: Icon(
                                                Icons.phone,
                                                color: Colors.white.withOpacity(.9),
                                              ),
                                              border: InputBorder.none,
                                              hintMaxLines: 1,
                                              hintText: 'Phone Number...',
                                              hintStyle: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white.withOpacity(.5),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),


                                  //email
                                  Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          height: size.width / 7,
                                          width: size.width / 1,
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.only(
                                              right: size.width / 30),
                                          decoration: BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          child: TextField(
                                            style: TextStyle(
                                              color: Colors.white.withOpacity(.9),
                                            ),
                                            controller: _emailcontroller,
                                            // onChanged: (value){
                                            //   _emailcontroller = value as TextEditingController;
                                            // },
                                            // obscureText: isPassword,
                                            keyboardType:  TextInputType.emailAddress ,
                                            decoration: InputDecoration(
                                              prefixIcon: Icon(
                                                Icons.email,
                                                color: Colors.white.withOpacity(.8),
                                              ),
                                              border: InputBorder.none,
                                              hintMaxLines: 1,
                                              hintText: 'Email...',
                                              hintStyle: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white.withOpacity(.5),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      //pass
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          height: size.width / 7,
                                          width: size.width / 1,
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.only(
                                              right: size.width / 30),
                                          decoration: BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          child: TextField(
                                            style: TextStyle(
                                              color: Colors.white.withOpacity(.9),
                                            ),
                                            controller: _passwordcontroller,
                                            obscureText: true,
                                            // onChanged: (value){
                                            //   _passwordcontroller=value as TextEditingController;
                                            // },
                                            // keyboardType: isPassword ? TextInputType.name : TextInputType.text,
                                            decoration: InputDecoration(
                                              prefixIcon: Icon(
                                                Icons.password,
                                                color: Colors.white.withOpacity(.8),
                                              ),
                                              border: InputBorder.none,
                                              hintMaxLines: 1,
                                              hintText: 'Password...',
                                              hintStyle: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  // Date of Birth
                                  Column(
                                    children: [



                                    ],
                                  ),





                                  SizedBox(height: size.width * 0.019),
                                  // InkWell(
                                  //   splashColor: Colors.transparent,
                                  //   highlightColor: Colors.transparent,
                                  //   onTap: () {
                                  //     // registerInfirestore(context);
                                  //     registerNewUser(context);
                                  //     HapticFeedback.lightImpact();
                                  //
                                  //   },
                                  //   child: Container(
                                  //     margin: EdgeInsets.only(
                                  //       bottom: size.width * .05,
                                  //     ),
                                  //     height: size.width / 8,
                                  //     width: size.width / 1.25,
                                  //     alignment: Alignment.center,
                                  //     decoration: BoxDecoration(
                                  //       color:  Color(0xFFF169F00),
                                  //       borderRadius: BorderRadius.circular(20),
                                  //     ),
                                  //     child: Text(
                                  //       'Sign-up',
                                  //       style: TextStyle(
                                  //         color: Colors.white,
                                  //         fontSize: 20,
                                  //         fontWeight: FontWeight.w600,
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                ],
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

                                      registerNewUser(context);
                                      // Implement Firebase email/password sign-in logic here
                                    },
                                    child: Text(
                                      "Sign Up",
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
  User ?firebaseUser;
  User? currentfirebaseUser;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Widget _buildImagePicker({required String title, required Function(File) setImage}) {
    return Column(
      children: <Widget>[
        Text("ProfileImage",style: TextStyle(fontWeight: FontWeight.bold),),
        SizedBox(height: 14),

        CircleAvatar(
          radius: 50, // Adjust the radius as needed
          backgroundColor: Colors.blue, // Background color of the avatar
          child: _riderImage != null
              ? ClipOval(
            child: Image.file(
              _riderImage!,
              width: 100, // Adjust the width as needed
              height: 100, // Adjust the height as needed
              fit: BoxFit.cover, // Adjust the BoxFit as needed
            ),
          )
              : GestureDetector(
            onTap: () {
              _pickImage(ImageSource.gallery, setImage);
            },

            child: ClipOval(
              child: Image.asset(
                "assets/images/imgicon.png",
                width: 100, // Adjust the width as needed
                height: 100, // Adjust the height as needed
                fit: BoxFit.cover, // Adjust the BoxFit as needed
              ),
            ),
          ),
        ),
        SizedBox(height: 10),

        // _buildImagePreview(setImage),
        // ElevatedButton(
        //   onPressed: () {
        //     _pickImage(ImageSource.gallery, setImage);
        //   },
        //   child: Text('Pick from Gallery'),
        // ),
        // ElevatedButton(
        //   onPressed: () {
        //     _pickImage(ImageSource.camera, setImage);
        //   },
        //   child: Text('Take a Photo'),
        // ),
      ],
    );
  }

  Future<String> _uploadImageToStorage(File? imageFile) async {
    if (imageFile == null) {
      return ''; // Return an empty string if no image is provided
    }

    final Reference storageReference =
    FirebaseStorage.instance.ref().child('profile_images/${DateTime.now().toString()}');
    final UploadTask uploadTask = storageReference.putFile(imageFile);
    await uploadTask.whenComplete(() => null);
    final String downloadURL = await storageReference.getDownloadURL();
    return downloadURL;
  }
  Future<void> registerNewUser(BuildContext context) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return ProgressDialog(
            message: "Registering,Please wait.....",
          );
        });


    firebaseUser = (await _firebaseAuth
        .createUserWithEmailAndPassword(
      email: _emailcontroller.text,
      password: _passwordcontroller.text,)
        .catchError((errMsg) {
      Navigator.pop(context);
      displayToast("Error" + errMsg.toString(), context);
    }))
        .user;
    final riderImageUrl = await _uploadImageToStorage(_riderImage);

    if (firebaseUser != null) // user created

        {
      //save use into to database
      await firebaseUser?.sendEmailVerification();
      Map userDataMap = {
        'riderImageUrl': riderImageUrl,
        "email": _emailcontroller.text.trim(),
        "Username":_usernamecontroller.text.trim(),
        "phone": _phonecontroller.text.trim(),
        "Password": _passwordcontroller.text.trim(),
        // 'Date Of Birth': selectedDate!.toLocal().toString().split(' ')[0],
        // "Dob":birthDate,
        // "Gender":Gender,
      };
      clients.child(firebaseUser!.uid).set(userDataMap);
      // Admin.child(firebaseUser!.uid).set(userDataMap);

      currentfirebaseUser = firebaseUser;
      // registerInfirestore(context);
      displayToast("Congratulation, your account has been created", context);
      // displayToast("A verification has been sent to your mail", context);


      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => Login()),
              (Route<dynamic> route) => false);
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          return Login();
        }),
      );
      // Navigator.pop(context);
      //error occured - display error
      displayToast("user has not been created", context);
    }
  }

  Future<void> _pickImage(ImageSource source, Function(File) setImage) async {
    final pickedFile = await _imagePicker.getImage(source: source);
    if (pickedFile != null) {
      setImage(File(pickedFile.path));
    }
  }

  displayToast(String message, BuildContext context) {
    Fluttertoast.showToast(msg: message);

// user created

  }
}
