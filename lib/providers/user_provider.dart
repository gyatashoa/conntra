import 'package:flutter/foundation.dart';

import '../model/user.dart';

class UserProvider extends ChangeNotifier {
  late User? _user;

  UserProvider({User? user}) {
    _user = user;
  }

  set setUser(User user) {
    _user = user;
    notifyListeners();
  }

  User? get getUser => _user;

  bool get isLoggedIn => _user != null;
}
