import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roadsyouwalked_app/bloc/memory/memory_bloc.dart';
import 'package:roadsyouwalked_app/bloc/user/user_bloc.dart';
import 'package:roadsyouwalked_app/model/memory/memory_order_type.dart';
import 'package:roadsyouwalked_app/ui/components/statistics/mode_selector_widget.dart';

class StatisticsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const StatisticsAppBar({super.key});

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
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: const Icon(Icons.person),
              ),
              Text(
                "You",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
            ],
          ),
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
          centerTitle: false,
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
