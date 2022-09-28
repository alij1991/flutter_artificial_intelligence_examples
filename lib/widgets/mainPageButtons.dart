import 'package:flutter/material.dart';
import 'package:gradient_borders/gradient_borders.dart';

class MainPageButtons extends StatelessWidget {
  const MainPageButtons({
    Key? key, required this.txt, required this.ontap, required this.heroTag, required this.pageIcon,
  }) : super(key: key);
  final String txt;
  final VoidCallback ontap;
  final String heroTag;
  final String pageIcon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: GradientBoxBorder(
            gradient: LinearGradient(
                colors: [Theme.of(context).primaryColorLight, Theme.of(context).primaryColorDark],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter
            ),
            width: 1,
          ),
          // color: Colors.transparent,

          borderRadius: BorderRadius.circular(6),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Hero(
                  tag: heroTag,
                  child: Image.asset(pageIcon)
              ),
            ),
            SizedBox(height: 10,),
            Expanded(
              flex: 1,
              child: Text(
                txt,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                  fontSize: 14,

                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
