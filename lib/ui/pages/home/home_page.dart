import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roadsyouwalked_app/bloc/navigation/home/navigation_home_bloc.dart';
import 'package:roadsyouwalked_app/ui/pages/home/calendar_page.dart';
import 'package:roadsyouwalked_app/ui/pages/home/feed_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var navBarIndex = 0;

    return BlocConsumer<NavigationHomeBloc, NavigationHomeState>(
      listener: (context, state) {
        switch (state) {
          case MemoryFeedUI _:
            navBarIndex = 0;
            break;
          case CalendarUI _:
            navBarIndex = 1;
            break;
          }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: navBarIndex == 0 ? Text("For you", style: TextStyle(fontSize: 20)) : null,
          ),
          body: switch (navBarIndex) {
            0 => FeedPage(),
            1 => CalendarPage(),
            //2 => StatisticsPage(),
            _ => FeedPage(),
          },
          bottomNavigationBar: NavigationBar(
            selectedIndex: navBarIndex,
            onDestinationSelected: (value) {
              switch (value) {
                case 0:
                  context.read<NavigationHomeBloc>().add(NavigateToMemoryFeed());
                  break;
                case 1:
                  context.read<NavigationHomeBloc>().add(NavigateToCalendar());
                  break;
                default:
              }
            },
            destinations: [
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
            ],
          ),
        );
      },
    );
  }
}
