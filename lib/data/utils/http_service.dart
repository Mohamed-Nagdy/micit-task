import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

class HttpService {
  Future<Map<String, dynamic>?> get(String url) async {
    final http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return null;
    }
  }
}

final HttpService httpService = HttpService();
