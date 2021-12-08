import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' show Client;
import '../models/item_model.dart';

class MovieApiProvider {
  Client client = Client();
  final _apiKey = '875e318bab500e8f9eb266d74ffe211f';

  Future<ItemModel> fetchMovieList() async {
    print("entered");
    final response = await client.get(Uri.parse(
        'http://api.themoviedb.org/3/movie/popular?api_key=$_apiKey'));
    print(response.body.toString());
    if (response.statusCode == 200) {
      return ItemModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }
}
