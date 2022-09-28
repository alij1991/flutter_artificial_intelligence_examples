
import 'package:flutter/material.dart';
import 'package:gradient_borders/gradient_borders.dart';

class CustomButtom extends StatelessWidget {
  const CustomButtom({
    Key? key, required this.txt, required this.ontap,
  }) : super(key: key);
  final String txt;
  final VoidCallback ontap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        width: MediaQuery.of(context).size.width - 150,
        alignment: Alignment.center,
        decoration: BoxDecoration(

          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(6),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 18),
        child: Text(
          txt,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
              fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }
}