
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_artificial_intelligence_examples/widgets/imagePickerPageLayout.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

import '../widgets/customButton.dart';

class CatDogClassifier extends StatefulWidget {
  const CatDogClassifier({Key? key}) : super(key: key);

  @override
  State<CatDogClassifier> createState() => _CatDogClassifierState();
}

class _CatDogClassifierState extends State<CatDogClassifier> {

  @override
  Widget build(BuildContext context) {
    return ImagePickerPageLayout(modelPath: 'assets/catdog/',
        title: 'Cat Dog Classifier',
        pageIcon: 'assets/images/catdog.png',
      tfliteTreshhold: .6,
      heroTag: 'catdog',
    );
  }
}

