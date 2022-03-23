// @dart=2.9
import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'check_screen.dart';
import 'user_screen.dart';
import 'friend_screen.dart';
import 'meddata_screen.dart';
import 'satic_screen.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Named Route Demo',
      theme: ThemeData(primarySwatch: Colors.purple),
      //TODO 1:  Update Route Table HERE
      initialRoute:'/',
      routes:{
        '/':(context)=>login(),
      '/sign':(context)=> SignUpPage(),
        '/ufc':(context)=>BottomNavBar(),
      '/stat':(context)=>Statistic(),
        '/med':(context)=> Meddata(),
      },


    );
  }
}

class BottomNavBar extends StatefulWidget {

  @override
  _BottomNavBar createState() => _BottomNavBar();
}
class _BottomNavBar extends State<BottomNavBar> {
  int _selectedScreenIndex = 0;
  final List<Widget> _screens = [
     UUser(),
    Medcheck(),
     Friend(),
  ];

  _selectScreen(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dailymeds',  style: TextStyle(fontSize: 30),),
        automaticallyImplyLeading: false,
        centerTitle: true,

      ),
      body: Column(
        children: [
          Flexible(
            fit: FlexFit.tight,
            child: SingleChildScrollView(
              child: _screens[_selectedScreenIndex],
            ),
          ),
          Container(

            height: 74,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.05),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    NavBarIcon(
                      icon: Icons.person,
                      inactiveIcon: Icons.person_outline,
                      label: "User",
                      labelOnActive: true,
                      darkMode: false,
                      active: (_selectedScreenIndex == 0),
                      onClick: () => _selectScreen(0),
                    ),
                    NavBarIcon(
                      icon: Icons.medical_services,
                      inactiveIcon: Icons.medical_services_outlined,
                      label: "Med Check",
                      labelOnActive: true,
                      darkMode: false,
                      active: (_selectedScreenIndex == 1),
                      onClick: () => _selectScreen(1),
                    ),
                    NavBarIcon(
                      icon: Icons.people,
                      inactiveIcon: Icons.people_outline,
                      label: "Friend",
                      labelOnActive: true,
                      darkMode: false,
                      active: (_selectedScreenIndex == 2),
                      onClick: () => _selectScreen(2),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class NavBarIcon extends StatelessWidget {
  final IconData icon;
  final IconData inactiveIcon;
  final String label;
  final bool labelOnActive;
  final bool darkMode;
  final bool active;
  final Function() onClick;

  const NavBarIcon({
  this.icon,
    this.label,
    this.labelOnActive,
    this.darkMode,
    this.active,
    this.inactiveIcon,
    this.onClick,
  });

  Color _activeOpacity() {
    Color color;
    if (active) {
      color = darkMode ? Colors.white : Colors.black;
    } else {
      color = darkMode ? Colors.white54 : Colors.black54;
    }
    return color;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Column(
        children: [
          Container(
            height: 32,
            width: 64,
            child: Icon(
              active ? icon : inactiveIcon,
              size: 24,
              color: _activeOpacity(),
            ),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(16)),
              color: active
                  ? Theme.of(context).colorScheme.primary.withOpacity(0.2)
                  : Colors.transparent,
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          if (label != null)
            if (labelOnActive == null ||
                (labelOnActive == true && active == true))
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  letterSpacing: 0.5,
                  color: _activeOpacity(),
                  fontWeight: FontWeight.w700,
                ),
              ),
        ],
      ),
    );
  }
}