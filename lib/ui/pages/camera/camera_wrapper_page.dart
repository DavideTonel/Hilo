import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roadsyouwalked_app/bloc/camera/camera_bloc.dart';
import 'package:roadsyouwalked_app/model/media/media_type.dart';
import 'package:roadsyouwalked_app/ui/pages/camera/camera_denied_page.dart';
import 'package:roadsyouwalked_app/ui/pages/camera/camera_loading_page.dart';
import 'package:roadsyouwalked_app/ui/pages/camera/camera_media_page.dart';
import 'package:roadsyouwalked_app/ui/pages/camera/camera_media_preview_page.dart';
import 'package:roadsyouwalked_app/ui/pages/camera/camera_preview_page.dart';

class CameraWrapperPage extends StatelessWidget {
  final void Function(File? localFile, String? remoteUri, MediaType mediaType) onSaveMedia;

  const CameraWrapperPage({super.key, required this.onSaveMedia});

  @override
  Widget build(BuildContext context) {
    Widget page = CameraLoadingPage();
    final cameraBloc = context.read<CameraBloc>();

    return BlocConsumer<CameraBloc, CameraState>(
      listener: (context, state) {
        switch (state) {
          case CameraLoaded _:
            page = CameraPreviewPage(
              cameraManager: state.cameraManager,
              onCameraTap: () => cameraBloc.add(TakePhoto()),
            );
            break;
          case CameraMediaTaken _:
            page = CameraMediaPreviewPage(
              media: File(cameraBloc.state.photoTaken!.path),
              onSaveMedia: (localFile, remoteUri, mediaType) {
                cameraBloc.add(AcceptMedia());
                return onSaveMedia(localFile, remoteUri, mediaType);
              },
            );
            break;
          case CameraMediaAccepted _:
            page = CameraMediaPage(
              media: File(cameraBloc.state.photoTaken!.path)
            );
            break;
          case CameraDenied _:
            page = CameraDeniedPage(
              onChangePermissionsPressed: () => cameraBloc.add(InitializeCamera()),
            );
            break;
          default:

        }
      },
      builder: (context, state) {
        return page;
      },
    );
  }
}
