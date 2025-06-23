import 'dart:convert';

import 'package:articlelistapp/models/article.dart';
import 'package:http/http.dart' as http;

class ArticleService {
  final String apiKey;

  ArticleService(this.apiKey);

  Future<List<Article>> fetchTopStories() async{
    final url = Uri.parse('https://api.nytimes.com/svc/topstories/v2/home.json?api-key=$apiKey');

    final response = await http.get(url);

    if(response.statusCode == 200){
      final decoded = utf8.decode(response.bodyBytes);
      final data = jsonDecode(decoded); 
      final List results = data['results'];
      return results.map((json)=> Article.fromJson(json)).toList();
    }
    else{
      throw Exception('Failes to load articles');
    }
  }
}