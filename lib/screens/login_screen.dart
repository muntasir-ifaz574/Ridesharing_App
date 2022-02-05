import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:uber/main.dart';
import 'package:uber/screens/home_screen.dart';
import 'package:uber/screens/registeration_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const String idScreen = "login";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 35,
              ),
              Image(
                image: AssetImage("assets/images/logo.png"),
                width: 390,
                height: 290,
                alignment: Alignment.center,
              ),
              SizedBox(
                height: 1,
              ),
              Text(
                "Login as a Rider",
                style: TextStyle(
                  fontSize: 24,
                  fontFamily: "Brand Bold",
                ),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    SizedBox(height: 1),
                    TextField(
                      controller: emailTextEditingController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "Email",
                        labelStyle: TextStyle(
                          fontSize: 14,
                        ),
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 10,
                        ),
                      ),
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 1),
                    TextField(
                      controller: passwordTextEditingController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Password",
                        labelStyle: TextStyle(
                          fontSize: 14,
                        ),
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 10,
                        ),
                      ),
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.amber.shade400,
                        minimumSize: Size(150, 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      onPressed: () {
                        if (!emailTextEditingController.text.contains("@")) {
                          displayTostMessage(
                              "Email address is not valid", context);
                        } else if (passwordTextEditingController.text.isEmpty) {
                          displayTostMessage("Password is mandatory", context);
                        } else {
                          loginUser(context);
                        }
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontFamily: "Brand Bold"),
                      ),
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, RegisterationScreen.idScreen, (route) => false);
                },
                child: Text(
                  "Don't have an Account? Register Here",
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontFamily: "Brand-Regular",
                    fontSize: 15,
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

  void loginUser(BuildContext context) async {
    final User? firebaseUser = (await _firebaseAuth
            .signInWithEmailAndPassword(
      email: emailTextEditingController.text,
      password: passwordTextEditingController.text,
    )
            .catchError((errMsg) {
      displayTostMessage("Error: " + errMsg.toString(), context);
    }))
        .user;
    if (firebaseUser != null) {
      userRef
          .child(firebaseUser.uid)
          .once()
          .then((value) => (DataSnapshot snap) {
                if (snap.value != null) {
                  Navigator.pushNamedAndRemoveUntil(
                      context, HomeScreen.idScreen, (route) => false);
                  displayTostMessage("You are logged in", context);
                } else {
                  _firebaseAuth.signOut();
                  displayTostMessage(
                      "No info exist. Please creat an account", context);
                }
              });
    } else {
      displayTostMessage("Erro Accured, Can't be Signed-in", context);
    }
  }
  // Future<User?> fireLogin(String email, String password) async {
  //   FirebaseAuth _auth = FirebaseAuth.instance;

  //   try {
  //     final loggedInUser = await _auth.signInWithEmailAndPassword(
  //       email: email,
  //       password: password,
  //     );
  //     loginUser().save(_auth.currentUser!.uid);
  //     print(_auth.currentUser!.uid);
  //     if (loggedInUser != null) {
  //       Navigator.pushNamedAndRemoveUntil(
  //           context, HomeScreen.idScreen, (route) => false);
  //     }
  //   } catch (e) {
  //     print(e);
  //     return null;
  //   }
  // }
}
