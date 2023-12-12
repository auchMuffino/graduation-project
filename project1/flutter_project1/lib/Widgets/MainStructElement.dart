import 'package:flutter/material.dart';
import 'package:flutter_project1/Pages/ProductsPage.dart';
import 'package:flutter_project1/Pages/PromotionsPage.dart';
import 'package:flutter_project1/Pages/ShoppingListPage.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../Classes/DBConnection.dart';


class Bones extends StatefulWidget {
  const Bones({super.key});
  static Future<bool> init()async{
  bool c=await
  DBConnection.getProducts();
  bool d=await
  DBConnection.getPromotions(); 
  bool e=await
  DBConnection.getPrices();
  if(c && d && e){
    return true;
  } else{
    return false;
  }
}
  @override
  State<Bones> createState() => _BonesState();
}

class _BonesState extends State<Bones> {
  int _selectedIndex=0;
  static List<Widget> _pages = [
    ShoppingListPage(),
    ProductsPage(),
    PromotionsPage(),
  ]; 

  void onSelectedTab(int index){
    setState(() {
       _selectedIndex=index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(
              color:  Color(0xFF19280D),
              borderRadius: BorderRadius.all(
                Radius.circular(15)
               ),
            ),
              child: GNav(
                curve: Curves.easeIn,
                tabBorderRadius: 10,
                selectedIndex: _selectedIndex,
                backgroundColor: const Color(0xFF19280D),
                color: Colors.white, 
                activeColor: Colors.white,
                tabBackgroundColor:const Color(0x994EC88C),
                gap: 8,
                padding: const EdgeInsets.all (16),
                tabs: const [
                  GButton(
                    icon: Icons.assignment,
                    text: 'Список',
                  ),
                  GButton(
                    icon: Icons.window_rounded,
                    text: 'Товар',
                  ),
                  GButton(
                    icon: Icons.loyalty,
                    text: 'Акции',
                  ),
                ],
                onTabChange: onSelectedTab,
              ),
            ),
      ),
    );
  }
}
