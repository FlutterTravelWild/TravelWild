import 'package:hive/hive.dart';

part 'local_sities.g.dart';

@HiveType(typeId: 0)
class LocalSities extends HiveObject {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? description;
  @HiveField(3)
  String? imageLink;
}
