import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

import 'customAppBar.dart';
import 'customButton.dart';

class ImagePickerPageLayout extends StatefulWidget {
  const ImagePickerPageLayout({Key? key, required this.modelPath, required this.title, required this.pageIcon, required this.tfliteTreshhold, required this.heroTag}) : super(key: key);
  final String modelPath;
  final String title;
  final String pageIcon;
  final double tfliteTreshhold;
  final String heroTag;
  @override
  State<ImagePickerPageLayout> createState() => _ImagePickerPageLayoutState();
}

class _ImagePickerPageLayoutState extends State<ImagePickerPageLayout> {
  bool _loading = true;
  late File _image;
  List? _output;
  final picker = ImagePicker();

  detectImage(File image)async{
    var output = await Tflite.runModelOnImage(
        path: image.path,
        numResults: 1,
        threshold: widget.tfliteTreshhold,
        imageMean: 127.5,
        imageStd: 127.5,
        asynch: true
    );
    print(output!.length.toString());
    print(output);
    setState(() {
      _output = output;
      _loading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadModel();
  }

  Future<void> loadModel() async{
    await Tflite.loadModel(
      model: widget.modelPath+'model_unquant.tflite',
      labels: widget.modelPath+'labels.txt',
      numThreads: 1,
      isAsset: true,
      useGpuDelegate: false,
    );
    setState(() {

    });
  }

  captureImage() async{
    var image = await picker.pickImage(source: ImageSource.camera);
    if (image == null) return null;
    setState(() {
      _image = File(image.path);
    });
    detectImage(_image);
  }

  uploadImage() async{
    var image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) return null;
    setState(() {
      _image = File(image.path);
    });
    detectImage(_image);
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: CustomAppbar(title: widget.title,),
      body: Container(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              const SizedBox(
                height: 50,
              ),
              _loading? Container(
                width: 250,
                child: Column(
                  children: [
                    Hero(
                      tag: widget.heroTag,
                        child: Image.asset(widget.pageIcon)
                    ),
                    const SizedBox(
                      height: 50,
                    )
                  ],
                ),
              ):
              Container(
                child: Column(
                  children: [
                    Container(
                      height: 250,
                      child: Image.file(_image),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    _output != null?
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Result:',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(width: 20,),
                        Text(_output!.isNotEmpty?'${_output![0]['label']}':'Not Found',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ):
                    Container(),
                    const SizedBox(
                      height: 20,
                    ),
                    _output != null?
                    Text(_output!.isNotEmpty?'Confidence:  ${_output![0]['confidence'].toStringAsFixed(2)}':'',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 15,

                      ),
                    ):
                    Container(),
                    const SizedBox(
                      height: 40,
                    )
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    CustomButtom(
                      txt: 'Capture a Photo',
                      ontap: captureImage,
                    ),
                    const SizedBox(height: 15,),
                    CustomButtom(
                      txt: 'Upload from gallery',
                      ontap: uploadImage,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
