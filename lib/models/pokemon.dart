class Pokemon {
  final int id;
  final String name;
  final String imageUrl;
  final List<Map<String, dynamic>> stats;
  final List<String> types;

  Pokemon({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.stats,
    required this.types,
  });
}
