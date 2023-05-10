
import 'package:flutter/material.dart';
import 'package:flutter_project1/Pages/ProductsPage.dart';
import 'package:flutter_project1/Pages/PromotionsPage.dart';
import 'package:flutter_project1/Pages/ShoppingListPage.dart';

class Bones extends StatefulWidget {
  const Bones({super.key});

  @override
  State<Bones> createState() => _BonesState();
}

class _BonesState extends State<Bones> {
  int _selectedIndex=1;
  static const List<Widget> _pages = [
    ShoppingListPage(),
    ProductsPage(),
    PromotionsPage(),
  ]; 

  void onSelectedTab(int index){
    if(_selectedIndex==index) return;
    // _selectedIndex=index;
    // Navigator.push(
    //     context,
    //     MaterialPageRoute(builder: (context){
    //       return _pages[_selectedIndex];
    //     })
    //   );
    setState(() {
       _selectedIndex=index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.greenAccent,
        selectedFontSize: 16,
        selectedIconTheme: IconThemeData(size: 40),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_add),
            label: 'Список',
          ),
           BottomNavigationBarItem(
            icon: Icon(Icons.auto_awesome_mosaic),
            label: 'Товары',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.style),
            label: 'Акции',
          )
        ],
        onTap: onSelectedTab,
      ),
    );
  }
}
//Страница товаров + подумать над всеми страницами