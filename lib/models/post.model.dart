final class PostModel {
  final String title;
  final String description;

  const PostModel({required this.title, required this.description});

  factory PostModel.fromJson(Map<String, dynamic> jsonData) {
    return PostModel(
        title: jsonData['title'], description: jsonData['description']);
  }

  PostModel copyWith({String? title, String? description}) {
    return PostModel(
        title: title ?? this.title,
        description: description ?? this.description);
  }
}
