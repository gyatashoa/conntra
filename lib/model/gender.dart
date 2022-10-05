import 'package:hive_flutter/adapters.dart';

part 'gender.g.dart';

@HiveType(typeId: 2)
enum Gender {
  @HiveField(0)
  MALE('M'),
  @HiveField(1)
  FEMALE('F');

  final String initial;
  const Gender(this.initial);
}
