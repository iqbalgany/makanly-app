import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:makanly/core/themes/colors.dart';
import 'package:makanly/presentations/pages/favorite_page.dart';
import 'package:makanly/presentations/pages/home_page.dart';

class AppMainPage extends StatefulWidget {
  const AppMainPage({super.key});

  @override
  State<AppMainPage> createState() => _AppMainPageState();
}

class _AppMainPageState extends State<AppMainPage> {
  int selectedIndex = 0;
  late final List<Widget> page;
  @override
  void initState() {
    super.initState();
    page = [
      const HomePage(),
      const FavoritePage(),
      navBarPage(Iconsax.calendar),
      navBarPage(Iconsax.setting),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: page[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconSize: 28,
        currentIndex: selectedIndex,
        selectedItemColor: kPrimaryColor,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: TextStyle(
          color: kPrimaryColor,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: TextStyle(
          color: kPrimaryColor,
          fontWeight: FontWeight.w500,
        ),
        onTap: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              selectedIndex == 0 ? Iconsax.home_1 : Iconsax.home_1_copy,
            ),
            label: 'Home',
          ),

          BottomNavigationBarItem(
            icon: Icon(selectedIndex == 1 ? Iconsax.heart : Iconsax.heart_copy),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              selectedIndex == 2 ? Iconsax.calendar : Iconsax.calendar_copy,
            ),
            label: 'Meal Plan',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              selectedIndex == 3 ? Iconsax.setting : Iconsax.setting_copy,
            ),
            label: 'Settings',
          ),
        ],
      ),
    );
  }

  Widget navBarPage(IconData iconName) {
    return Center(child: Icon(iconName, size: 100, color: kPrimaryColor));
  }
}
