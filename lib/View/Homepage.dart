import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:usersList/View/userDetails.dart';
import 'package:usersList/viewModel/userList.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Box<String> feedsBox = Hive.box('userList');
  @override
  Widget build(BuildContext context) {
    final userNotifier = Provider.of<UserListApi>(context, listen: false);
    // var userId;

    return Scaffold(
      appBar: AppBar(
        title: Text('UsersList'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: FutureBuilder(
              future: userNotifier.getUsersList(context),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.connectionState == ConnectionState.none) {
                  return Center(child: Text('Error!!! Plesea try again'));
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error!!! Plesea try again'));
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  return ListView.separated(
                      separatorBuilder: (BuildContext context, int index) =>
                          Divider(),
                      itemCount: snapshot.data.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                            onTap: () {
                              // setState(() {
                              //   userId = snapshot.data.data[index].id;
                              //   print(userId);
                              // });
                              final userId = snapshot.data.data[index].id;
                              feedsBox.put('USERID', userId);
                              Platform.isAndroid
                                  ? Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => UserDetails()),
                                    )
                                  : Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                          builder: (context) => UserDetails()),
                                    );
                            },
                            leading: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 20,
                                backgroundImage: NetworkImage(
                                    snapshot.data.data[index].picture)),
                            title: Row(
                              children: [
                                Text(snapshot.data.data[index].firstName),
                                SizedBox(width: 10),
                                Text(snapshot.data.data[index].lastName)
                              ],
                            ));
                      });
                }
                return Container();
              }),
        ),
      ),
    );
  }
}
