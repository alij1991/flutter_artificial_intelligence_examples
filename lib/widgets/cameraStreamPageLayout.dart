import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';

import '../utils/constants.dart';
import 'customAppBar.dart';

class CameraStreamPageLayout extends StatefulWidget {
  const CameraStreamPageLayout({Key? key, required this.modelPath, required this.title, required this.tfliteTreshhold, required this.tfliteStreamDetectionType, required this.heroTag, required this.pageIcon}) : super(key: key);
  final String modelPath;
  final String title;
  final double tfliteTreshhold;
  final String heroTag;
  final String pageIcon;
  final TfliteStreamDetectionType tfliteStreamDetectionType;
  @override
  State<CameraStreamPageLayout> createState() => _CameraStreamPageLayoutState();
}

class _CameraStreamPageLayoutState extends State<CameraStreamPageLayout> {
  CameraImage? _cameraImage;
  late CameraController _cameraController;
  bool isWorking = false;
  String result="";

  initCamera()
  {
    _cameraController = CameraController(cameras[0], ResolutionPreset.medium);
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

  Future<void> loadModel() async{
    await Tflite.loadModel(
        model: widget.modelPath+'model.tflite',
        labels: widget.modelPath+'labels.txt'
    );
    setState(() {
    });
  }

  rumModelOnFrame() async {
    if(_cameraImage != null) {
      late var rec;
      if(widget.tfliteStreamDetectionType == TfliteStreamDetectionType.runModelOnFrame) {
        rec = await Tflite.runModelOnFrame(
          bytesList: _cameraImage!.planes.map((plane) {
            return plane.bytes;
          }).toList(),
          imageWidth: _cameraImage!.width,
          imageHeight: _cameraImage!.height,
          imageMean: 127.5,
          imageStd: 127.5,
          numResults: 1,
          threshold: widget.tfliteTreshhold,
          // asynch: true,
        );
        isWorking = false;
        result = "";
        print('response: ${rec}');
        rec!.forEach((response)
        {
          result+= response["label"]+ "\n";
        });
        print('result$result');
        if(mounted)
        {
          setState(() {
            result;
          });
        }

      }
      else {
        rec = await Tflite.detectObjectOnFrame(
          bytesList: _cameraImage!.planes.map((plane) {
            return plane.bytes;
          }).toList(),
          model: "SSDMobileNet",
          numResultsPerClass: 1,
          imageWidth: _cameraImage!.width,
          imageHeight: _cameraImage!.height,
          imageMean: 127.5,
          imageStd: 127.5,
          threshold: widget.tfliteTreshhold,
        ).then((value) {
          isWorking = false;
          setState(() {
            result = value.toString();
          });
        });
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadModel();
    initCamera();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    disposeCamera();
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        // disposeCamera();
        return Future.value(true);
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          appBar: CustomAppbar(title: widget.title,),
          body: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Expanded(
                flex: 1,
                child: Hero(
                    tag: widget.heroTag,
                    child: Image.asset(widget.pageIcon)
                ),
              ),

              Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Container(
                      width: pageSize.width,
                      height: pageSize.height/2,
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColorLight,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: (!_cameraController.value.isInitialized)?
                      Container():
                      AspectRatio(
                        aspectRatio: _cameraController.value.aspectRatio,
                        child: CameraPreview(
                          _cameraController,
                        ),
                      )
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(result,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: 20,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
