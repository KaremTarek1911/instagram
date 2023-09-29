import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instagram/provider/user_provider.dart';
import 'package:flutter_instagram/responsive/mobile.dart';
import 'package:flutter_instagram/responsive/responsive.dart';
import 'package:flutter_instagram/responsive/web.dart';
import 'package:flutter_instagram/screens/sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_instagram/shared/snackbar.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyBHC0FH1uhTdgh8w0gswGxEsZJ6t-kP-Lk",
            authDomain: "instagram-a1dc4.firebaseapp.com",
            projectId: "instagram-a1dc4",
            storageBucket: "instagram-a1dc4.appspot.com",
            messagingSenderId: "897986070652",
            appId: "1:897986070652:web:f86ed3d8e56c64d08921f9"));
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return UserProvider();
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: CircularProgressIndicator(
                color: Colors.white,
              ));
            } else if (snapshot.hasError) {
              return showSnackBar(context, "Something went wrong");
            } else if (snapshot.hasData) {
              return const Responsive(
                myMobileScreen: MobileScreen(),
                myWebScreen: WebScreen(),
              );
            } else {
              return const Login();
            }
          },
        ),
        // home: Resposive(
        //   myMobileScreen: MobileScerren(),
        //   myWebScreen: WebScerren(),
        // ),
      ),
    );
  }
}
