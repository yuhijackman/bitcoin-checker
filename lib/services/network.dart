import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  String url;

  NetworkHelper({this.url});

  Future getData () async {
    http.Response res = await http.get(url);
    print(url);
    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    } else {
      print(res.statusCode);
      throw 'Problem with the get request';
    }
  }
}