import 'package:articlelistapp/viewmodels/article_viewmodel.dart';
import 'package:flutter/material.dart';

class ArticleListScreen extends StatefulWidget {
  final ArticleViewmodel articleViewmodel;

  const ArticleListScreen(
    {super.key, 
      required this.articleViewmodel
    }
  );

  @override
  State<ArticleListScreen> createState() => _ArticleListScreenState();
}

class _ArticleListScreenState extends State<ArticleListScreen>{
  @override
  void initState(){
    super.initState();
    widget.articleViewmodel.addListener(_onViewModelChanged);
    widget.articleViewmodel.loadArticles();
  }

  @override
  void dispose(){
    widget.articleViewmodel.removeListener(_onViewModelChanged);
    super.dispose();
  }

  void _onViewModelChanged(){
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context){
    final vm = widget.articleViewmodel;

    return Scaffold(
      appBar: AppBar(title: Text('NYT Articles')),
      body: vm.isLoading
          ? Center(child: Text('Error: ${vm.error}'))
          : ListView.builder(
              itemCount: vm.articles.length,
              itemBuilder: (_, index){
                final article = vm.articles[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6),
                  child: GestureDetector(
                    onTap: () => print(article.url),
                    child: Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      elevation: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (article.imageUrl != null)
                            ClipRRect(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                              child: Image.network(
                                article.imageUrl!,
                                height: 160,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => Container(
                                  height: 160,
                                  color: Colors.grey.shade200,
                                  child: Center(child: Icon(Icons.broken_image, size: 40, color: Colors.grey)),
                                ),
                              ),
                            )
                          else
                            Container(
                              height: 160,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                              ),
                              child: Center(child: Icon(Icons.image_not_supported, color: Colors.grey, size: 40)),
                            ),

                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  article.title,
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 8),
                                Text(
                                  article.summary,
                                  style: TextStyle(color: Colors.grey.shade700, fontSize: 14),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );

              }
          )
    );
  }

}