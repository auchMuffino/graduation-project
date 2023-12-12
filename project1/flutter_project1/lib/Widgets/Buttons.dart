import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Classes/ListContent.dart';
import '../Tables/Product.dart';

class Buttons extends StatefulWidget {
  Product currentProduct;
  double width;
  double height;
  Buttons({super.key, required this.currentProduct, required this.height, required this.width});

  @override
  State<Buttons> createState() => _ButtonsState();
}

class _ButtonsState extends State<Buttons> {
  Widget _currentButton = ButtonAdd(height: 30, width: 100,);
  bool _added = false;
  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (!ListContent.list.containsKey(widget.currentProduct)) {
      _currentButton = ButtonAdd(height: widget.height, width: widget.width,);
      _added = false;
    } else {
      _added = true;
      _currentButton = ButtonsAndField(
          notifyParent: refresh, currentProduct: widget.currentProduct, height: widget.height,width: widget.width,);
    }
    setState(() {});
    return InkWell(
      child: _currentButton,
      onTap: () {
        if (!_added) {
          _currentButton = ButtonsAndField(
              notifyParent: refresh, currentProduct: widget.currentProduct,  height: widget.height,width: widget.width);
          _added = true;
          ListContent.list.addAll({widget.currentProduct: 1});
          setState(() {});
        }
      },
    );
  }
}

class ButtonAdd extends StatelessWidget {
  double width;
  double height;
  ButtonAdd({required this.height, required this.width});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        color: Color(0xFF19280D),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.15),
            spreadRadius: 4,
            blurRadius: 7,
            offset: Offset(0, 3),
          )
        ],
      ),
      child: Center(
          child: Text(
        'добавить',
        style: GoogleFonts.comfortaa(
            color: Colors.white,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.bold,
            fontSize: (height/2)-1),
      )),
    );
  }
}

class ButtonsAndField extends StatefulWidget {
  final Function() notifyParent;
  Product currentProduct;
  double width;
  double height;
  ButtonsAndField(
      {super.key, required this.notifyParent, required this.currentProduct, required this.height, required this.width});

  @override
  State<ButtonsAndField> createState() => _ButtonsAndFieldState();
}

class _ButtonsAndFieldState extends State<ButtonsAndField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  color: Color(0xFF19280D),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.15),
                      spreadRadius: 4,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    )
                  ],
                ),
                width: widget.height,
                height: widget.height,
                child: const Center(
                    child: Icon(Icons.remove,color: Colors.white,size: 20,))),
            onTap: () {
              if (ListContent.list[widget.currentProduct]! > 1) {
                ListContent.subtract(widget.currentProduct);
                widget.notifyParent();
              } else {
                ListContent.removeFromList(widget.currentProduct,widget.notifyParent);
                widget.notifyParent();
              }
            },
          ),
          Text(
            ListContent.list[widget.currentProduct].toString(),
          ),
          InkWell(
            child: Container(
                width: widget.height,
                height: widget.height,
                decoration: BoxDecoration(
                  borderRadius:const BorderRadius.all(Radius.circular(5)),
                  color: const Color(0xFF19280D),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.15),
                      spreadRadius: 4,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    )
                  ],
                ),
                child: const Center(
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 20,
                  ),
                )),
            onTap: () {
              ListContent.add(widget.currentProduct);
              setState(() {
              });
            },
          ),
        ],
      ),
    );
  }
}
