class Recipe {
  final int id;
  final String name;
  final String pictureUrl;
  final String description;

  Recipe({
    required this.id,
    required this.name,
    required this.pictureUrl,
    required this.description,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'],
      name: json['name'],
      pictureUrl: json['picture'],
      description: json['description'],
    );
  }
}
