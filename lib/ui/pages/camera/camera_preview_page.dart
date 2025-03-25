import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roadsyouwalked_app/bloc/camera/camera_bloc.dart';
import 'package:roadsyouwalked_app/bloc/private_storage/private_storage_bloc.dart';
import 'package:roadsyouwalked_app/ui/components/camera/camera_button.dart';

import 'package:roadsyouwalked_app/ui/components/camera/camera_preview_widget.dart';
import 'package:roadsyouwalked_app/ui/components/camera/photo_confirm_page.dart';
import 'package:roadsyouwalked_app/ui/pages/camera/camera_loading_page.dart';

class CameraPreviewPage extends StatelessWidget {
  const CameraPreviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<CameraBloc>().add(InitializeCamera());

    Widget scaffoldBody = CameraLoadingPage();
    Widget? scaffoldActionButton;

    return BlocConsumer<CameraBloc, CameraState>(
      listener: (context, state) {
        switch (state) {
          case CameraInitial():
            break;
          case CameraLoaded():
            scaffoldBody = CameraPreviewWidget(
              cameraManager: state.cameraManager,
            );
            scaffoldActionButton = Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: CameraButton(onPressed: () => context.read<CameraBloc>().add(TakePhoto())),
            );
            break;
          case CameraDenied():
            scaffoldBody = Center(child: Text("Camera denied"),);
            break;
          case CameraPhotoTaken():
            context.read<PrivateStorageBloc>().add(SaveImage(name: "ciao.png", data: state.photoTaken!));
            scaffoldBody = PhotoConfirmPage();
            break;
        }
      },
      builder: (context, state) {
        return Scaffold(
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: scaffoldActionButton,
          body: scaffoldBody
        );
      },
    );
  }
}
