import 'package:cashswift/models/data_model.dart';
import 'package:cashswift/modules/ui_components.dart';
import 'package:cashswift/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cashswift/firebase_options.dart';
import 'package:cashswift/screens/login_screen.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class IntroScreen extends StatelessWidget {
  IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            return Scaffold(
              extendBody: true,
              backgroundColor: const Color.fromARGB(255, 69, 33, 115),
              body: Container(
                width: double.maxFinite,
                height: double.maxFinite,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.fromARGB(255, 66, 33, 157),
                      Color.fromARGB(255, 249, 162, 68)
                    ],
                  ),
                ),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                    Padding(
                            padding: EdgeInsets.only(
                              left: 0,
                              right: 0,
                              top: MediaQuery.of(context).size.height * 0.05,
                              bottom: 10,
                            ),
                            child: Image.asset(
                              'lib/images/fixed_images/logo.png',
                              height: 120,
                            ))
                        .animate()
                        .flip(
                            begin: -0.25,
                            end: 0,
                            curve: Curves.easeInOut,
                            duration: const Duration(milliseconds: 400))
                        .slideY(
                            begin: -0.1,
                            end: 0,
                            curve: Curves.easeInOut,
                            duration: const Duration(milliseconds: 400))
                        .fade(duration: const Duration(milliseconds: 400))
                        .blurY(begin: 5, end: 0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 20, right: 90, bottom: 10),
                          child: Text(
                            "Swiftly Sent...",
                            style: GoogleFonts.rubikScribble(
                              textStyle: const TextStyle(
                                fontSize: 29,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                            ),
                          ),
                        )
                            .animate(delay: const Duration(milliseconds: 400))
                            .slideX(
                                begin: 0.5,
                                end: 0,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeInOut)
                            .fade(),
                        Padding(
                          padding: const EdgeInsets.only(left: 60),
                          child: Text(
                            "...Swiftly Secure",
                            style: GoogleFonts.rubikScribble(
                              textStyle: const TextStyle(
                                fontSize: 29,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                            ),
                          ),
                        )
                            .animate(delay: const Duration(milliseconds: 400))
                            .slideX(
                                begin: -0.5,
                                end: 0,
                                duration: const Duration(milliseconds: 600),
                                curve: Curves.easeInOut)
                            .fade(),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.06,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        Container(
                          height: 50,
                          width: 300,
                          color: const Color.fromARGB(0, 69, 33, 115),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: const Icon(Icons.monetization_on,
                                        size: 30,
                                        color:
                                            Color.fromARGB(255, 255, 255, 255))
                                    .animate(
                                        delay:
                                            const Duration(milliseconds: 800))
                                    .rotate(
                                        begin: -0.3,
                                        end: 0,
                                        alignment: Alignment.center,
                                        duration:
                                            const Duration(milliseconds: 600),
                                        curve: Curves.easeInOut)
                                    .fade(
                                      duration:
                                          const Duration(milliseconds: 600),
                                    ),
                              ),
                              Text(
                                "Seamless Transactions  ",
                                style: GoogleFonts.notoSans(
                                  textStyle: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                  ),
                                ),
                              )
                                  .animate(
                                      delay: const Duration(milliseconds: 950))
                                  .slideX(
                                      begin: -0.1,
                                      end: 0,
                                      duration:
                                          const Duration(milliseconds: 400))
                                  .fade(
                                      duration:
                                          const Duration(milliseconds: 400)),
                            ],
                          ),
                        ),
                        Container(
                          height: 50,
                          width: 300,
                          color: const Color.fromARGB(0, 69, 33, 115),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: const Icon(Icons.qr_code_scanner,
                                        size: 30,
                                        color:
                                            Color.fromARGB(255, 255, 255, 255))
                                    .animate(
                                        delay:
                                            const Duration(milliseconds: 1200))
                                    .rotate(
                                        begin: -0.3,
                                        end: 0,
                                        alignment: Alignment.center,
                                        duration:
                                            const Duration(milliseconds: 600),
                                        curve: Curves.easeInOut)
                                    .fade(
                                      duration:
                                          const Duration(milliseconds: 600),
                                    ),
                              ),
                              Text(
                                "Fast QR Scans on the Go",
                                style: GoogleFonts.notoSans(
                                  textStyle: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                  ),
                                ),
                              )
                                  .animate(
                                      delay: const Duration(milliseconds: 1350))
                                  .slideX(
                                      begin: -0.1,
                                      end: 0,
                                      duration:
                                          const Duration(milliseconds: 400))
                                  .fade(
                                      duration:
                                          const Duration(milliseconds: 400)),
                            ],
                          ),
                        ),
                        Container(
                          height: 50,
                          width: 300,
                          color: const Color.fromARGB(0, 69, 33, 115),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: const Icon(Icons.folder_copy_rounded,
                                        size: 30,
                                        color:
                                            Color.fromARGB(255, 255, 255, 255))
                                    .animate(
                                        delay:
                                            const Duration(milliseconds: 1600))
                                    .rotate(
                                        begin: -0.3,
                                        end: 0,
                                        alignment: Alignment.center,
                                        duration:
                                            const Duration(milliseconds: 600),
                                        curve: Curves.easeInOut)
                                    .fade(
                                      duration:
                                          const Duration(milliseconds: 600),
                                    ),
                              ),
                              Text(
                                "Expenses Categorization",
                                style: GoogleFonts.notoSans(
                                  textStyle: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                  ),
                                ),
                              )
                                  .animate(
                                      delay: const Duration(milliseconds: 1750))
                                  .slideX(
                                      begin: -0.1,
                                      end: 0,
                                      duration:
                                          const Duration(milliseconds: 400))
                                  .fade(
                                      duration:
                                          const Duration(milliseconds: 400)),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.028,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              bottomNavigationBar: Padding(
                padding: const EdgeInsets.only(
                  left: 40,
                  bottom: 30,
                  right: 40,
                ),
                child: OutlinedButton(
                  onPressed: () async {
                    final currentUser = FirebaseAuth.instance.currentUser;
                    if (currentUser != null) {
                      Object res =
                          await Provider.of<DataModel>(context, listen: false)
                              .getUserData(currentUser.uid);
                      if (res != 0) {
                        showSnackBar(context, "Some Error Occurred!", "error");
                        return;
                      }
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        return const HomeScreen(); // go to home screen
                      }));
                    } else {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        return const LoginScreen(); // go to login screen
                      }));
                    }
                  },
                  style: OutlinedButton.styleFrom(
                    fixedSize: const Size(70, 50),
                    backgroundColor: const Color.fromARGB(102, 204, 185, 255),
                    side: const BorderSide(
                        width: 3.0, color: Color.fromARGB(255, 255, 255, 255)),
                  ),
                  child: Text(
                    'Get Started',
                    style: GoogleFonts.notoSans(
                      textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 255, 255, 255)),
                    ),
                  ),
                )
                    .animate(delay: const Duration(milliseconds: 1900))
                    .slideY(begin: 0.1, end: 0)
                    .fade(),
              ),
            );

          default:
            return Scaffold(
              body: Container(
                  width: double.maxFinite,
                  height: double.maxFinite,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color.fromARGB(255, 66, 33, 157),
                        Color.fromARGB(255, 249, 162, 68)
                      ],
                    ),
                  ),
                  child: const Center(
                      child: CircularProgressIndicator(
                    color: Colors.white,
                  ))),
            );
        }
      },
    );
  }
}
