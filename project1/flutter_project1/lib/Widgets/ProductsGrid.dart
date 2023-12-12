import 'package:flutter/material.dart';
import 'package:flutter_project1/Classes/DBConnection.dart';
import 'package:flutter_project1/Pages/ProductsPage.dart';
import 'package:flutter_project1/Widgets/ProductCard.dart';
import '../Classes/firebase_streem.dart';
import '../Tables/Price.dart';
import '../Tables/Product.dart';
import '../Tables/Promotion.dart';
import 'MainStructElement.dart';

class ProductsGrid extends StatefulWidget{

  @override
  State<ProductsGrid> createState() => _ProductsGridState();
}

class _ProductsGridState extends State<ProductsGrid> {
  List<Product> productsInDB=<Product>[];

  void createChildren(){
    productsInDB.clear();
    for(Product instance in DBConnection.productsSet.values){
      if(ProductsPage.search.text != null && !instance.title.toLowerCase().contains(ProductsPage.search.text.toLowerCase())){continue;}
      if(ProductsPage.currentCategory != null && instance.category != ProductsPage.currentCategory?.getID()){continue;}
      if(ProductsPage.currentStore != null){
        bool inCurrentStore=false;
        for(Price pr in DBConnection.prices){
          if(instance.getID() == pr.productID && pr.storeUNP == ProductsPage.currentStore?.UNP){
            inCurrentStore=true;
            break;
          }
        }
        if(!inCurrentStore){continue;}
      }
      if(ProductsPage.activePromo){
        bool activePromoGrid=false;
        for(Promotion promo in DBConnection.promotions){
          if(promo.category == instance.category || promo.product == instance.getID()){
            activePromoGrid=true;
            break;
          }
        }
        if(!activePromoGrid){continue;}
      }
      if(ProductsPage.inEveryStore){
        int storesCount=0;
        for(Price pr in DBConnection.prices){
          if(instance.getID() == pr.productID){
            storesCount++;
          }
        }
        if(storesCount<DBConnection.stores.length){continue;}
      }
      if(ProductsPage.favoriteCheck && !FirebaseStream.currentUser.favoriteProducts.contains(instance.getID())){continue;}
      productsInDB.add(
        instance,
      );
    }
    productsInDB.sort((a,b){
      if(FirebaseStream.currentUser.favoriteProducts.contains(a.getID()) && !FirebaseStream.currentUser.favoriteProducts.contains(b.getID())){return -1;}
      else if(FirebaseStream.currentUser.favoriteProducts.contains(b.getID()) && !FirebaseStream.currentUser.favoriteProducts.contains(a.getID())){return 1;}
      else{return 0;}
    });
    productsInDB.reversed;
  }

  Future<void> refresh() async{
    setState((){
      DBConnection.productsSet.clear();
    });
    if(await Bones.init()){
      setState(() {
        
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    createChildren();
    return Expanded(
        child: RefreshIndicator(
        color:  Color(0xFF4EC88C),
        onRefresh: refresh,
        child: DBConnection.productsSet.isEmpty
        ? Center(child: CircularProgressIndicator(color: Color(0xFF4EC88C),),)
        :
        GridView.builder(
          primary: true,
          physics: ScrollPhysics(),
          scrollDirection: Axis.vertical,
          shrinkWrap: true, 
          padding: const EdgeInsets.all(20),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio:1,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10
          ),
          itemCount: productsInDB.length,
          itemBuilder: (BuildContext ctx, index) {
            return ProductCard(currentProduct: productsInDB[index]);
          },
        ),
      ),
    );
  }
}
