/// A subsystem to read the data from the food repository
/// needed to generate a list of foods.
class FoodListItem
{
  final String _id;
  final String _name;
  final String? _thumbnailUrl;

  FoodListItem(this._id, this._name, this._thumbnailUrl);

  String getId() => _id;
  String getName() => _name;
  String? getThumbnail() => _thumbnailUrl;
}
