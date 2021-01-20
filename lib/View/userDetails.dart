import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:usersList/viewModel/userList.dart';

class UserDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userDetails = Provider.of<UserListApi>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('UserDetails'),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Center(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: FutureBuilder(
              future: userDetails.getUserDetails(context),
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
                if (snapshot.connectionState == ConnectionState.done) {
                  return Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(200),
                            border: Border.all(color: Colors.blue, width: 6),
                          ),
                          child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 70,
                              backgroundImage:
                                  NetworkImage(snapshot.data.picture)),
                        ),
                        SizedBox(height: 7),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(snapshot.data.title),
                            SizedBox(width: 5),
                            Text(snapshot.data.firstName),
                            SizedBox(width: 5),
                            Text(snapshot.data.lastName),
                          ],
                        ),
                        SizedBox(height: 5),
                        RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6)),
                          color: Colors.blue,
                          textColor: Colors.white,
                          onPressed: () {},
                          child: Text('Send Email'),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 70,
                              height: 70,
                              child: Card(
                                color: Colors.white,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      CupertinoIcons.phone,
                                      color: Colors.black26,
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Text('Call')
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: 70,
                              height: 70,
                              child: Card(
                                color: Colors.white,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      CupertinoIcons.video_camera,
                                      color: Colors.black26,
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Text('Video')
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: 70,
                              height: 70,
                              child: Card(
                                color: Colors.white,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      CupertinoIcons.chat_bubble,
                                      color: Colors.black26,
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Text('Chat')
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: 70,
                              height: 70,
                              child: Card(
                                color: Colors.white,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      CupertinoIcons.mail,
                                      color: Colors.black26,
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Text('Mail')
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: GridView.count(
                            crossAxisCount: 2,
                            children: <Widget>[
                              Card(
                                color: Colors.green,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      CupertinoIcons.house,
                                      color: Colors.white,
                                    ),
                                    SizedBox(height: 6),
                                    Text(
                                      snapshot.data.location.street,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                              Card(
                                color: Colors.red,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      CupertinoIcons.phone_arrow_up_right,
                                      color: Colors.white,
                                    ),
                                    SizedBox(height: 6),
                                    Text(
                                      snapshot.data.phone,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                              Card(
                                color: Colors.black,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      CupertinoIcons.mail_solid,
                                      color: Colors.white,
                                    ),
                                    SizedBox(height: 6),
                                    Text(
                                      snapshot.data.email,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                              Card(
                                color: Colors.orange,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      CupertinoIcons.person,
                                      color: Colors.white,
                                    ),
                                    SizedBox(height: 6),
                                    Text(
                                      snapshot.data.gender,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                }
                return Container();
              }),
        ),
      )),
    );
  }
}
