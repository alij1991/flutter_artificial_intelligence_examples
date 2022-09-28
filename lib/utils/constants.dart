import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';

late List<CameraDescription> cameras;
late Size pageSize;

enum TfliteStreamDetectionType{
  runModelOnFrame,
  detectObjectOnFrame,
}
