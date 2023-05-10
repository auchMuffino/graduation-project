class Category{
  late int _categoryID;
  late String categoryTitle;

  Category({required this.categoryTitle});

  void setID(int ID){
    this._categoryID=ID;
  }
  int getCategoryID(){
    return _categoryID;
  }
}