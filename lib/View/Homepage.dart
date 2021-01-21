import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:usersList/View/userDetails.dart';
import 'package:usersList/View/userLocalPage.dart';
import 'package:usersList/viewModel/userList.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Box feedsBox = Hive.box('userList');
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final userNotifier = Provider.of<UserListApi>(context, listen: false);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                Platform.isIOS
                    ? Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => HomePage()),
                        (Route<dynamic> route) => false)
                    : Navigator.of(context).pushAndRemoveUntil(
                        CupertinoPageRoute(builder: (context) => HomePage()),
                        (Route<dynamic> route) => false);
              })
        ],
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
                  return Center(child: Text('Error!!! Please try again'));
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error!!! Please try again'));
                }
                if (snapshot.data == null) {
                  return
                      //showToast(context, 'Please check internet connection');

                      UserLocalPage();
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  return ListView.separated(
                      physics: BouncingScrollPhysics(),
                      separatorBuilder: (BuildContext context, int index) =>
                          Divider(),
                      itemCount: snapshot.data.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          onTap: () {
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
                          leading: CachedNetworkImage(
                            imageUrl: snapshot.data.data[index].picture,
                            imageBuilder: (context, imageProvider) => Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: imageProvider, fit: BoxFit.contain),
                              ),
                            ),
                            placeholder: (context, url) =>
                                CircularProgressIndicator(
                              strokeWidth: 1.5,
                              backgroundColor: Colors.blue,
                            ),
                            errorWidget: (context, url, error) =>
                                CircularProgressIndicator(
                              strokeWidth: 1.5,
                              backgroundColor: Colors.blue,
                            ),
                          ),

                          // CircleAvatar(
                          //     backgroundColor: Colors.white,
                          //     radius: 30,
                          //     backgroundImage: NetworkImage(
                          //         snapshot.data.data[index].picture)),
                          title: Row(
                            children: [
                              Text(snapshot.data.data[index].title),
                              SizedBox(width: 6),
                              Text(snapshot.data.data[index].firstName),
                              SizedBox(width: 6),
                              Text(snapshot.data.data[index].lastName)
                            ],
                          ),
                          subtitle: Text(snapshot.data.data[index].email),
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
