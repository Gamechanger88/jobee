import 'package:flutter/material.dart' as material;
import 'package:google_fonts/google_fonts.dart';

// Import tab pages from screens directory
import 'screens/home_tab.dart';
import 'screens/find_tab.dart';
import 'screens/jobs_tab.dart';
import 'screens/contacts_tab.dart';
import 'screens/profile_tab.dart';

// Import colors from constants directory
import 'constants/colors.dart';

// Import components using barrel file
import 'components/index.dart';

void main() {
  material.runApp(const JobeeApp());
}

// Main app widget
class JobeeApp extends material.StatelessWidget {
  const JobeeApp({super.key});

  @override
  material.Widget build(material.BuildContext context) {
    return material.MaterialApp(
      title: 'Jobee',
      theme: material.ThemeData(
        primarySwatch: material.Colors.blue,
        scaffoldBackgroundColor: AppColors.white, // Default to Light mode
        bottomNavigationBarTheme: const material.BottomNavigationBarThemeData(
          backgroundColor: AppColors.white,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.grey400,
        ),
        textTheme: GoogleFonts.urbanistTextTheme(
          material.Theme.of(context).textTheme.copyWith(
            // Headings
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
            // Body
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

// Homepage widget with bottom navigation
class JobeeHomePage extends material.StatefulWidget {
  const JobeeHomePage({super.key});

  @override
  material.State<JobeeHomePage> createState() => _JobeeHomePageState();
}

class _JobeeHomePageState extends material.State<JobeeHomePage> {
  int _selectedIndex = 0; // For BottomNavigationBar
  final material.GlobalKey<material.NavigatorState> _navigatorKey =
      material.GlobalKey<material.NavigatorState>();
  material.ThemeMode _themeMode =
      material.ThemeMode.light; // Toggle between Light and Dark

  // List of screens for bottom navigation
  static const List<String> _tabTitles = [
    'Home',
    'Find',
    'Jobs',
    'Contacts',
    'Profile',
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _navigatorKey.currentState?.pushReplacementNamed(_tabTitles[index]);
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
  void initState() {
    super.initState();
    // Ensure an initial route is pushed when the widget is first built
    material.WidgetsBinding.instance.addPostFrameCallback((_) {
      _navigatorKey.currentState?.pushReplacementNamed(
        _tabTitles[_selectedIndex],
      );
    });
  }

  @override
  material.Widget build(material.BuildContext context) {
    return material.AnimatedSwitcher(
      duration: const Duration(milliseconds: 300), // Smooth transition duration
      transitionBuilder: (child, animation) {
        return material.FadeTransition(opacity: animation, child: child);
      },
      child: material.Scaffold(
        key: material.ValueKey(_themeMode), // Key to trigger transition
        backgroundColor:
            _themeMode == material.ThemeMode.light
                ? AppColors.white
                : AppColors.grey900, // App-wide background
        body: material.Column(
          children: [
            AppTopBar(
              variant: TopBarVariant.homePageNavBar,
              themeMode: _themeMode,
              onModeToggle: _toggleThemeMode,
              title: 'Jobee',
            ),
            material.Expanded(
              child: material.Navigator(
                key: _navigatorKey,
                initialRoute: _tabTitles[0],
                onGenerateRoute: (settings) {
                  material.Widget page;
                  switch (settings.name) {
                    case 'Home':
                      page = HomeTab(themeMode: _themeMode);
                      break;
                    case 'Find':
                      page = FindTab(themeMode: _themeMode);
                      break;
                    case 'Jobs':
                      page = JobsTab(themeMode: _themeMode);
                      break;
                    case 'Contacts':
                      page = ContactsTab(themeMode: _themeMode);
                      break;
                    case 'Profile':
                      page = ProfileTab(themeMode: _themeMode);
                      break;
                    default:
                      page = HomeTab(themeMode: _themeMode);
                  }
                  return material.MaterialPageRoute(
                    builder: (_) => page,
                    settings: settings,
                  );
                },
              ),
            ),
          ],
        ),
        bottomNavigationBar: material.BottomNavigationBar(
          type: material.BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          backgroundColor:
              _themeMode == material.ThemeMode.light
                  ? AppColors.white
                  : AppColors.grey900,
          items: const [
            material.BottomNavigationBarItem(
              icon: material.Icon(material.Icons.home),
              label: 'Home',
            ),
            material.BottomNavigationBarItem(
              icon: material.Icon(material.Icons.search),
              label: 'Find',
            ),
            material.BottomNavigationBarItem(
              icon: material.Icon(material.Icons.work),
              label: 'Jobs',
            ),
            material.BottomNavigationBarItem(
              icon: material.Icon(material.Icons.contacts),
              label: 'Contacts',
            ),
            material.BottomNavigationBarItem(
              icon: material.Icon(material.Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
