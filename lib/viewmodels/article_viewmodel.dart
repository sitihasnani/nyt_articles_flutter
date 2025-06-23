import 'package:articlelistapp/models/article.dart';
import 'package:articlelistapp/services/article_service.dart';
import 'package:flutter/material.dart';

class ArticleViewmodel extends ChangeNotifier {
  final ArticleService service;

  List<Article> articles = [];
  bool isLoading = true;
  String? error;

  ArticleViewmodel(this.service);

  Future<void> loadArticles() async{
    isLoading = true;
    notifyListeners();

    try{
      articles = await service.fetchTopStories();
      error = null;
    } catch(e){
      error = e.toString();
    }

    isLoading = false;
    notifyListeners();
  }

}