import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project1/Classes/ListCalculator.dart';
import 'package:flutter_project1/Classes/DBConnection.dart';
import 'package:flutter_project1/Classes/ListContent.dart';
import 'package:flutter_project1/Classes/OuterActions.dart';
import 'package:flutter_project1/Tables/ChainStore.dart';
import 'package:flutter_project1/Widgets/DropDownStoreList.dart';
import 'package:flutter_project1/Widgets/ShoppingListView.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Classes/firebase_streem.dart';

class ShoppingListPage extends StatefulWidget {
  static ChainStore? currentStore;
  ShoppingListPage({super.key});

  @override
  State<ShoppingListPage> createState() => _ShoppingListPageState();
}

class _ShoppingListPageState extends State<ShoppingListPage> {
  void refresh() {
    setState(() {});
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();

    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
      return const FirebaseStream();
    }), (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    String text = '';
    String text2 = '';
    List<Map> offers = ListCalculator.bestOffer();
    if (ShoppingListPage.currentStore == null) {
      String? checker1 = offers.firstOrNull?['totalCost'].toStringAsFixed(2);
      String? checker2 = offers.firstOrNull?['currentStore'].title;
      if (checker1 != null && checker2 != null) {
        text += 'Лучшее предложение в' + ' ' + checker2;
        text2 = '' + checker1+'руб.';
      } else {
        text += '';
        text2 = '';
      }
    } else {
      ListCalculator.calc(ShoppingListPage.currentStore!);
      text+=ListCalculator.totalCost.toStringAsFixed(2)+'руб.';
    }
    return SafeArea(
      child: Scaffold(
        body: Center(
            child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.all(8),
                  child: IconButton(
                      onPressed: signOut, icon: Icon(Icons.output_rounded)),
                )
              ],
            ),
            DropDownStoreList(func: refresh),
            Padding(padding: EdgeInsets.all(8)),
            ShoppingListView(
              func: refresh,
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Container(
                color: const Color(0xFF19280D),
                height: 1,
              ),
            ),
            Text(text,
                style: GoogleFonts.comfortaa(
                    color: const Color(0xFF19280D),
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w400,
                    fontSize: 18)),
            Center(
              child: Text(text2,
                  style: GoogleFonts.comfortaa(
                      color: const Color(0xFF19280D),
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
                      fontSize: 20)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start  ,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextButton(
                        onPressed: () {
                          if(ListContent.list.isNotEmpty){
                            OuterActions.shareList(context);
                          }
                        },
                        child: Text('Поделиться списком',
                        style: GoogleFonts.comfortaa(
                              color: Color(0xFF4EC88C),
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.bold,
                              fontSize: 14)
                        )),
                    TextButton(
                        onPressed: () async{
                          final code = TextEditingController();
                          await showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('Ваш код'),
                              content: TextField(
                                controller: code,
                              ),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: (){
                                    Navigator.pop(context, 'OK');
                                    DBConnection.getList(code.text, refresh);
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          );
                          refresh();
                          setState(() {});
                        },
                      child: Text('Ввести код списка',
                      style: GoogleFonts.comfortaa(
                              color: Color(0xFF4EC88C),
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.bold,
                              fontSize: 14)),
                      ),
                  ],
                ),
              ],
            ),
          ],
        )),
      ),
    );
  }
}