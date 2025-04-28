import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roadsyouwalked_app/bloc/memory/memory_bloc.dart';
import 'package:roadsyouwalked_app/bloc/user/user_bloc.dart';
import 'package:roadsyouwalked_app/model/authentication/user.dart';
import 'package:roadsyouwalked_app/model/memory/memory_order_type.dart';
import 'package:roadsyouwalked_app/ui/components/statistics/mode_selector_widget.dart';
import 'package:roadsyouwalked_app/ui/components/user/profile_image_widget.dart';
import 'package:roadsyouwalked_app/ui/constants/app_spacing.dart';

class StatisticsAppBar extends StatelessWidget implements PreferredSizeWidget {
  final User? user;

  const StatisticsAppBar({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MemoryBloc, MemoryState>(
      buildWhen: (previous, current) {
        return current.orderType == MemoryOrderType.lastNDays ||
            current.orderType == MemoryOrderType.byMonth ||
            current.orderType == MemoryOrderType.byYear;
      },
      builder: (context, state) {
        return AppBar(
          titleSpacing: 0,
          leadingWidth: (user?.profileImagePath != null) ? 50 : kToolbarHeight,
          leading: Builder(
            builder:
                (context) =>
                    user?.profileImagePath != null
                        ? Padding(
                          padding: const EdgeInsets.only(
                            left: AppSpacingConstants.sm,
                            right: AppSpacingConstants.xs,
                          ),
                          child: InkWell(
                            onTap: () {
                              Scaffold.of(context).openDrawer();
                            },
                            child: Center(
                              child: ProfileImageWidget(
                                path: user!.profileImagePath!,
                                width: 30,
                              ),
                            ),
                          ),
                        )
                        : IconButton(
                          icon: Icon(
                            Icons.account_circle_outlined,
                            size: 33,
                            color:
                                Theme.of(
                                  context,
                                ).colorScheme.onPrimaryContainer,
                          ),
                          onPressed: () {
                            Scaffold.of(context).openDrawer();
                          },
                        ),
          ),
          title: Text(
            "You",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 21,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
          ),
          centerTitle: false,
          elevation: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 110.0),
              child: ModeSelectorWidget(
                modes: [
                  MemoryOrderType.lastNDays,
                  MemoryOrderType.byMonth,
                  MemoryOrderType.byYear,
                ],
                selectedMode: state.orderType,
                onSelect: (mode) {
                  context.read<MemoryBloc>().add(
                    LoadMemories(
                      userId: context.read<UserBloc>().state.user!.username,
                      orderType: mode,
                      year: state.year,
                      month: state.month,
                      lastNDays: state.lastNDays,
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
