import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_artificial_intelligence_examples/widgets/cameraStreamPageLayout.dart';
import 'package:tflite/tflite.dart';

import '../utils/constants.dart';



class FaceMaskDetection extends StatefulWidget {
  const FaceMaskDetection({Key? key}) : super(key: key);

  @override
  State<FaceMaskDetection> createState() => _FaceMaskDetectionState();
}

class _FaceMaskDetectionState extends State<FaceMaskDetection> {

  @override
  Widget build(BuildContext context) {
    return CameraStreamPageLayout(modelPath: 'assets/facemask/',
      title: 'mask Detection',
      tfliteTreshhold: .2,
      heroTag: 'facemask',
      pageIcon: 'assets/images/facemask.png',
      tfliteStreamDetectionType: TfliteStreamDetectionType.runModelOnFrame,
    );
  }
}
