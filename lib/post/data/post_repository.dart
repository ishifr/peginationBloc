import 'dart:convert';
import 'package:http/http.dart' as http;
import 'post_model.dart';

class PostRepository {
  Future<List<PostModel>> fetch({required int page, required int limit}) async {
    final url = Uri.parse(
        "https://jsonplaceholder.typicode.com/posts?_limit=$limit&_page=$page");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List newItems = json.decode(response.body);
      return newItems.map<PostModel>((e) => PostModel.fromJson(e)).toList();
    }
    else{
      throw Exception(); 
    }
  }
}
