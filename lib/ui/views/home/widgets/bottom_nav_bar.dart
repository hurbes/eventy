import 'package:flutter/material.dart';
import 'package:flutter_octicons/flutter_octicons.dart';
import 'package:eventy/ui/common/app_colors.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        canvasColor: ComponentColors.bottomNavBackground,
      ),
      child: BottomNavigationBar(
        iconSize: 32,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: ComponentColors.bottomNavActive,
        unselectedItemColor: ComponentColors.bottomNavInactive,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(OctIcons.home_16),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(OctIcons.calendar_16),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(OctIcons.heart_16),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(OctIcons.location_16),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(OctIcons.person_16),
            label: '',
          ),
        ],
      ),
    );
  }
}
