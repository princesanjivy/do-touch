import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class GetPosition extends StatefulWidget {
  const GetPosition({Key? key}) : super(key: key);

  @override
  _GetPositionState createState() => _GetPositionState();
}

class _GetPositionState extends State<GetPosition> {
  File? img;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Img(
          imageFile: img,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final ImagePicker _picker = ImagePicker();
          // Pick an image
          final XFile? image =
              await _picker.pickImage(source: ImageSource.gallery);

          setState(() {
            File? file = File(image!.path);
            img = file;
          });
        },
        child: const Icon(Icons.image),
      ),
    );
  }
}

class Img extends StatefulWidget {
  const Img({Key? key, required this.imageFile}) : super(key: key);

  final File? imageFile;

  @override
  _ImgState createState() => _ImgState();
}

class _ImgState extends State<Img> {
  double off = 25;

  double posX = 0;
  double posY = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          Container(
            width: 1080 / 5,

            /// original Image width and
            height: 2400 / 5,

            /// height
            color: Colors.red,
            child: widget.imageFile == null
                ? Image.network(
                    "https://placekitten.com/1080/2400?image=12",
                    fit: BoxFit.contain,
                  )
                : Image.file(
                    widget.imageFile!,
                    fit: BoxFit.contain,
                  ),
          ),
          Transform.translate(
            offset: Offset(posX - (off / 2), posY - (off / 2)),
            child: Container(
              width: off,
              height: off,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.amber.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
              child: Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        ],
      ),
      onTapDown: (onTapDownDetails) {
        Size size = MediaQuery.of(context).size;
        Size phySize = window.physicalSize;

        print("Physical Size: $phySize");
        print("Logical Size: $size");

        final RenderBox? box = context.findRenderObject() as RenderBox?;
        final Offset? localOffset =
            box?.globalToLocal(onTapDownDetails.globalPosition);

        setState(() {
          posX = localOffset!.dx;
          posY = localOffset.dy;
          // posX = onTapDownDetails.globalPosition.dx;
          // posY = onTapDownDetails.globalPosition.dy;
        });

        print("Position: $posX, $posY");
        print("Position: ${posX * 5}, ${posY * 5}");
      },
    );
  }
}
