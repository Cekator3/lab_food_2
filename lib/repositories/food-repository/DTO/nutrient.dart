/// A subsystem for reading data about food's details about it's nutrients
/// passed from the food repository
class Nutrient
{
  final double _energy;
  final double _protein;
  final double _fat;
  final double _carbohydrate;

  Nutrient(this._energy, this._protein, this._fat, this._carbohydrate);

  double getEnergyInKcal() => _energy;
  double getProteinInGram() => _protein;
  double getFatInGram() => _fat;
  double getCarbohydrateInGram() => _carbohydrate;
}
