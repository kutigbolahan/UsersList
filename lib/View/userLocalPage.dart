import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:usersList/viewModel/userList.dart';

class UserLocalPage extends StatefulWidget {
  @override
  _UserLocalPageState createState() => _UserLocalPageState();
}

class _UserLocalPageState extends State<UserLocalPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final userNotifier = Provider.of<UserListApi>(context, listen: false);
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Center(
          child: FutureBuilder(
              future: userNotifier.getUsersLocally(context),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.connectionState == ConnectionState.none) {
                  return Center(child: Text('Error!!! Please try again'));
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error!!! Please try again'));
                }
                if (snapshot.data == null) {
                  return Center(
                    child: Text(
                      'Error!!! Please check your internet connection and try again',
                      textAlign: TextAlign.center,
                    ),
                  );
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  userNotifier.showToast(context,
                      'Please check your internet connection and try again!!!');
                  return ListView.separated(
                      physics: BouncingScrollPhysics(),
                      separatorBuilder: (BuildContext context, int index) =>
                          Divider(),
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          onTap: () {
                            userNotifier.showToast(context,
                                'Please check your internet connection and try again!!!');
                          },
                          leading: CircularProgressIndicator(),
                          title: Row(
                            children: [
                              Text(snapshot.data[index]['title']),
                              SizedBox(width: 6),
                              Text(snapshot.data[index]['firstName']),
                              SizedBox(width: 6),
                              Text(snapshot.data[index]['lastName'])
                            ],
                          ),
                          subtitle: Text(snapshot.data[index]['email']),
                        );
                      });
                }
                return Container();
              }),
        ),
      ),
    );
  }
}
