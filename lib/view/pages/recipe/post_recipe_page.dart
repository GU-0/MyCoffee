import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PostRecipePage extends StatefulWidget {
  @override
  State<PostRecipePage> createState() => _PostRecipePageState();
}

class _PostRecipePageState extends State<PostRecipePage> {
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: const Drawer(),
      body: Column(
        children: [
          const Padding(padding: EdgeInsets.all(5)),
          toolImage(),
          const Padding(padding: EdgeInsets.all(10)),
          const Text("brewing page"),
        ],
      ),
    );
  }

  // 기본이미지는 추출도구, 음료 사진 등록해서 변경할 수 있게 함.
  Widget toolImage() {
    return Center(
        child: Stack(
      children: <Widget>[
        CircleAvatar(
          radius: 80,
          backgroundImage: _imageFile == null
              ? const AssetImage('assets/images/example.jpg')
              : FileImage(File(_imageFile!.path)) as ImageProvider,
        ),
        Positioned(
            bottom: 20,
            right: 20,
            child: InkWell(
              onTap: () {
                //클릭시 모달 팝업을 띄워줌.
                showModalBottomSheet(
                    context: context, builder: ((builder) => bottomSheet()));
              },
              child: const Icon(
                Icons.camera_alt,
                color: Colors.white,
                size: 40,
              ),
            ))
      ],
    ));
  }

  Widget bottomSheet() {
    final med = MediaQuery.of(context).size;
    return Container(
      height: med.height * 0.2,
      width: med.width * 0.4,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: <Widget>[
          const Text(
            "사진을 등록해주세요.",
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton(
                  onPressed: () {
                    takePhoto(ImageSource.camera);
                  },
                  child: const Icon(
                    Icons.camera,
                    size: 50,
                  )),
              Padding(
                  padding: EdgeInsets.fromLTRB(
                      med.width * 0.17, 0, med.width * 0.17, 0)),
              TextButton(
                  onPressed: () {
                    takePhoto(ImageSource.gallery);
                  },
                  child: const Icon(
                    Icons.photo_library,
                    size: 50,
                  )),
            ],
          )
        ],
      ),
    );
  }

  takePhoto(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    setState(() {
      _imageFile = pickedFile;
    });
  }
}
