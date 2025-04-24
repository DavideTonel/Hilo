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

class CameraPage extends StatelessWidget {
  final void Function(File? localFile, String? remoteUri, MediaType mediaType)
  onSaveMedia;

  const CameraPage({super.key, required this.onSaveMedia});

  Widget _getPage(BuildContext context, CameraState state) {
    final cameraBloc = context.read<CameraBloc>();
    switch (state) {
      case CameraLoaded _:
        return CameraPreviewPage(
          cameraManager: state.cameraManager,
          onCameraTap: () => cameraBloc.add(TakePhoto()),
        );
      case CameraMediaTaken _:
        return CameraMediaPreviewPage(
          media: File(cameraBloc.state.photoTaken!.path),
          onSaveMedia: (localFile, remoteUri, mediaType) {
            cameraBloc.add(AcceptMedia());
            return onSaveMedia(localFile, remoteUri, mediaType);
          },
        );
      case CameraMediaAccepted _:
        return CameraMediaPage(media: File(cameraBloc.state.photoTaken!.path));
      case CameraDenied _:
        return CameraDeniedPage(
          onChangePermissionsPressed: () => cameraBloc.add(InitCamera()),
        );
      case CameraInitial():
        return CameraLoadingPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CameraBloc, CameraState>(
      builder: (context, state) {
        return _getPage(context, state);
      },
    );
  }
}
