import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roadsyouwalked_app/bloc/memory/memory_bloc.dart';
import 'package:roadsyouwalked_app/bloc/user/user_bloc.dart';
import 'package:roadsyouwalked_app/model/memory/memory_order_type.dart';
import 'package:roadsyouwalked_app/ui/components/home/add_memory_action_button.dart';
import 'package:roadsyouwalked_app/ui/components/home/home_app_bar.dart';
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
    2: MemoryOrderType.lastNDays
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
        LoadMemories(
          userId: userId,
          orderType: MemoryOrderType.timeline,
        ),
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

    memoryBloc.add(LoadMemories(
      userId: userId,
      orderType: _getMemoryOrderTypeFromIndex(index), // Qui mi si resetta ogni volta 
      month: memoryBloc.state.month,
      year: memoryBloc.state.year,
    ));

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

  @override
  Widget build(BuildContext context) {
    final userId = context.read<UserBloc>().state.user?.username;

    final List<Widget> pages = [
      const FeedPage(key: PageStorageKey('feed')),
      BlocBuilder<MemoryBloc, MemoryState>(
        builder: (context, state) {
          return CalendarPage(
            key: const PageStorageKey('calendar'),
            memories: state.memories,
            month: state.month,
            year: state.year,
            onPrevPressed: () {
              if (userId != null) {
                context.read<MemoryBloc>().add(SetTime(
                  userId: userId,
                  month: state.month - 1,
                ));
              }
            },
            onNextPressed: () {
              if (userId != null) {
                context.read<MemoryBloc>().add(SetTime(
                  userId: userId,
                  month: state.month + 1,
                ));
              }
            },
          );
        },
      ),
      StatisticsPage(
        key: const PageStorageKey("statistics")
      ),
    ];

    return Scaffold(
      appBar: _selectedIndex == 0 ? const HomeAppBar() : null,
      body: IndexedStack(
        index: _selectedIndex,
        children: pages,
      ),
      floatingActionButton: _selectedIndex == 0 ? const AddMemoryActionButton() : null,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onDestinationSelected,
        destinations: const [
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
