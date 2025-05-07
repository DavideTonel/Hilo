import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roadsyouwalked_app/bloc/export/export_bloc.dart';
import 'package:roadsyouwalked_app/bloc/user/user_bloc.dart';
import 'package:roadsyouwalked_app/ui/constants/app_spacing.dart';

class ExportEvaluationsPage extends StatefulWidget {
  const ExportEvaluationsPage({super.key});

  @override
  State<ExportEvaluationsPage> createState() => _ExportEvaluationsPageState();
}

class _ExportEvaluationsPageState extends State<ExportEvaluationsPage> {
  int? _selectedDays;

  @override
  Widget build(BuildContext context) {
    final periodOptions = [7, 14, 21, 28];

    return BlocListener<ExportBloc, ExportState>(
      listener: (context, state) {
        switch (state) {
          case EvaluationsExported _:
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.message,
                ),
              ),
            );
            break;
          case ExportFailed _:
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.message,
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: const Color.fromARGB(255, 159, 23, 14),
              ),
            );
            break;
          default:
        }
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: const Text("Export Evaluations"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(AppSpacingConstants.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: AppSpacingConstants.xl),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: AppSpacingConstants.sm,
                ),
                child: ListTile(
                  leading: const Icon(Icons.calendar_today),
                  title: const Text("Select period"),
                  trailing: DropdownMenu<int>(
                    hintText:
                        _selectedDays != null
                            ? "Last $_selectedDays days"
                            : "Choose…",
                    dropdownMenuEntries:
                        periodOptions
                            .map(
                              (days) => DropdownMenuEntry(
                                value: days,
                                label: "$days days",
                              ),
                            )
                            .toList(),
                    onSelected:
                        (value) => setState(() => _selectedDays = value),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacingConstants.lg),
              ElevatedButton.icon(
                onPressed: () {
                  if (_selectedDays != null) {
                    context.read<ExportBloc>().add(
                      Export(
                        userId: context.read<UserBloc>().state.user!.username,
                        lastNDays: _selectedDays!
                      ),
                    );
                  }
                },
                icon: const Icon(Icons.file_download),
                label: const Text("Export"),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    vertical: AppSpacingConstants.sm,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
