import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' show Client;
import '../models/item_model.dart';

class MovieApiProvider {
  Client client = Client();
  Client client2 = Client();
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

  Future<String> filmDescription() async {
    final response = await client.get(Uri.parse(
        "https://en.wikipedia.org/w/api.php?format=json&action=query&prop=extracts&exlimit=max&explaintext&exintro&titles=film"));
    if (response.statusCode == 200) {
      return jsonDecode(response.body)["query"]["pages"]["21555729"]["extract"];
    } else {
      throw Exception('Failed to load post');
    }
  }
}
