import 'package:flutter/material.dart';
import 'package:flutter_project1/Widgets/ProductCard.dart';


class ButtonAdd extends StatefulWidget {
  const ButtonAdd({super.key});

  @override
  State<ButtonAdd> createState() => _ButtonAddState();
}

class _ButtonAddState extends State<ButtonAdd> {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      height: 45,
      color: Colors.teal.shade50,
      child: Center(
        child: Icon(Icons.add, color: Colors.greenAccent,),
      ),
    );
  }
}
class ButtonsAndField extends StatefulWidget {
  const ButtonsAndField({super.key});

  @override
  State<ButtonsAndField> createState() => _ButtonsAndFieldState();
}

class _ButtonsAndFieldState extends State<ButtonsAndField> {

  static int _count=0;
  TextEditingController _controller=new TextEditingController();

  @override
  Widget build(BuildContext context) {
    _controller.text=_count.toString();
    return Container(
        width: 160,
        height: 45,
        color: Colors.transparent,
        child: Row(
          children: [
            InkWell(
              child: Container(
                width: 30,
                height: 45,
                color: Colors.greenAccent,
                child: Center(
                  child: Icon(Icons.add, color: Colors.white,),
                )
              ),
              onTap: (){
                _count++;
                setState(() {});
              },
            ),
            SizedBox(width: 100, height: 45, child: TextField( controller: _controller, onChanged: (value) {
              if(value.isNotEmpty){//Учесть возможность ввода букв!!!!
                _count=int.parse(value);
              }
            },)),
            InkWell(
              child: Container(
                width: 30,
                height: 45,
                color: Colors.greenAccent,
                child: Center(
                  child: Icon(Icons.remove, color: Colors.white,),
                )
              ),
              onTap: (){
                if(_count>0){
                  _count--;
                }
              },
            ),
          ],
        ),
    );
  }
}