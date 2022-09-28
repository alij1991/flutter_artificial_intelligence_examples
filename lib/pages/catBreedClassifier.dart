import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

import '../utils/constants.dart';
import '../widgets/imagePickerPageLayout.dart';

class CatBreedClassifier extends StatefulWidget {
  const CatBreedClassifier({Key? key}) : super(key: key);

  @override
  State<CatBreedClassifier> createState() => _CatBreedClassifierState();
}

class _CatBreedClassifierState extends State<CatBreedClassifier> {

  @override
  Widget build(BuildContext context) {
    return ImagePickerPageLayout(modelPath: 'assets/catbreed/',
        heroTag: 'catbreed',
        title: 'Cat Breed Classifier',
        pageIcon: 'assets/images/catdog.png',
      tfliteTreshhold: .5,
    );
  }
}
