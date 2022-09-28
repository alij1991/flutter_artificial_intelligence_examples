import 'package:flutter/material.dart';

import '../widgets/imagePickerPageLayout.dart';

class FruitsClassifier extends StatefulWidget {
  const FruitsClassifier({Key? key}) : super(key: key);

  @override
  State<FruitsClassifier> createState() => _FruitsClassifierState();
}

class _FruitsClassifierState extends State<FruitsClassifier> {
  @override
  Widget build(BuildContext context) {
    return ImagePickerPageLayout(modelPath: 'assets/fruits/',
      title: 'Fruits Classifier',
      heroTag: 'fruits',
      pageIcon: 'assets/images/fruits.png',
      tfliteTreshhold: .4,
    );
  }
}
