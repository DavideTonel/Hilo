import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roadsyouwalked_app/bloc/export/export_bloc.dart';
import 'package:roadsyouwalked_app/ui/pages/evaluation/export_evaluations_page.dart';

class ExportEvaluationWrapperPage extends StatelessWidget {
  const ExportEvaluationWrapperPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ExportBloc(),
      child: ExportEvaluationsPage(),
    );
  }
}
