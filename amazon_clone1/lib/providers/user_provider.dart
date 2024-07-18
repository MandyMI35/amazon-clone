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
//getter allows access to private variables/objects
  User get user => _user; //this is a getter , allowing external classes to access the _user variable

  void setUser(String user){   //string bcuz we r going to pass res.body in auth_service httperrorhandler to it
    _user = User.fromJson(user);
    notifyListeners();
  }
}