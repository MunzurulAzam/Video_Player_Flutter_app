import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:qtecsolutiontask/model/play_list.dart';

class ApiServices {

  Future<PlayList> fetchTrendingVideos(int page) async {
    final String baseUrl = 'https://test-ximit.mahfil.net/api/';
    final String endpoint = 'trending-video/1?page=$page';

    final response = await http.get(Uri.parse('$baseUrl$endpoint'));

    print('.......................................................................................... API being hit: $baseUrl$endpoint'); //........... Print API being hit

    if (response.statusCode == 200) {
      print('........................................................................................ Status Code: ${response.statusCode}'); //............. Print Status Code
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      return PlayList.fromJson(jsonResponse);
    } else {
      print('Failed to load data. Status Code: ${response.statusCode}'); //................................... Print Failed Status Code
      throw Exception('Failed to load data');
    }
  }


}
