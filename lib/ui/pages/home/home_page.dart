import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roadsyouwalked_app/bloc/memory/memory_bloc.dart';
import 'package:roadsyouwalked_app/bloc/user/user_bloc.dart';
import 'package:roadsyouwalked_app/model/memory/memory_order_type.dart';
import 'package:roadsyouwalked_app/ui/components/home/add_memory_action_button.dart';
import 'package:roadsyouwalked_app/ui/components/home/home_app_bar.dart';
import 'package:roadsyouwalked_app/ui/pages/home/calendar_page.dart';
import 'package:roadsyouwalked_app/ui/pages/home/feed_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var navBarIndex = 0;

    PreferredSizeWidget? scaffoldAppBar = HomeAppBar();
    Widget scaffoldBody = FeedPage();
    Widget? floatingActionButton = AddMemoryActionButton();

    const List<Widget> navigationBardestinations = [
      NavigationDestination(
        icon: Icon(Icons.home_outlined),
        selectedIcon: Icon(Icons.home),
        label: "Home",
      ),
      NavigationDestination(
        icon: Icon(Icons.calendar_month_outlined),
        selectedIcon: Icon(Icons.calendar_month),
        label: "Calendar",
      ),
      NavigationDestination(
        icon: Icon(Icons.insert_chart_outlined_outlined),
        selectedIcon: Icon(Icons.insert_chart),
        label: "Statistics",
      ),
    ];

    return BlocConsumer<MemoryBloc, MemoryState>(
      listener: (context, state) {
        switch (state.orderType) {
          case MemoryOrderType.timeline:
            navBarIndex = 0;
            scaffoldAppBar = HomeAppBar();
            scaffoldBody = FeedPage();
            floatingActionButton = AddMemoryActionButton();
            break;
          case MemoryOrderType.calendar:
            navBarIndex = 1;
            scaffoldAppBar = AppBar();
            scaffoldBody = CalendarPage(
              memories: state.memories,
              month: state.month,
              year: state.year,
              onPrevPressed: () {
                context.read<MemoryBloc>().add(
                  SetTime(
                    userId: context.read<UserBloc>().state.user!.username,
                    month: state.month - 1
                  )
                );
              },
              onNextPressed: () {
                context.read<MemoryBloc>().add(
                  SetTime(
                    userId: context.read<UserBloc>().state.user!.username,
                    month: state.month + 1
                  )
                );
              },
            );
            floatingActionButton = null;
            break;
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: scaffoldAppBar,
          body: scaffoldBody,
          bottomNavigationBar: NavigationBar(
            selectedIndex: navBarIndex,
            onDestinationSelected: (value) {
              switch (value) {
                case 0:
                  context.read<MemoryBloc>().add(
                    LoadMemoriesByUserId(
                      userId: context.read<UserBloc>().state.user!.username,
                      orderType: MemoryOrderType.timeline
                    )
                  );
                  break;
                case 1:
                  context.read<MemoryBloc>().add(
                    LoadMemoriesByUserId(
                      userId: context.read<UserBloc>().state.user!.username,
                      orderType: MemoryOrderType.calendar,
                      year: state.year,
                      month: state.month
                    )
                  );
                  break;
                default:
              }
            },
            destinations: navigationBardestinations,
          ),
          floatingActionButton: floatingActionButton
        );
      },
    );
  }
}
