import 'package:flutter/material.dart';
import 'package:tugas_mobile/screen/profile.dart';
import 'package:tugas_mobile/views/atlet_list_screen.dart'; // Import AtletListScreen
import 'package:tugas_mobile/views/cabang_olahraga_list_screen.dart'; // Import CabangOlahragaListScreen
import 'package:tugas_mobile/views/pelatih_list_screen.dart'; // Import PelatihListScreen
import 'package:tugas_mobile/widgets/gradient_app_bar.dart'; // Import GradientAppBar
import 'dashboard_content.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    DashboardContent(),
    CabangOlahragaListScreen(),
    PelatihListScreen(),
    AtletListScreen(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FA),
      appBar: GradientAppBar(title: "Dashboard"), // Use GradientAppBar

      /// Smooth page switching (lebih halus dari IndexedStack biasa)
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: _pages[_selectedIndex],
      ),

      /// Bottom Navigation modern (Material 3)
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        height: 70,
        backgroundColor: Colors.white,
        indicatorColor: Colors.teal.withOpacity(0.15),
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        animationDuration: const Duration(milliseconds: 400),
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard_outlined),
            selectedIcon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          NavigationDestination(
            icon: Icon(Icons.fitness_center_outlined),
            selectedIcon: Icon(Icons.fitness_center),
            label: 'Cabang',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Pelatih',
          ),
          NavigationDestination(
            icon: Icon(Icons.groups_outlined),
            selectedIcon: Icon(Icons.groups),
            label: 'Atlet',
          ),
          NavigationDestination(
            icon: Icon(Icons.account_circle_outlined),
            selectedIcon: Icon(Icons.account_circle),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}
