
import 'package:flutter/material.dart';
import 'package:fluttertravelwild/pages/fav_place_page.dart';
import 'package:fluttertravelwild/pages/places_pages.dart';
import 'package:fluttertravelwild/pages/profile_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var currentPage = 0;
  late List<Widget> pages;

  void initState() {
    // _closeSplash();
    _loadPages();
    super.initState();
  }

  void _loadPages() {
    pages = [];
    pages.add(ProfilePage());
    pages.add(PlaceStorePage());
    pages.add(FavoritePlacePage());
  }

  void _onItemTapped(int page) {
    setState(() {
      currentPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: currentPage, children: pages),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentPage,
        type: BottomNavigationBarType.fixed,
        onTap: (page) {
          _onItemTapped(page);
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.home, size: 20), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.placeOfWorship, size: 20),
              label: "Places"),
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.heart, size: 20), label: "Fav"),
        ],
      ),
    );
  }
}
