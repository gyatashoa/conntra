import 'package:contra/model/user.dart';
import 'package:hive_flutter/adapters.dart';

class StorageService {
  late Box<User> userBox;

  Future<StorageService> init() async {
    userBox = await Hive.openBox<User>('user');
    return this;
  }

  User? get getUser => userBox.get('currentUser');

  Future<void> saveUser(User user) async {
    await userBox.put('currentUser', user);
  }

  Future<void> deleteUser() async {
    await userBox.delete('currentUser');
  }
}
