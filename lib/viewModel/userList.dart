import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:usersList/model/user_DetailModel.dart';
import 'package:usersList/model/user_listModel.dart';
import 'package:usersList/viewModel/Network.dart';

class UserListApi with ChangeNotifier {
  UserList _userList;
  UserDetails _userDetails;
  Box<String> feedsBox = Hive.box('userList');

  // ignore: unused_element
  Future<UserList> getUsersList(BuildContext context) async {
    try {
      var response =
          await Provider.of<HttpService>(context).getData('user?limit=100');

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        _userList = UserList.fromJson(data);
        return _userList;
      }
      notifyListeners();
    } catch (e) {
      print(e);
      return e.message;
    }
    return _userList;
  }

  Future<UserDetails> getUserDetails(BuildContext context) async {
    try {
      var response = await Provider.of<HttpService>(context)
          .getData('user/3JAf8R85oIlxXd58Piqk');

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        _userDetails = UserDetails.fromJson(data);
        return _userDetails;
      }
      notifyListeners();
    } catch (e) {
      print(e);
      return e.message;
    }
    return _userDetails;
  }
}
