
import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';


class Guitar3D extends StatelessWidget {
  const Guitar3D({super.key});

  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.sizeOf(context);

    return Container(
      height: size.height,
      width: size.width,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/bg.png'),
              fit: BoxFit.cover
          )
      ),
      child: const ModelViewer(
        src: 'assets/guitar.glb',
        ar: false,
      ),
    );
  }
}
