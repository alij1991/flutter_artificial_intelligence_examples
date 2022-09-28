import 'package:flutter/material.dart';
import 'package:flutter_artificial_intelligence_examples/utils/constants.dart';
import 'package:tflite/tflite.dart';
import 'dart:math' as math;
import '../objectDetection/bounding_box.dart';
import '../objectDetection/camera.dart';
import '../widgets/cameraStreamPageLayout.dart';
import '../widgets/customAppBar.dart';

class ObjectDetection extends StatefulWidget {
  const ObjectDetection({Key? key}) : super(key: key);

  @override
  State<ObjectDetection> createState() => _ObjectDetectionState();
}

class _ObjectDetectionState extends State<ObjectDetection> {
  List<dynamic>? _recognitions;
  int _imageHeight = 0;
  int _imageWidth = 0;
  initCameras() async {

  }
  loadTfModel() async {
    await Tflite.loadModel(
      model: "assets/objectdetection/model.tflite",
      labels: "assets/objectdetection/labels.txt",
    );
  }
  /*
  The set recognitions function assigns the values of recognitions, imageHeight and width to the variables defined here as callback
  */
  setRecognitions(recognitions, imageHeight, imageWidth) {
    try {
      setState(() {
        _recognitions = recognitions;
        _imageHeight = imageHeight;
        _imageWidth = imageWidth;
      });
    }catch(e){}
  }

  @override
  void initState() {
    super.initState();
    loadTfModel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: CustomAppbar(title: 'Real Time Object Detection',),
      body: Stack(
        children: <Widget>[
          CameraFeed(cameras, setRecognitions),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: BoundingBox(
              _recognitions == null ? [] : _recognitions!,
              math.max(_imageHeight, _imageWidth),
              math.min(_imageHeight, _imageWidth),
              pageSize.height,
              pageSize.width,
            ),
          ),
        ],
      ),
    );
  }
}
