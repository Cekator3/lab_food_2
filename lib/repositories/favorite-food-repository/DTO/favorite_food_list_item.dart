/// A subsystem to read the data from the favorite food repository
/// needed to generate a list of user's favorite foods.
class FavoriteFoodListItem
{
  final String _id;
  final String _name;
  final String? _thumbnailUrl;

  FavoriteFoodListItem(this._id, this._name, this._thumbnailUrl);

  String getId() => _id;
  String getName() => _name;
  String? getThumbnail() => _thumbnailUrl;
}
