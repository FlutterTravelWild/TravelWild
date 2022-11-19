import 'package:fluttertravelwild/models/local_sities.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Boxes {
  static Box<LocalSities> getFavoritesBox() => Hive.box<LocalSities>('favorites');
}
