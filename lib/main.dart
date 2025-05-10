import 'package:flutter/material.dart' as material;
import 'package:google_fonts/google_fonts.dart';
import 'screens/home_tab.dart';
import 'screens/find_tab.dart' as find;
import 'screens/jobs_tab.dart' as jobs;
import 'screens/contacts_tab.dart';
import 'screens/supplies_tab.dart';
import 'constants/colors.dart';
import 'components/index.dart';

void main() {
  material.runApp(const JobeeApp());
}

class JobeeApp extends material.StatelessWidget {
  const JobeeApp({super.key});

  @override
  material.Widget build(material.BuildContext context) {
    return material.MaterialApp(
      title: 'Jobee',
      theme: material.ThemeData(
        primarySwatch: material.Colors.blue,
        scaffoldBackgroundColor: AppColors.white,
        bottomNavigationBarTheme: const material.BottomNavigationBarThemeData(
          backgroundColor: AppColors.white,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.grey400,
        ),
        textTheme: GoogleFonts.urbanistTextTheme(
          material.Theme.of(context).textTheme.copyWith(
            headlineLarge: GoogleFonts.urbanist(
              fontSize: 48,
              fontWeight: material.FontWeight.w700,
              color: AppColors.black,
            ),
            headlineMedium: GoogleFonts.urbanist(
              fontSize: 40,
              fontWeight: material.FontWeight.w700,
              color: AppColors.black,
            ),
            headlineSmall: GoogleFonts.urbanist(
              fontSize: 32,
              fontWeight: material.FontWeight.w700,
              color: AppColors.black,
            ),
            titleLarge: GoogleFonts.urbanist(
              fontSize: 24,
              fontWeight: material.FontWeight.w700,
              color: AppColors.black,
            ),
            titleMedium: GoogleFonts.urbanist(
              fontSize: 20,
              fontWeight: material.FontWeight.w700,
              color: AppColors.black,
            ),
            titleSmall: GoogleFonts.urbanist(
              fontSize: 18,
              fontWeight: material.FontWeight.w700,
              color: AppColors.black,
            ),
            bodyLarge: GoogleFonts.urbanist(
              fontSize: 18,
              fontWeight: material.FontWeight.w500,
              color: AppColors.grey500,
            ),
            bodyMedium: GoogleFonts.urbanist(
              fontSize: 16,
              fontWeight: material.FontWeight.w500,
              color: AppColors.grey500,
            ),
            bodySmall: GoogleFonts.urbanist(
              fontSize: 14,
              fontWeight: material.FontWeight.w500,
              color: AppColors.grey500,
            ),
            labelLarge: GoogleFonts.urbanist(
              fontSize: 12,
              fontWeight: material.FontWeight.w500,
              color: AppColors.grey500,
            ),
            labelSmall: GoogleFonts.urbanist(
              fontSize: 10,
              fontWeight: material.FontWeight.w500,
              color: AppColors.grey500,
            ),
          ),
        ),
      ),
      home: const JobeeHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class JobeeHomePage extends material.StatefulWidget {
  const JobeeHomePage({super.key});

  @override
  material.State<JobeeHomePage> createState() => _JobeeHomePageState();
}

class _JobeeHomePageState extends material.State<JobeeHomePage> {
  int _selectedIndex = 0;
  material.ThemeMode _themeMode = material.ThemeMode.light;

  // Unique GlobalKeys for each tab's Navigator
  final _homeNavigatorKey = material.GlobalKey<material.NavigatorState>(
    debugLabel: 'HomeNavigator',
  );
  final _findNavigatorKey = material.GlobalKey<material.NavigatorState>(
    debugLabel: 'FindNavigator',
  );
  final _jobsNavigatorKey = material.GlobalKey<material.NavigatorState>(
    debugLabel: 'JobsNavigator',
  );
  final _contactsNavigatorKey = material.GlobalKey<material.NavigatorState>(
    debugLabel: 'ContactsNavigator',
  );
  final _suppliesNavigatorKey = material.GlobalKey<material.NavigatorState>(
    debugLabel: 'SuppliesNavigator',
  );

  static const List<String> _tabTitles = [
    'Home',
    'Find',
    'Jobs',
    'Network',
    'Supplies',
  ];
  static const List<String> _iconNames = [
    'home',
    'search',
    'work',
    '3 user',
    'buy',
  ];

  void _onItemTapped(int index) {
    print('Navigating to tab: ${_tabTitles[index]}, index: $index');
    setState(() {
      _selectedIndex = index;
    });
  }

  void _toggleThemeMode() {
    setState(() {
      _themeMode =
          _themeMode == material.ThemeMode.light
              ? material.ThemeMode.dark
              : material.ThemeMode.light;
    });
  }

  @override
  material.Widget build(material.BuildContext context) {
    final List<material.Widget> navigators = [
      material.Navigator(
        key: _homeNavigatorKey,
        onGenerateRoute: (settings) {
          print('Generating route: Home');
          return material.MaterialPageRoute(
            builder: (_) => HomeTab(themeMode: _themeMode),
          );
        },
      ),
      material.Navigator(
        key: _findNavigatorKey,
        onGenerateRoute: (settings) {
          print('Generating route: Find');
          return material.MaterialPageRoute(
            builder: (_) => find.FindTab(themeMode: _themeMode),
          );
        },
      ),
      material.Navigator(
        key: _jobsNavigatorKey,
        onGenerateRoute: (settings) {
          print('Generating route: Jobs');
          return material.MaterialPageRoute(
            builder: (_) => jobs.JobsTab(themeMode: _themeMode),
          );
        },
      ),
      material.Navigator(
        key: _contactsNavigatorKey,
        onGenerateRoute: (settings) {
          print('Generating route: Network');
          return material.MaterialPageRoute(
            builder: (_) => ContactsTab(themeMode: _themeMode),
          );
        },
      ),
      material.Navigator(
        key: _suppliesNavigatorKey,
        onGenerateRoute: (settings) {
          print('Generating route: Supplies');
          return material.MaterialPageRoute(
            builder: (_) => SuppliesTab(themeMode: _themeMode),
          );
        },
      ),
    ];

    return material.Scaffold(
      backgroundColor:
          _themeMode == material.ThemeMode.light
              ? AppColors.white
              : AppColors.dark3,
      body: material.Column(
        children: [
          material.AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (child, animation) {
              return material.FadeTransition(opacity: animation, child: child);
            },
            child:
                _selectedIndex == 0
                    ? AppTopBar(
                      key: material.ValueKey(_themeMode),
                      variant: TopBarVariant.homePageNavBar,
                      themeMode: _themeMode,
                      onModeToggle: _toggleThemeMode,
                      title: 'Jobee',
                    )
                    : const material.SizedBox.shrink(),
          ),
          material.Expanded(
            child: material.IndexedStack(
              index: _selectedIndex,
              children: navigators,
            ),
          ),
        ],
      ),
      bottomNavigationBar: material.AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (child, animation) {
          return material.FadeTransition(opacity: animation, child: child);
        },
        child: material.BottomNavigationBar(
          key: material.ValueKey(_themeMode),
          type: material.BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          backgroundColor:
              _themeMode == material.ThemeMode.light
                  ? AppColors.white
                  : AppColors.dark3,
          selectedLabelStyle: GoogleFonts.urbanist(
            fontWeight: material.FontWeight.w500,
            fontSize: 12,
          ),
          unselectedLabelStyle: GoogleFonts.urbanist(
            fontWeight: material.FontWeight.w300,
            fontSize: 12,
          ),
          items: List.generate(
            _tabTitles.length,
            (index) => material.BottomNavigationBarItem(
              icon: NavIcon(
                iconName: _iconNames[index],
                isActive: _selectedIndex == index,
              ),
              label: _tabTitles[index],
            ),
          ),
        ),
      ),
    );
  }
}
