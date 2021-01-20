import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class HttpService with ChangeNotifier {
  final String baseURL = 'https://dummyapi.io/data/api/';

  getData(apiUrl) async {
    var fullUrl = baseURL + apiUrl;
    return await http.get(fullUrl, headers: setHeaders());
  }

  setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'app-id': '6005c04cde65c641e80cbd07'
      };
}
