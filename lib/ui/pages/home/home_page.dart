import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:roadsyouwalked_app/bloc/private_storage/private_storage_bloc.dart';
import 'package:roadsyouwalked_app/ui/pages/home/calendar_page.dart';
import 'package:roadsyouwalked_app/ui/pages/home/feed_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var navBarIndex = 0;

    return BlocConsumer<PrivateStorageBloc, PrivateStorageState>(
      listener: (context, state) {
        // TODO based on the state change the navBarIndex value
      },
      builder: (context, state) {
        return Scaffold(
          appBar: navBarIndex == 0 ? AppBar(
            title: Text("For you", style: TextStyle(fontSize: 20)),
            actions: [
              IconButton(
                onPressed: () => GoRouter.of(context).push("/home/profile"),
                icon: Icon(Icons.person),
              ),
            ],
          ) : null,
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
                  // TODO change memories order type here
                  break;
                case 1:
                  
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
          floatingActionButton: Container(
            color: Colors.lightBlueAccent[100],
            child: IconButton(
              onPressed: () => GoRouter.of(context).push("/memory/add/photo"),
              icon: Icon(
                Icons.add
              )
            ),
          ),
        );
      },
    );
  }
}
