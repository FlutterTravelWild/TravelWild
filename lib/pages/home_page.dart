import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertravelwild/pages/ListplacePage.dart';
import 'package:fluttertravelwild/pages/Login_page.dart';
import 'package:fluttertravelwild/pages/favorites_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var currentPage = 0;
  late List<Widget> pages;

  @override
  void initState() {
    _loadPages();
    super.initState();
  }

  void _loadPages() {
    pages = [];
    pages.add(ListplacePage());
    pages.add(FavoritesPage());
  }

  void _onItemTapped(int page) {
    setState(() {
      currentPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sitios turisticos de Medellin"),
        actions: [
          PopupMenuButton(
            onSelected: (Menu item) {
              setState(() {
                if (item == Menu.logOut) {
                  FirebaseAuth.instance.signOut();
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()));
                }
              });
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<Menu>>[
              const PopupMenuItem(
                value: Menu.logOut,
                child: Text("Cerrar sesion"),
              ),
            ],
          ),
        ],
      ),
      body: IndexedStack(
        index: currentPage,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentPage,
        onTap: (page) {
          _onItemTapped(page);
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.mountainCity,
                size: 20,
              ),
              label: "Sitios turisticos"),
          BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.heart,
                size: 20,
              ),
              label: "Mis favoritos"),
          BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.locationDot,
                size: 20,
              ),
              label: "Sitios turisticos"),
        ],
      ),
    );
  }
}
