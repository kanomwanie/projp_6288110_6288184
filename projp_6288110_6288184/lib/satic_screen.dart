import 'package:flutter/material.dart';

class Statistic extends StatefulWidget {
  @override
  _BottomNavBar createState() => _BottomNavBar();
}
class _BottomNavBar extends State<Statistic> {
  int _selectedScreenIndex = 0;
  late final List<Widget> _screens = [
    Weekly(),
    Monthly(),
    Yearly(),
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

            height: 104,
            width: double.infinity,

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    NavBarIcon(
                      label: "Week",
                      labelOnActive: true,
                      darkMode: false,
                      active: (_selectedScreenIndex == 0),
                      onClick: () => _selectScreen(0),
                    ),
                    NavBarIcon(
                      label: "Month",
                      labelOnActive: true,
                      darkMode: false,
                      active: (_selectedScreenIndex == 1),
                      onClick: () => _selectScreen(1),
                    ),
                    NavBarIcon(
                      label: "Year",
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
  final String? label;
  final bool? labelOnActive;
  final bool darkMode;
  final bool active;
  final Function() onClick;

  const NavBarIcon({
    this.label,
    this.labelOnActive,
    required this.darkMode,
    required this.active,
    required this.onClick,
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
            height: 70,
            width: 130,
            alignment: Alignment.center,
            child:  Text(
              label!,
              style: TextStyle(
                fontSize: 30,
                letterSpacing: 0.5,
                color: _activeOpacity(),
                fontWeight: FontWeight.w700,

              ),
            ),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              color: active
                  ? const Color(0xffe8a2f4)
                  : const Color(0xffedc8f5),
            ),
          ),
        ],
      ),
    );
  }
}

class Weekly extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        SizedBox(
          height: 34,
        ),
        Text("week"),
      ],
    );
  }
}

class Monthly extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        SizedBox(
          height: 34,
        ),
        Text("month"),
      ],
    );
  }
}

class Yearly extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        SizedBox(
          height: 34,
        ),
        Text("year"),
      ],
    );
  }
}