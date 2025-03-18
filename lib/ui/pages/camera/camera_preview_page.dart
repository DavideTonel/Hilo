import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roadsyouwalked_app/bloc/camera/camera_bloc.dart';
import 'dart:developer' as dev;

import 'package:roadsyouwalked_app/ui/components/camera/camera_preview_widget.dart';
import 'package:roadsyouwalked_app/ui/pages/camera/camera_loading_page.dart';

class NewMemoryPage extends StatelessWidget {
  const NewMemoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CameraBloc(),
      child: CameraPreviewPage()
    );
  }
}

class CameraPreviewPage extends StatelessWidget {
  const CameraPreviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool loading = true;
    context.read<CameraBloc>().add(InitializeCamera());
    return BlocConsumer<CameraBloc, CameraState>(
      listener: (context, state) {
        switch (state) {
          case CameraInitial():
            dev.log("initial");
            break;
          case CameraLoading():
            dev.log("loading");
            break;
          case CameraLoaded _:
            dev.log("loaded");
            loading = false;
            break;
          case CameraError():
            break;
        }
      },
      builder: (context, state) {
        return Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: ! loading ? IconButton(
            onPressed: () {},
            icon: Icon(Icons.circle),
          ) : null,
          body: loading ? CameraLoadingPage() : CameraPreviewWidget(cameraManager: state.cameraManager),
        );
      },
    );
  }
}
