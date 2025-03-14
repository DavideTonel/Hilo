import 'package:flutter/material.dart';
import 'package:roadsyouwalked_app/ui/pages/home/calendar_page.dart';
import 'package:roadsyouwalked_app/ui/pages/home/feed_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var temp = 1;

    return Scaffold(
      appBar: AppBar(
        title: temp == 0 ? Text(
          "For you",
          style: TextStyle(
            fontSize: 20
          ),
        ) : null,
      ),
      body: switch (temp) {
        0 => FeedPage(),
        1 => CalendarPage(),
        //2 => StatisticsPage(),
        _ => FeedPage()
      },
      bottomNavigationBar: NavigationBar(
        destinations: [
          NavigationDestination(
            icon: Icon(
              Icons.home_outlined
            ),
            selectedIcon: Icon(
              Icons.home
            ),
            label: "Home"
          ),
          NavigationDestination(
            icon: Icon(
              Icons.calendar_month_outlined
            ),
            selectedIcon: Icon(
              Icons.calendar_month
            ),
            label: "Calendar"
          ),
          NavigationDestination(
            icon: Icon(
              Icons.insert_chart_outlined_outlined
            ),
            selectedIcon: Icon(
              Icons.insert_chart
            ),
            label: "Statistics"
          ),
        ]
      ),
    );
  }
}
