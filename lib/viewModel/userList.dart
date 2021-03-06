import 'dart:convert';

import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:usersList/model/user_DetailModel.dart';
import 'package:usersList/model/user_listModel.dart';
import 'package:usersList/viewModel/Network.dart';

class UserListApi with ChangeNotifier {
  UserList _userList;
  UserDetails _userDetails;
  Box feedsBox = Hive.box('userList');

  // ignore: unused_element
  Future<UserList> getUsersList(BuildContext context) async {
    var listener =
        DataConnectionChecker().onStatusChange.listen((status) async {
      switch (status) {
        case DataConnectionStatus.connected:
          print('Data connection is available.');
          try {
            var response =
                await Provider.of<HttpService>(context, listen: false)
                    .getData('user?limit=100');

            if (response.statusCode == 200) {
              var data = json.decode(response.body);
              _userList = UserList.fromJson(data);

              return _userList;
            }
            notifyListeners();
          } catch (e) {
            print(e);
            print(e.message);
          }

          break;
        case DataConnectionStatus.disconnected:
          print('no network');
          getUsersLocally(context);

          break;
      }
    });

    await Future.delayed(Duration(seconds: 30));
    await listener.cancel();
    return _userList;
  }

  Future<UserDetails> getUserDetails(BuildContext context) async {
    var listener =
        DataConnectionChecker().onStatusChange.listen((status) async {
      switch (status) {
        case DataConnectionStatus.connected:
          print('Data connection is available.');
          try {
            var response =
                await Provider.of<HttpService>(context, listen: false)
                    .getData('user/${feedsBox.get('USERID')}');

            if (response.statusCode == 200) {
              var data = json.decode(response.body);
              _userDetails = UserDetails.fromJson(data);
              return _userDetails;
            }
            notifyListeners();
          } catch (e) {
            print(e);
            print(e.message);
          }
          break;
        case DataConnectionStatus.disconnected:
          print('no internet.');

          break;
      }
    });
    await Future.delayed(Duration(seconds: 30));
    await listener.cancel();
    return _userDetails;
  }

  Future getUsersLocally(BuildContext context) async {
    final assetBundle = DefaultAssetBundle.of(context);
    final data = await assetBundle.loadString('assets/users.json');
    final body = json.decode(data);

    return body;
  }

  showToast(BuildContext context, msg) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Scaffold.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(
          behavior: SnackBarBehavior.fixed,
          backgroundColor: Colors.red,
          shape: RoundedRectangleBorder(),
          content: Text(
            msg,
            style: TextStyle(fontSize: 12, color: Colors.white),
          ),
          duration: Duration(seconds: 10),
        ));
    });
  }
}
