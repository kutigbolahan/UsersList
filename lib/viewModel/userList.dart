import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:usersList/model/user_listModel.dart';
import 'package:usersList/viewModel/Network.dart';

class UserListApi with ChangeNotifier {
  UserList _userList;

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
}
