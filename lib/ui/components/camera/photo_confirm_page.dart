import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roadsyouwalked_app/bloc/camera/camera_bloc.dart';

class PhotoConfirmPage extends StatelessWidget {
  const PhotoConfirmPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CameraBloc, CameraState>(
      listener: (context, state) {
      },
      builder:(context, state) { 
        final size = MediaQuery.of(context).size;
        return Stack(
          children: [
            SizedBox(
              width: size.width,
              height: size.height,
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: 100,
                  child: Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationY(math.pi),
                    child: Image.file(File(state.photoTaken!.path)),
                  ),
                ),
              ),
            ),
          ],
        );
      }
    );
  }
}
