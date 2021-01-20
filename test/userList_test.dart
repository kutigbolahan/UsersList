import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:usersList/model/user_DetailModel.dart';
import 'package:usersList/model/user_listModel.dart';

//unit test using mockito

UserList _userList;
UserDetails _userDetails;

Future getUsersList(http.Client client) async {
  final response =
      await client.get('https://dummyapi.io/data/api/user?limit=100', headers: {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    'app-id': '6005c04cde65c641e80cbd07'
  });

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    _userList = UserList.fromJson(data);

    return _userList;
  } else if (response.statusCode != 200 ||
      response.statusCode > 200 ||
      response.statusCode == 404) {
    throw Exception('Failed to load usersList');
  }
}

Future getUsersDetails(http.Client client) async {
  final response = await client
      .get('https://dummyapi.io/data/api/user/3JAf8R85oIlxXd58Piqk', headers: {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    'app-id': '6005c04cde65c641e80cbd07'
  });

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    _userDetails = UserDetails.fromJson(data);
    return _userDetails;
  } else if (response.statusCode != 200 ||
      response.statusCode > 200 ||
      response.statusCode == 404) {
    throw Exception('Failed to load usersDetails');
  }
}

class MockClient extends Mock implements http.Client {}

void main() {
  test('returns a list of if the http call completes successfully', () async {
    final client = MockClient();
    when(client.get('https://dummyapi.io/data/api/user?limit=100', headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'app-id': '6005c04cde65c641e80cbd07'
    })).thenAnswer((_) async => http.Response('{"firstName": "Sandro"}', 200));

    expect(await getUsersList(client), isA<UserList>());
  });

  test('returns a user details of if the http call completes successfully',
      () async {
    final client = MockClient();
    when(client.get('https://dummyapi.io/data/api/user/3JAf8R85oIlxXd58Piqk',
            headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'app-id': '6005c04cde65c641e80cbd07'
        }))
        .thenAnswer((_) async => http.Response('{"firstName": "Joey"}', 200));

    expect(await getUsersDetails(client), isA<UserDetails>());
  });
}
