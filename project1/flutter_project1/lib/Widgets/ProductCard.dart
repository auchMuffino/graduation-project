import 'package:flutter/material.dart';

import 'Buttons.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({super.key});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  int count=0;
  bool _itemAdded=false;
  // Widget currentButton=Container(width: 80, height: 30, color: Colors.blueAccent,);
  Widget currentButton=ButtonAdd();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      width: 100,
      height: 100,
      padding: EdgeInsets.all(10),
      child: Column(children: [
          Image.network("https://s13.stc.yc.kpcdn.net/share/i/instagram/B44solahwlo/wr-1280.webp", height: 40,),
          Text("Котэк"),
          InkWell(
            child: currentButton,
            onTap: () { 
                if(_itemAdded){
                  if(count==0){
                    
                  }//!!!!
                  setState(() {
                    currentButton=ButtonAdd();
                    // currentButton=Container(width: 175, height: 50, color: Colors.blueAccent,);
                  });
                  //Если количество добавленных товаров == 0, то мы меняем кнопку на первоначальную
                }
                else{
                  _itemAdded=true;
                  setState(() {
                    currentButton=ButtonsAndField();
                    //  currentButton=Container(width: 175, height: 50, color: Colors.greenAccent,);
                  });
                }
            },
        ),
      ]),
    );
  }
} 