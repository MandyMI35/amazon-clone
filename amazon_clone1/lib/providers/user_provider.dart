import 'package:amazon_clone1/models/user.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
    id: '', 
    name: '', 
    email: '', 
    password: '', 
    address: '', 
    type: '', 
    token: ''
  );

  User get user => _user;

  void setUser(String user){   //string bcuz we r going to pass res.body in auth_service httperrorhandler to it
    _user = User.fromJson(user);
    notifyListeners();
  }
}