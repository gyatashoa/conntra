// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 1;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User(
      id: fields[0] as String,
      dob: fields[2] as DateTime,
      gender: fields[3] as Gender,
      username: fields[4] as String,
      schoolId: fields[6] as int,
      hostelId: fields[7] as int,
      password: fields[8] as String,
      name: fields[1] as String,
      email: fields[5] as String,
      token: fields[9] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.dob)
      ..writeByte(3)
      ..write(obj.gender)
      ..writeByte(4)
      ..write(obj.username)
      ..writeByte(5)
      ..write(obj.email)
      ..writeByte(6)
      ..write(obj.schoolId)
      ..writeByte(7)
      ..write(obj.hostelId)
      ..writeByte(8)
      ..write(obj.password)
      ..writeByte(9)
      ..write(obj.token);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
