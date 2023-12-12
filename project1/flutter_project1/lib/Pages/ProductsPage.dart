import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project1/Widgets/ActivePromoCheck.dart';
import 'package:flutter_project1/Widgets/DropDownCategoryChoice.dart';
import 'package:flutter_project1/Widgets/inEveryStoreCheck.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Tables/Category.dart';
import '../Tables/ChainStore.dart';
import '../Widgets/DropDownProductStores.dart';
import '../Widgets/ProductsGrid.dart';

class ProductsPage extends StatefulWidget {
  ProductsPage({super.key});
  static TextEditingController search = TextEditingController();
  static Category? currentCategory = null;
  static ChainStore? currentStore = null;
  static bool activePromo = false;
  static bool inEveryStore = false;
  static bool favoriteCheck = false;

  @override
  State<ProductsPage> createState() => ProductsPageState();
}

class ProductsPageState extends State<ProductsPage> {
  @override
  void initState() {
    super.initState();
  }

  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Поиск'
              ),
              controller: ProductsPage.search,
              onSubmitted: (value) {
                ProductsPage.search.text = value;
                setState(() {});
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              DropdownCategory(func: refresh),
              DropDownProductStore(func: refresh),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  ActivePromoCheck(func: refresh),
                  const Padding(padding: EdgeInsets.only(right: 1)),
                  Text('Акционный',
                      style: GoogleFonts.comfortaa(
                          color: const Color(0xFF19280D),
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.bold,
                          fontSize: 15)),
                ],
              ),
              Row(
                children: [
                  InEveryStore(func: refresh),
                  const Padding(padding: EdgeInsets.only(right: 1)),
                  Text('Есть везде',
                      style: GoogleFonts.comfortaa(
                          color: const Color(0xFF19280D),
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.bold,
                          fontSize: 15)),
                ],
              ),
            ],
          ),
          ProductsGrid(),
        ],
      ),
    ));
  }
}
