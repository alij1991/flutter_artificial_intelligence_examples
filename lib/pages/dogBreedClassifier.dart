import 'package:flutter/material.dart';

import '../widgets/imagePickerPageLayout.dart';

class DogBreedClassifier extends StatefulWidget {
  const DogBreedClassifier({Key? key}) : super(key: key);

  @override
  State<DogBreedClassifier> createState() => _DogBreedClassifierState();
}

class _DogBreedClassifierState extends State<DogBreedClassifier> {
  @override
  Widget build(BuildContext context) {
    return ImagePickerPageLayout(modelPath: 'assets/dogbreed/',
        heroTag: 'dogbreed',
        title: 'Dog Breed Classifier',
        pageIcon: 'assets/images/dogbreed.png',
      tfliteTreshhold: .1,
    );
  }
}
