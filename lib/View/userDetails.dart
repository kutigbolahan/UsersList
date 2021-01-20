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
                  return Center(child: Text('Error!!! Plesea try again'));
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error!!! Plesea try again'));
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
                            border:
                                Border.all(color: Color(0xff01A0C7), width: 6),
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
                        Text(snapshot.data.email),
                        SizedBox(height: 5),
                        Text(snapshot.data.phone),
                        Container(
                          height: 200,
                          child: GridView.count(
                            crossAxisCount: 2,
                            children: <Widget>[
                              FlutterLogo(),
                              FlutterLogo(),
                              FlutterLogo(),
                              FlutterLogo(),
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
