class GifData {
  final String id;
  final String url;

  GifData({required this.id, required this.url});

  factory GifData.fromJson(Map<String, dynamic> json) {
    return GifData(id: json['id'], url: json['images']['original']['url']);
  }
}
