import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roadsyouwalked_app/bloc/settings/settings_bloc.dart';
import 'package:roadsyouwalked_app/ui/components/input/color_picker_tile.dart';
import 'package:roadsyouwalked_app/ui/constants/app_spacing.dart';
import 'package:roadsyouwalked_app/ui/helper/map_style.dart';
import 'package:roadsyouwalked_app/ui/helper/theme_light.dart';

class AppaerancePage extends StatelessWidget {
  const AppaerancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        final items = List.of([
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: Icon(Icons.light_mode),
              title: Text("Theme"),
              trailing: DropdownMenu(
                hintText: state.settings!.theme.value,
                dropdownMenuEntries:
                    ThemeLight.values
                        .map(
                          (theme) =>
                              DropdownMenuEntry(value: theme, label: theme.value),
                        )
                        .toList(),
                onSelected:
                    (value) => context.read<SettingsBloc>().add(
                      UpdateSettings(
                        settings: state.settings!.copyWith(newTheme: value),
                      ),
                    ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: Icon(Icons.map_outlined),
              title: Text("Map style"),
              trailing: DropdownMenu(
                hintText: state.settings!.mapStyle.value,
                dropdownMenuEntries:
                    MapStyle.values
                        .map(
                          (style) =>
                              DropdownMenuEntry(value: style, label: style.value),
                        )
                        .toList(),
                onSelected:
                    (value) => context.read<SettingsBloc>().add(
                      UpdateSettings(
                        settings: state.settings!.copyWith(newMapStyle: value),
                      ),
                    ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ColorPickerTile(
              currentColor: state.settings!.themeSeedColor,
              onColorSelected: (selectedColor) {
                context.read<SettingsBloc>().add(
                  UpdateSettings(
                    settings: context
                        .read<SettingsBloc>()
                        .state
                        .settings!
                        .copyWith(newThemeSeedColor: selectedColor),
                  ),
                );
              },
            ),
          ),
        ]);

        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            leading: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Center(child: Icon(Icons.looks, size: 40,)),
            ),
            title: Text("Appaerance"),
          ),
          body: Column(
            children: [
              const SizedBox(height: AppSpacingConstants.lg),
              Expanded(
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return items[index];
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
