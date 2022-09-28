import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_artificial_intelligence_examples/pages/catBreedClassifier.dart';
import 'package:flutter_artificial_intelligence_examples/pages/catDogClassifier.dart';
import 'package:flutter_artificial_intelligence_examples/pages/faceMaskDetection.dart';
import 'package:flutter_artificial_intelligence_examples/pages/fruitsClassifier.dart';
import 'package:flutter_artificial_intelligence_examples/pages/objectDetection.dart';
import 'package:flutter_artificial_intelligence_examples/widgets/customAppBar.dart';

import '../widgets/mainPageButtons.dart';
import 'dogBreedClassifier.dart';
import 'faceDetection.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: CustomAppbar(title: 'AI Examples',noBackButton: true),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 48.0,horizontal: 12),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          shrinkWrap: true,
          childAspectRatio: 1/.8,
          children: [
            MainPageButtons(
              txt: 'Object Detection',
              heroTag: 'objectdetection',
              pageIcon: 'assets/images/objectdetection.png',
              ontap: (){
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return ObjectDetection();
                }));
              },
            ),
            MainPageButtons(
              txt: 'Face Detection',
              heroTag: 'facedetection',
              pageIcon: 'assets/images/facedetection.png',
              ontap: (){
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return FaceDetection();
                }));
              },
            ),
            MainPageButtons(
              txt: 'CatDog classifier',
              pageIcon: 'assets/images/catdog.png',
              heroTag: 'catdog',
              ontap: (){
                Navigator.of(context)
                   .push(MaterialPageRoute(builder: (context) {
                 return CatDogClassifier();
               }));
              },
            ),
            MainPageButtons(
              txt: 'Face Mask Detection',
              heroTag: 'facemask',
              pageIcon: 'assets/images/facemask.png',
              ontap: (){
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return FaceMaskDetection();
                }));
              },
            ),
            // MainPageButtons(
            //   txt: 'Cat Breed Classifier',
            //   ontap: (){
            //     Navigator.of(context)
            //         .push(MaterialPageRoute(builder: (context) {
            //       return CatBreedClassifier();
            //     }));
            //   },
            // ),
            MainPageButtons(
              txt: 'Dog Breed Classifier',
              heroTag: 'dogbreed',
              pageIcon: 'assets/images/dogbreed.png',
              ontap: (){
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return DogBreedClassifier();
                }));
              },
            ),
            MainPageButtons(
              txt: 'Fruits Classifier',
              heroTag: 'fruits',
              pageIcon: 'assets/images/fruits.png',
              ontap: (){
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return FruitsClassifier();
                }));
              },
            ),

          ],
        ),
      ),
    );
  }
}
