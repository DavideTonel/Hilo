import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roadsyouwalked_app/bloc/camera/camera_bloc.dart';
import 'package:roadsyouwalked_app/model/media/media_type.dart';
import 'package:roadsyouwalked_app/ui/pages/camera/camera_wrapper_page.dart';

class CameraPage extends StatelessWidget {
  final void Function(File? localFile, String? remoteUri, MediaType mediaType) onSaveMedia;

  const CameraPage({super.key, required this.onSaveMedia});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CameraBloc()..add(InitializeCamera()),
      child: CameraWrapperPage(
        onSaveMedia: onSaveMedia,
      ),
    );
  }
}
