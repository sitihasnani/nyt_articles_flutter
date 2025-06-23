import 'package:articlelistapp/screens/article_list_screen.dart';
import 'package:articlelistapp/screens/component/build_nav_bar_item';
import 'package:articlelistapp/services/article_service.dart';
import 'package:articlelistapp/viewmodels/article_viewmodel.dart';
import 'package:flutter/material.dart';

void main() {
  const apiKey = 'rPYnykeA0EZ1kSNZ7fWg5cYOHk3lIRGm';
  final service = ArticleService(apiKey);
  final viewModel = ArticleViewmodel(service);

  runApp(MyApp(viewmodel: viewModel));
}

class MyApp extends StatelessWidget {
  final ArticleViewmodel viewmodel;

  const MyApp({super.key, required this.viewmodel});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NYT Articles',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: MainScreen(viewModel: viewmodel,),
    );
  }
}

class MainScreen extends StatefulWidget {
  final ArticleViewmodel viewModel;

  const MainScreen({super.key, required this.viewModel});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  late List<Widget> _screens;

  @override
  void initState() {
    super.initState();

    _screens = [
      ArticleListScreen(articleViewmodel: widget.viewModel),
      Center(child: Text('Bookmarks')),
      Center(child: Text('Search')),
      Center(child: Text('Profile')),
    ];
  }


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<BottomNavigationBarItem> _items = [
    buildNavItem(icon: Icons.article_outlined, label: 'News'),
    buildNavItem(icon: Icons.bookmark_outline, label: 'Saved'), 
    buildNavItem(icon: Icons.search, label: 'Search'),
    buildNavItem(icon: Icons.person_outline, label: 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, -2)),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: _items,
          selectedItemColor: Colors.indigo,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
        ),
      ),
    ),

    );
  }
}


