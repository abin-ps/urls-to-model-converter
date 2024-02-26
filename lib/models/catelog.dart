class Catelog {
  final String id;
  final String categoryId;
  final String name;
  final String? description;
  final String imageUrl;

  Catelog({
    required this.id,
    required this.categoryId,
    required this.name,
    this.description,
    required this.imageUrl,
  });
}
