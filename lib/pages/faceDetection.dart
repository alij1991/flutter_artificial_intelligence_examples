import 'dart:math';
import 'dart:math' as math;
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

import '../faceDetection/coordinates_translator.dart';
import '../faceDetection/face_detector_painter.dart';
import '../objectDetection/bounding_box.dart';
import '../utils/constants.dart';
import '../widgets/customAppBar.dart';

class FaceDetection extends StatefulWidget {
  const FaceDetection({Key? key}) : super(key: key);

  @override
  State<FaceDetection> createState() => _FaceDetectionState();
}

class _FaceDetectionState extends State<FaceDetection> {
  CameraImage? _cameraImage;
  late CameraController _cameraController;
  bool isWorking = false;
  String result="";
  late final FaceDetectorOptions options;
  late final FaceDetector faceDetector;
  List<Face>? faces;
  InputImage? inputImage;
  var scale = pageSize.aspectRatio;

  initCamera()
  {
    _cameraController = CameraController(cameras[0], ResolutionPreset.high);
    _cameraController.initialize().then((value){

      if(!mounted)
      {
        return;
      }
      setState(() {
        _cameraController.startImageStream((image){
          if(!isWorking){
            isWorking = true;
            _cameraImage = image;
            rumModelOnFrame();
          }
        });
      });
    });
  }

  disposeCamera()async{
    await _cameraController.stopImageStream();
    await _cameraController.dispose();
  }

  Future<InputImage?> processCameraImage(CameraImage image) async {
    final WriteBuffer allBytes = WriteBuffer();
    for (final Plane plane in image.planes) {
      allBytes.putUint8List(plane.bytes);
    }
    final bytes = allBytes.done().buffer.asUint8List();

    final Size imageSize =
    Size(image.width.toDouble(), image.height.toDouble());

    final camera = cameras[0];
    final imageRotation =
    InputImageRotationValue.fromRawValue(camera.sensorOrientation);
    if (imageRotation == null) {
      return null;
    }

    final inputImageFormat =
    InputImageFormatValue.fromRawValue(image.format.raw);
    if (inputImageFormat == null) {
      return null;
    }

    final planeData = image.planes.map(
          (Plane plane) {
        return InputImagePlaneMetadata(
          bytesPerRow: plane.bytesPerRow,
          height: plane.height,
          width: plane.width,
        );
      },
    ).toList();

    final inputImageData = InputImageData(
      size: imageSize,
      imageRotation: imageRotation,
      inputImageFormat: inputImageFormat,
      planeData: planeData,
    );

    final inputImage =
    InputImage.fromBytes(bytes: bytes, inputImageData: inputImageData);

    return inputImage;
  }

  rumModelOnFrame() async {
    if(_cameraImage != null) {
      inputImage = await processCameraImage(_cameraImage!);
      faces = await faceDetector.processImage(inputImage!);
      isWorking = false;
      if (mounted) {
        setState(() {});
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initCamera();

    options = FaceDetectorOptions(
      enableContours: true,
      enableLandmarks: true,
      enableClassification: true,
    );
    faceDetector = FaceDetector(options: options);
  }
  @override
  void dispose() {
    // TODO: implement dispose
    disposeCamera();
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {

    // scale = pageSize.aspectRatio * _cameraController.value.aspectRatio;
    // // to prevent scaling down, invert the value
    // if (scale < 1) scale = 1 / scale;
    return WillPopScope(
      onWillPop: (){
        // disposeCamera();
        return Future.value(true);
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: CustomAppbar(title: 'Face Detection',),
        body: (!_cameraController.value.isInitialized)?
        Container():
        Stack(
          fit: StackFit.expand,
          children: [
            Transform.scale(
              scale: 1,
              child: CameraPreview(
                _cameraController,
              ),
            ),
            if(inputImage!=null)CustomPaint(
              painter: OpenPainter(faces,inputImage!.inputImageData!.size,
                  inputImage!.inputImageData!.imageRotation),
            ),
          ]
        ),
      ),
    );
  }
}

class OpenPainter extends CustomPainter {
  // final Rect rect;
  List<Face>? faces;
  final Size absoluteImageSize;
  final InputImageRotation rotation;
  OpenPainter(this.faces, this.absoluteImageSize, this.rotation);
  @override
  void paint(Canvas canvas, Size size) {

    var paint1 = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
    ..strokeWidth = 4;
    if(faces!=null) {
      for (final Face face in faces!) {
        canvas.drawRect(
          Rect.fromLTRB(
            translateX(
                face.boundingBox.left, rotation, size, absoluteImageSize),
            translateY(face.boundingBox.top, rotation, size, absoluteImageSize),
            translateX(
                face.boundingBox.right, rotation, size, absoluteImageSize),
            translateY(
                face.boundingBox.bottom, rotation, size, absoluteImageSize),
          ),
          paint1,
        );
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
