import 'package:flutter/material.dart';

// image_picker
import 'package:image_picker/image_picker.dart';

// image_gallery_saver
import 'package:image_gallery_saver/image_gallery_saver.dart';

import 'dart:io'; //File
import 'dart:typed_data'; // Uint8List

class ImagePickerGalleryPage extends StatefulWidget {
  const ImagePickerGalleryPage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<ImagePickerGalleryPage> {
  late File _image;
  final picker = ImagePicker();

  // 画像の読み込み
  Future _getImage() async {
    //final pickedFile = await picker.getImage(source: ImageSource.camera);//カメラ
    final pickedFile = await picker.getImage(source: ImageSource.gallery);//アルバム

    if(pickedFile != null) {
      setState((){
        _image = File(pickedFile.path);
      });
    }
  }

  // 画像の保存
  Future _saveImage() async {
    if(_image != null) {
      Uint8List _buffer = await _image.readAsBytes();
      final result = await ImageGallerySaver.saveImage(_buffer);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ImagePickerGalleryPage'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _image == null
                ? Text('No image selected.')
                : Image.file(_image),
            ElevatedButton(
              child: Text('Save'),
              onPressed: _saveImage,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getImage,
        tooltip: 'Pick',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}