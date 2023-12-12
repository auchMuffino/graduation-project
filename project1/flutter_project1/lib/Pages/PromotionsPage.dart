import 'package:flutter/material.dart';
import 'package:flutter_project1/Widgets/PromotionsGrid.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Tables/ChainStore.dart';
import '../Widgets/DropDownStore.dart';

class PromotionsPage extends StatefulWidget {
  const PromotionsPage({super.key});
  static ChainStore? currentStore = null;
  static DateTime? currentDate = null;

  @override
  State<PromotionsPage> createState() => _PromotionsPageState();
}

class _PromotionsPageState extends State<PromotionsPage> {
  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2022),
                            lastDate: DateTime(2122))
                        .then((value) {
                      PromotionsPage.currentDate = value;
                      setState(() {});
                    });
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(70, 30),
                      backgroundColor: Color(0xFF19280D),
                      elevation: 0,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)))),
                  child: Text('Выбрать дату',
                      style: GoogleFonts.comfortaa(
                          shadows: [
                            BoxShadow(
                              color: Colors.black.withOpacity(.15),
                              spreadRadius: 4,
                              blurRadius: 3,
                              offset: Offset(0, 3),
                            )
                          ],
                          color: Colors.white,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.bold,
                          fontSize: 14)),
                ),
                DropDownStore(
                  func: refresh,
                ),
              ],
            ),
            PromotionsGrid(),
          ],
        ),
      ),
    );
  }
}
