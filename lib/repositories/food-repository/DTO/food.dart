/// A subsystem for reading data about food details passed from the food repository
class Food
{
  final String id;
  final String name;
  final Map<String, double> nutrients;
  final String category;
  final String thumbnailUrl;

  Food({
    required this.id,
    required this.name,
    required this.nutrients,
    required this.category,
    required this.thumbnailUrl,
  });
}
