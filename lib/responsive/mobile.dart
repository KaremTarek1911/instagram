import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instagram/screens/add_post.dart';
import 'package:flutter_instagram/screens/home.dart';
import 'package:flutter_instagram/screens/profile.dart';
import 'package:flutter_instagram/screens/search.dart';
import 'package:flutter_instagram/shared/colors.dart';

class MobileScreen extends StatefulWidget {
  const MobileScreen({super.key});

  @override
  State<MobileScreen> createState() => _MobileScreenState();
}

class _MobileScreenState extends State<MobileScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int currentpage = 0;
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: mobileBackgroundColor,
        onTap: (index) {
          _pageController.jumpToPage(index);
          setState(() {
            currentpage = index;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(
            Icons.home,
            color: currentpage == 0 ? primaryColor : secondaryColor,
          )),
          BottomNavigationBarItem(
              icon: Icon(
            Icons.search,
            color: currentpage == 1 ? primaryColor : secondaryColor,
          )),
          BottomNavigationBarItem(
              icon: Icon(
            Icons.add_circle,
            color: currentpage == 2 ? primaryColor : secondaryColor,
          )),
          BottomNavigationBarItem(
              icon: Icon(
            Icons.favorite,
            color: currentpage == 3 ? primaryColor : secondaryColor,
          )),
          BottomNavigationBarItem(
              icon: Icon(
            Icons.person,
            color: currentpage == 4 ? primaryColor : secondaryColor,
          )),
        ],
      ),
      body: PageView(
        onPageChanged: (index) {},
        controller: _pageController,
        children: [
          const Home(),
          const Search(),
          const AddPost(),
          const Center(child: Text('Love u ♥')),
          Profile(
            uiddd: FirebaseAuth.instance.currentUser!.uid,
          ),
        ],
      ),
    );
  }
}
