import 'package:flutter/material.dart';
import 'package:fluttertravelwild/models/local_sities.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../boxes.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: Center(
          child: _buildListView(),
        ),
      ),
    );
  }

  Widget _buildListView() {
    return ValueListenableBuilder<Box<LocalSities>>(
        valueListenable: Boxes.getFavoritesBox().listenable(),
        builder: (context, box, _) {
          final sitiesBox = box.values.toList().cast<LocalSities>();
          return ListView.builder(
            itemCount: sitiesBox.length,
            itemBuilder: (BuildContext context, int index) {
              final sities = sitiesBox[index];
              return Card(
                  child: ListTile(
                leading: Image.network(
                  sities.imageLink ?? "",
                  errorBuilder: (BuildContext context, Object exception,
                      StackTrace? stackTrace) {
                    return const Image(
                      image: AssetImage('assets/images/logoturismo.png'),
                    );
                  },
                ),
                title: Text(sities.name ?? "No title"),
              ));
            },
          );
        });
  }
}
