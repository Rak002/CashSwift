import 'package:cashswift/modules/util_functions.dart';
import 'package:flutter/material.dart';
import 'package:cashswift/screens/register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController email_;
  late final TextEditingController password_;
  @override
  void initState() {
    email_ = TextEditingController();
    password_ = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    email_.dispose();
    password_.dispose();
    super.dispose();
  }

  bool show_password = false;
  String email_error = "";
  String password_error = "";
  String general_error = "";
  bool show_usersignin_success = false;

  void changeShowPassword(bool bl) {
    setState(() {
      show_password = bl;
      changeEmailError("");
      changePasswordError("");
      changeGeneralError("");
    });
  }

  void changeEmailError(String str) {
    setState(() {
      email_error = str;
    });
  }

  void changePasswordError(String str) {
    setState(() {
      password_error = str;
    });
  }

  void changeGeneralError(String str) {
    setState(() {
      general_error = str;
    });
  }

  void changeUserCrtSuccess(bool bl) {
    setState(() {
      show_usersignin_success = bl;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // You can define the action here
            Navigator.of(context).pop();
          },
          color: Colors.white, // Change the color of the back button
        ),
        backgroundColor: Color.fromARGB(255, 46, 15, 99),
        title: Text(
          " Login",
          style: GoogleFonts.notoSans(
            textStyle: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color:Colors.white,
            ),
          ),
        ),
      ),
      extendBody: true,
      body: Container(
        width: double.maxFinite,
                height: double.maxFinite,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 64, 36, 143),
              Color.fromARGB(255, 168, 107, 41)
            ],
          ),
        ),
        child: ListView(children: [
          (!show_usersignin_success)
              ? Container()
              : Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 20,
                    bottom: 0,
                  ),
                  child: Row(children: [
                    const Icon(
                      Icons.check_circle,
                      size: 25.0,
                      color:  Color.fromARGB(255, 118, 212, 121),
                    ),
                    Text(
                      " Login Successful",
                      style: GoogleFonts.notoSans(
                        textStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 118, 212, 121),
                        ),
                      ),
                    ),
                  ]),
                ),
          (general_error == "")
              ? Container()
              : Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 10,
                    bottom: 0,
                  ),
                  child: Row(children: [
                    const Icon(
                      Icons.error,
                      size: 25.0,
                      color:  Color.fromARGB(255, 255, 103, 92),
                    ),
                    Text(
                      " $general_error",
                      style: GoogleFonts.notoSans(
                        textStyle: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 255, 103, 92),
                        ),
                      ),
                    ),
                  ]),
                ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 25,
                right: 20,
                top: 25,
                bottom: 20,
              ),
              child: Row(children: [
                const Icon(
                  Icons.email,
                  size: 25.0,
                  color:Color.fromARGB(255, 241, 212, 180),
                ),
                Text(
                  ' Email',
                  style: GoogleFonts.notoSans(
                    textStyle: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color:Color.fromARGB(255, 241, 212, 180),
                    ),
                  ),
                ),
              ]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 15,
              right: 15,
              top: 10,
              bottom: 10,
            ),
            child: TextField(
              controller: email_,
              enableSuggestions: false,
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              cursorColor: Color.fromARGB(255, 241, 212, 180),
              style: GoogleFonts.notoSans(
                textStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color:Color.fromARGB(255, 241, 212, 180)
                ),
              ),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color:(email_error == "")? Color.fromARGB(255, 241, 212, 180):Color.fromARGB(255, 255, 91, 79),
                    width: 2.0,
                  ),
                ),
                enabledBorder:OutlineInputBorder(
                  borderSide:BorderSide(
                    color:(email_error == "")? Color.fromARGB(255, 241, 212, 180):Color.fromARGB(255, 255, 91, 79),
                    width: 1.0,
                  ),
                ),
                hintText: 'Enter Email',
                hintStyle: TextStyle(
                  color: Color.fromARGB(160, 241, 212, 180),
                ),
              ),
            ),
          ),
          (email_error == "")
              ? Container()
              : SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: 0,
                      bottom: 5,
                    ),
                    child: Row(children: [
                      const Icon(
                        Icons.error,
                        size: 20.0,
                        color: Color.fromARGB(255, 255, 91, 79),
                      ),
                      Text(
                        " $email_error",
                        style: GoogleFonts.notoSans(
                          textStyle: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 255, 80, 68),
                          ),
                        ),
                      ),
                    ]),
                  ),
              ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 25,
                right: 20,
                top: 20,
                bottom: 20,
              ),
              child: Row(children: [
                const Icon(
                  Icons.key,
                  size: 25.0,
                  color: Color.fromARGB(255, 241, 212, 180),
                ),
                Text(
                  ' Password',
                  style: GoogleFonts.notoSans(
                    textStyle: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color:Color.fromARGB(255, 241, 212, 180),
                    ),
                  ),
                ),
              ]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 15,
              right: 15,
              top: 10,
              bottom: 10,
            ),
            child: TextField(
              controller: password_,
              obscureText: !show_password,
              enableSuggestions: false,
              autocorrect: false,
              cursorColor: Color.fromARGB(255, 241, 212, 180),
              style: GoogleFonts.notoSans(
                textStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color:Color.fromARGB(255, 241, 212, 180),
                ),
              ),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color:(password_error == "")? Color.fromARGB(255, 241, 212, 180):Color.fromARGB(255, 255, 91, 79),
                    width: 2.0,
                  ),
                ),
                enabledBorder:OutlineInputBorder(
                  borderSide:BorderSide(
                    color:(password_error == "")? Color.fromARGB(255, 241, 212, 180):Color.fromARGB(255, 255, 91, 79),
                    width: 1.0,
                  ),
                ),
                hintText: 'Enter Password',
                hintStyle: TextStyle(
                  color: Color.fromARGB(160, 241, 212, 180),
                ),
              ),
            ),
          ),
          (password_error == "")
              ? Container()
              : SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: 0,
                      bottom: 5,
                    ),
                    child: Row(children: [
                      const Icon(
                        Icons.error,
                        size: 20.0,
                        color: Color.fromARGB(255, 255, 91, 79),
                      ),
                      Text(
                        " $password_error",
                        style: GoogleFonts.notoSans(
                          textStyle: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 255, 80, 68),
                          ),
                        ),
                      ),
                    ]),
                  ),
              ),
          Padding(
            padding: const EdgeInsets.only(
              left: 10,
              right: 15,
            ),
            child: Row(children: [
              Checkbox(
                side: const BorderSide(color: Color.fromARGB(129, 241, 212, 180),width: 2.0,),
                checkColor:Color.fromARGB(255, 72, 36, 64),
                value: show_password,
                activeColor:Color.fromARGB(255, 241, 212, 180),
                
                onChanged: (bool) {
                  if (show_password) {
                    changeShowPassword(false);
                  } else {
                    changeShowPassword(true);
                  }
                },
              ),
              Text(
                "Show Password",
                style: GoogleFonts.notoSans(
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color:Color.fromARGB(255, 241, 212, 180),
                  ),
                ),
              ),
            ]),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
              left: 25,
              bottom: 10,
              right: 10,
            ),
            child: Row(children: [
              Text(
                'Not Registered? ',
                style: GoogleFonts.notoSans(
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 218, 218, 218),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
                    return RegisterScreen();
                  }));
                },
                child: Text(
                  'Register',
                  style: GoogleFonts.notoSans(
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 194, 171, 233),
                    ),
                  ),
                ),
              )
            ]),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 30,
              left: 60,
              bottom: 30,
              right: 60,
            ),
            child: OutlinedButton(
              onPressed: () async {
                final email = email_.text;
                final password = password_.text;
                print("Email entered by user : ${email}");
                print("Password entered by user : ${password}");
                try {
                  final userCredential = await FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                          email: email, password: password);
                  print("UserCredential : $userCredential");
                  final user = FirebaseAuth.instance.currentUser;
                  if (user != null) {
                    if (user.emailVerified) {
                      changeUserCrtSuccess(true);
                      changeEmailError("");
                      changePasswordError("");
                      changeGeneralError("");
                      // ignore: use_build_context_synchronously
                      showSnackBar(context, "Login Successful", "success");
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        return Placeholder(); // to home screen
                      }));
                    } else {
                      await (FirebaseAuth.instance.currentUser)
                          ?.sendEmailVerification();
                      await FirebaseAuth.instance.signOut();
                      changeEmailError("");
                      changePasswordError("");
                      changeGeneralError(
                          " Email Not Verified!\n  Verification Email Send to this Email.");
                      showSnackBar(context, "Email Not Verified!", "error");
                    }
                  }
                } catch (e) {
                  changeUserCrtSuccess(false);
                  if (e is FirebaseAuthException) {
                    if (e.code == "invalid-email") {
                      changeEmailError(
                          "Invalid Email! Make sure it's a valid email");
                      changePasswordError("");
                      changeGeneralError("");
                      showSnackBar(context, "Invalid Email! Make sure it's a valid email", "error");
                    } else if (e.code == "user-disabled") {
                      changeEmailError(
                          "This User is Disabled! Write to us to enable");
                      changePasswordError("");
                      changeGeneralError("");
                      showSnackBar(context, "This User is Disabled! Write to us to enable", "error");
                    } else if (e.code == "user-not-found") {
                      changeEmailError("User not found!");
                      changePasswordError("");
                      changeGeneralError("");
                      showSnackBar(context, "User not Found", "error");
                    } else if (e.code == "wrong-password") {
                      changeEmailError("");
                      changePasswordError("Wrong Password!");
                      changeGeneralError("");
                      showSnackBar(context, "Wrong Password!", "error");
                    } else if (e.code == "operation-not-allowed") {
                      changeEmailError("");
                      changePasswordError("");
                      changeGeneralError("Not Allowed!");
                      showSnackBar(context, "Not Allowed!", "error");
                    } else if (e.code == "network-request-failed") {
                      changeEmailError("");
                      changePasswordError("");
                      changeGeneralError("Network Request Failed!");
                      showSnackBar(context, "Network Request Failed!", "error");
                    } else if (e.code == "too-many-requests") {
                      changeEmailError("");
                      changePasswordError("");
                      changeGeneralError("Too Many Requests!");
                      showSnackBar(context, "Too Many Requests!", "error");
                    } else {
                      changeEmailError("");
                      changePasswordError("");
                      changeGeneralError(e.code);
                      showSnackBar(context, e.code, "error");
                      print(e);
                    }
                  }
                }
              },
              style: OutlinedButton.styleFrom(
                fixedSize: Size(70, 50),
                backgroundColor:Color.fromARGB(94, 156, 129, 231),
                side: const BorderSide(
                    width: 3.0, color: Color.fromARGB(255, 239, 234, 255),),
              ),
              child: Text(
                'Login',
                style: GoogleFonts.notoSans(
                  textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color:Color.fromARGB(255, 237, 231, 255),
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
