import 'package:flutter/material.dart';
import 'package:flutter_project1/Widgets/ProductCard.dart';
import 'package:provider/provider.dart';

import '../Classes/ListContent.dart';
import '../Classes/ProductCount.dart';

class Buttons extends StatefulWidget {
  const Buttons({super.key});

  @override
  State<Buttons> createState() => _ButtonsState();
}

class _ButtonsState extends State<Buttons> {
  Widget _currentButton = ButtonAdd();
  bool _added = false;

  @override
  Widget build(BuildContext context) {
    if (context.watch<AddedCount>().getCount() == 0 && !ListContent.list.containsKey(context.read<AddedCount>().product)) {
      _currentButton = ButtonAdd();
      _added = false;
    } else{
      context.watch<AddedCount>().setCount(ListContent.list[context.read<AddedCount>().product]);
      _currentButton = ButtonsAndField();
    }
    setState(() {});
    return InkWell(
      child: _currentButton,
      onTap: () {
        if (!_added) {
          _currentButton = ButtonsAndField();
          _added = true;
          context.read<AddedCount>().add();
          ListContent.list.addAll(
            {context.read<AddedCount>().product : context.read<AddedCount>().getCount()}
          );
          setState(() {});
        }
      },
    );
  }
}

class ButtonAdd extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      height: 45,
      color: Colors.teal.shade50,
      child: const Center(
        child: Icon(
          Icons.add,
          color: Colors.greenAccent,
        ),
      ),
    );
  }
}

class ButtonsAndField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      height: 45,
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            child: Container(
                width: 45,
                height: 45,
                color: Colors.greenAccent,
                child: const Center(
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                )),
            onTap: () {
              context.read<AddedCount>().add();
              ListContent.changeCount(context.read<AddedCount>().product, context.read<AddedCount>().getCount());
            },
          ),
          Text(
            context.watch<AddedCount>().getCount().toString(),
          ),
          InkWell(
            child: Container(
                width: 45,
                height: 45,
                color: Colors.greenAccent,
                child: Center(
                  child: Icon(
                    Icons.remove,
                    color: Colors.white,
                  ),
                )),
            onTap: () {
              if (context.read<AddedCount>().getCount() > 0) {
                context.read<AddedCount>().subtract();
                ListContent.changeCount(context.read<AddedCount>().product, context.read<AddedCount>().getCount());
              } else{
                ListContent.removeFromList(context.read<AddedCount>().product);
              }
            },
          ),
        ],
      ),
    );
  }
}
