import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'pages/home/home_page.dart';
import 'pages/mall/mall_page.dart';
import 'pages/discover/discover_page.dart';
import 'pages/inbox/inbox_page.dart';
import 'pages/account/account_page.dart';
import 'navigation/selected_index_notifier.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flower Shop App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
        textTheme: GoogleFonts.robotoTextTheme(),
      ),
      home: const TabNavigationPage(),
    );
  }
}

class TabNavigationPage extends StatefulWidget {
  const TabNavigationPage({super.key});

  @override
  State<TabNavigationPage> createState() => _TabNavigationPageState();
}

class _TabNavigationPageState extends State<TabNavigationPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const MallPage(),
    const DiscoverPage(),
    const InboxPage(),
    const AccountPage(),
  ];

  @override
  void initState() {
    // Listen to external changes to selectedIndexNotifier
    selectedIndexNotifier.addListener(() {
      setState(() {
        _currentIndex = selectedIndexNotifier.value;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    selectedIndexNotifier.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: ValueListenableBuilder<int>(
        valueListenable: selectedIndexNotifier,
        builder: (context, value, child) {
          return BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: value,
            onTap: (index) {
              selectedIndexNotifier.value = index;
            },
            selectedItemColor: Color(0xFF244B3A),
            unselectedItemColor: Colors.grey,
            items: [
              BottomNavigationBarItem(
                icon: Image.asset(
                  _currentIndex == 0
                      ? 'assets/images/nav_icon_home_green.png'
                      : 'assets/images/nav_icon_home.png',
                  width: 24,
                  height: 24,
                ),
                label: 'Home'.toUpperCase(),
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  _currentIndex == 1
                      ? 'assets/images/nav_icon_mall_green.png'
                      : 'assets/images/nav_icon_mall.png',
                  width: 24,
                  height: 24,
                ),
                label: 'Mall'.toUpperCase(),
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/images/nav_icon_discover.png',
                  width: 24,
                  height: 24,
                ),
                label: 'Discover'.toUpperCase(),
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/images/nav_icon_inbox.png',
                  width: 24,
                  height: 24,
                ),
                label: 'Inbox'.toUpperCase(),
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/images/nav_icon_account.png',
                  width: 24,
                  height: 24,
                ),
                label: 'Account'.toUpperCase(),
              ),
            ],
          );
        },
      ),
    );
  }
}
