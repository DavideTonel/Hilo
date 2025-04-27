import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:roadsyouwalked_app/bloc/memory/memory_bloc.dart';
import 'package:roadsyouwalked_app/bloc/user/user_bloc.dart';
import 'package:roadsyouwalked_app/model/memory/memory_order_type.dart';
import 'package:roadsyouwalked_app/ui/components/home/add_memory_action_button.dart';
import 'package:roadsyouwalked_app/ui/components/home/home_app_bar.dart';
import 'package:roadsyouwalked_app/ui/components/statistics/statistics_app_bar.dart';
import 'package:roadsyouwalked_app/ui/constants/app_spacing.dart';
import 'package:roadsyouwalked_app/ui/pages/home/calendar_page.dart';
import 'package:roadsyouwalked_app/ui/pages/home/feed_page.dart';
import 'package:roadsyouwalked_app/ui/pages/statistics/statistics_page.dart';

import 'dart:developer' as dev;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static const Map<int, MemoryOrderType> _orderTypeMap = {
    0: MemoryOrderType.timeline,
    1: MemoryOrderType.byMonth,
    2: MemoryOrderType.lastNDays,
  };

  @override
  void initState() {
    super.initState();
    _loadInitialMemories();
  }

  MemoryOrderType _getMemoryOrderTypeFromIndex(final int index) {
    return _orderTypeMap[index] ?? MemoryOrderType.timeline;
  }

  Future<void> _loadInitialMemories() async {
    final userId = context.read<UserBloc>().state.user?.username;
    if (userId != null) {
      context.read<MemoryBloc>().add(
        LoadMemories(userId: userId, orderType: MemoryOrderType.timeline),
      );
    }
  }

  Future<void> _loadMemoriesIfNeeded(int index, String userId) async {
    if (index != 0 && index != 1 && index != 2) return;

    final memoryBloc = context.read<MemoryBloc>();
    final completer = Completer<void>();
    final subscription = memoryBloc.stream.listen((state) {
      if (state is MemoriesLoaded) {
        completer.complete();
      }
    });

    dev.log("MemoryOrderType: ${_getMemoryOrderTypeFromIndex(index)}");

    memoryBloc.add(
      LoadMemories(
        userId: userId,
        orderType: _getMemoryOrderTypeFromIndex(index),
        month: memoryBloc.state.month,
        year: memoryBloc.state.year,
      ),
    );

    await completer.future;
    await subscription.cancel();
  }

  void _onDestinationSelected(int index) async {
    final userId = context.read<UserBloc>().state.user?.username;
    if (userId == null) return;

    await _loadMemoriesIfNeeded(index, userId);

    setState(() {
      _selectedIndex = index;
    });
  }

  PreferredSizeWidget? _getAppBarFromIndex(int index) {
    switch (index) {
      case 0:
        return const HomeAppBar(title: "Your Road");
      case 1:
        return const HomeAppBar(title: "Your Time");
      case 2:
        return StatisticsAppBar();
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      const FeedPage(key: PageStorageKey('feed')),
      const CalendarPage(key: PageStorageKey('calendar')),
      const StatisticsPage(key: PageStorageKey("statistics")),
    ];

    return Scaffold(
      extendBody: true,
      appBar: _getAppBarFromIndex(_selectedIndex),
      drawer: Drawer(
        child: Column(
          children: [
            SizedBox(height: AppSpacingConstants.xxl),
            ListTile(
              leading: Icon(
                Icons.person,
                size: 35,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
              title: Text(
                "iTunas",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                )
              ),
              subtitle: Text(
                "Go to your profile",
                style: TextStyle(
                  fontSize: 11,
                  color: Theme.of(context).colorScheme.onPrimaryContainer.withAlpha(150),
                ),
              ),
              onTap: () {
                GoRouter.of(context).push("/home/profile");
              },
            ),
            const Divider(
              height: 1,
              thickness: 1,
            ),
            ListTile(
              leading: Icon(
                Icons.looks,
                size: 32,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
              title: Text(
                "Appearance",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
              onTap: () {
              },
            ),
            ListTile(
              leading: Icon(
                Icons.settings,
                size: 32,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
              title: Text(
                "Settings",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
              onTap: () {
              },
            ),
          ],
        ),
      ),
      drawerDragStartBehavior: DragStartBehavior.start,
      body: IndexedStack(index: _selectedIndex, children: pages),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      floatingActionButton:
          _selectedIndex == 0 ? const AddMemoryActionButton() : null,
      bottomNavigationBar: NavigationBar(
        height: 68,
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onDestinationSelected,
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
  }
}
