
class Products with Provider{
  late String _code;
  late String _title;
  late String _manufacturer;
  late String _description;
  late String _countryOfOrigin;

  static int allProductsCount=0;

  Products(code,title,manufacturer, description, countryOfOrigin){
    this._code=code;
    this._title=title;
    this._manufacturer=manufacturer;
    this._description=description;
    this._countryOfOrigin=countryOfOrigin;

    allProductsCount++;
  }

  get getTitle => _title;
  get getManufacturer => _manufacturer;
  get getDescription => _description;
  get getCountryOfOrigin => _countryOfOrigin;
}