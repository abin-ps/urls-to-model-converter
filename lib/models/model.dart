class Model {
  final String id;
  final String name;
  final String? description;
  final String imageUrl;

  Model({
    required this.id,
    required this.name,
    this.description,
    required this.imageUrl,
  });
}
