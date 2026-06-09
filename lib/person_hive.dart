import 'package:hive/hive.dart';

part 'person_hive.g.dart';

@HiveType(typeId: 0)
class personHive extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  int age;

  @HiveField(2)
  String email;
  
  personHive({
    required this.name,
    required this.age,
    required this.email,
  });
}