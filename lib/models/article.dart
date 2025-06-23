
class Article {
  final String title;
  final String summary;
  final String url;
  final String? imageUrl;

  Article({
    required this.title,
    required this.summary,
    required this.url,
    this.imageUrl
    }
  );

  factory Article.fromJson(Map<String, dynamic> json){
    String? thumbUrl;

    if (json['multimedia'] != null && json['multimedia'] is List) {
      final mediaList = json['multimedia'] as List;
      final thumb = mediaList.firstWhere(
        (item) => item['format'] == 'threeByTwoSmallAt2X',
        orElse: () => null,
      );
      if (thumb != null && thumb['url'] != null) {
        thumbUrl = thumb['url'];
      }
    }

    return Article(
      title: json['title'] ?? '', 
      summary: json['abstract'] ?? '', 
      url: json['url'] ?? '',
      imageUrl: thumbUrl
      );
  }
}