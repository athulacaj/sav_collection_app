import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

void saveUserData(Map? userData) async {
  final localData = await SharedPreferences.getInstance();

  String user = jsonEncode(userData);
  localData.setString('userNew', user);
}

Future<Map?> getUserDataAndNotifications() async {
  final localData = await SharedPreferences.getInstance();
  String userData = localData.getString('userNew') ?? '';
  print('splash scren: $userData');
  if (userData == "null" || userData == '') {
    return null;
  } else {
    Map? user = jsonDecode(userData);
    return user;
  }
}

class UserLoginProvider extends ChangeNotifier {
  Map? userDetails;

  // adding user information when login
  void addUser(Map? user) async {
    userDetails = user;
    saveUserData(user);
    notifyListeners();
  }

  Future<bool> getUserIsLogin() async {
    userDetails = await getUserDataAndNotifications();
    print(userDetails);
    return userDetails == null ? false : true;
  }
}
