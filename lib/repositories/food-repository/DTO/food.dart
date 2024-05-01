import 'nutrient.dart';

/// A subsystem for reading data about food details passed from the food repository
class Food
{
  final String _id;
  final String _name;
  final List<Nutrient> _nutrients;
  final String _category;
  final String? _thumbnailUrl;

  Food(this._id, this._name, this._nutrients, this._category, this._thumbnailUrl);

  String getId() => _id;
  String getName() => _name;
  String getCategory() => _category;
  List<Nutrient> getNutrients() => _nutrients;
  String? getThumbnail() => _thumbnailUrl;
}
