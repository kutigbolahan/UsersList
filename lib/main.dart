import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:usersList/View/Homepage.dart';
import 'package:usersList/viewModel/Network.dart';
import 'package:usersList/viewModel/userList.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HttpService()),
        ChangeNotifierProvider(create: (context) => UserListApi()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomePage(),
      ),
    );
  }
}
