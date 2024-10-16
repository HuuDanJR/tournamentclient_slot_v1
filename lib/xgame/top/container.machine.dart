import 'package:flutter/material.dart';
import 'package:tournament_client/utils/mystring.dart';
import 'package:tournament_client/xgame/top/page.machine.parent.dart';

class MachineViewContainer extends StatelessWidget {
  const MachineViewContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final heightView = height * .545;
    final heightRank = height * .455;
    final widthItem = width * .5;
    const paddingHorizontal = MyString.padding16;
    const paddingHorizontalDouble = MyString.padding16 * 2;
    const paddingHorizontalHalf = MyString.padding12;
    const paddingVertical = MyString.padding08;

    final double widthGridV = width / 3;
    final double heightGridV = height / 3;

    final double widthGridVCenter = width / 2.935;
    final double heightGridVCenter = height / 2.935;
   const Color color = Color(0xFF0288D1);

    return Scaffold(
      backgroundColor: Colors.black, // Set the background to black
      body: Container(
        width: width,
        height: height,
        color:color,
        // decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('asset/bgcolor2.png'), fit: BoxFit.cover)),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child:  SizedBox(
                  // color: MyColor.black_absolute,
                  width: width,
                  height: height,
                  child: 
                  const MachineTopPage()),
            ),
      
            // //background layer
            // Container(
            //       color: MyColor.white.withOpacity(.25),
            //       width: width,
            //       height: height,
            //    ),
          ],
        ),
      ),
    );
  }
}
