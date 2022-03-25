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
      children: [
        const SizedBox(
          height: 34,
        ),
        const Text("This week statistic",   style:TextStyle(
          fontSize: 30,
          color: Colors.deepPurple,
        ),),
        Row( mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Container( width: 20,
            height: 20,
          color: Colors.green,),
          const Text("  Taken   ",style: TextStyle( fontSize: 20, color: Colors.deepPurple,)),
          Container( width: 20,
            height: 20,
            color: Colors.red,),
          const Text("  Not Taken",style: TextStyle( fontSize: 20, color: Colors.deepPurple,)),
        ],),
        const SizedBox(
          height: 20,
        ),
        weekl(),

      ],
    );
  }
}

class weekl extends StatelessWidget {
  //const weekl ({Key? key,}) : super(key: key);
List<String> A = [
  'Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday'
];
  @override
  Widget build(BuildContext context) {
    return Column(  children: <Widget>[
      SizedBox(
        height: 420,  //        <-- Use Expanded
        child: ListView.builder(
          itemCount: A.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(A[index],style: const TextStyle(color:Colors.deepPurple, fontWeight: FontWeight.bold,fontSize: 25),),
              subtitle: Container(height: 100,
                decoration: const BoxDecoration(
                    color:Color(0xffededed),
                    borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                child: weekdl(),
                ),
            );
          },
        ),
      ),

    ],
    );
  }
}

class weekdl extends StatelessWidget {
  //const weekl ({Key? key,}) : super(key: key);
  List<String> A = [
    'Monday','T','w','th','f','st','s'
  ];
  @override
  Widget build(BuildContext context) {
    return
      Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        height: 20,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: A.length, itemBuilder: (context, index) {
          return Container(
            width: 150,
            child: Card(
              color: Colors.blue,
              child: Container(
                child: Center(child: Text(A[index], style: TextStyle(color: Colors.white, fontSize: 20),)),
              ),
            ),
          );
        }),
      );
  }
}

class Monthly extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 34,
        ),
        const Text("This month statistic",   style:TextStyle(
          fontSize: 30,
          color: Colors.deepPurple,
        ),),
        Row( mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container( width: 20,
              height: 20,
              color: Colors.green,),
            const Text("  Taken   ",style: TextStyle( fontSize: 20, color: Colors.deepPurple,)),
            Container( width: 20,
              height: 20,
              color: Colors.amber,),
            const Text("  Some Taken   ",style: TextStyle( fontSize: 20, color: Colors.deepPurple,)),
            Container( width: 20,
              height: 20,
              color: Colors.red,),
            const Text("  Not Taken",style: TextStyle( fontSize: 20, color: Colors.deepPurple,)),
          ],),
        const SizedBox(
          height: 20,
        ),
        monthl(),
        const SizedBox(
          height: 20,
        ),
        const Text("For some taken, tap on the medicine name to see the day you miss in that week.",style: TextStyle( fontSize: 15, color: Colors.deepPurple,)),

      ],
    );
  }
}

class monthl extends StatelessWidget {
  //const weekl ({Key? key,}) : super(key: key);
  List<String> A = [
    'Week 1','Week 2','Week ','Week 4'
  ];
  @override
  Widget build(BuildContext context) {
    return Column(  children: <Widget>[
      SizedBox(
        height: 470,  //        <-- Use Expanded
        child: ListView.builder(
          itemCount: A.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(A[index],style: const TextStyle(color:Colors.deepPurple, fontWeight: FontWeight.bold,fontSize: 25),),
              subtitle: Container(height: 100,
                decoration: const BoxDecoration(
                    color:Color(0xffededed),
                    borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                child: monthdl(),
              ),
            );
          },
        ),
      ),

    ],
    );
  }
}

class monthdl extends StatelessWidget {
  //const weekl ({Key? key,}) : super(key: key);
  List<String> A = [
    'Monday','T','w','th','f','st','s'
  ];
  @override
  Widget build(BuildContext context) {
    return
      Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        height: 20,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: A.length, itemBuilder: (context, index) {
          return Container(
            width: 150,
            child: Card(
              color: Colors.blue,
              child: Container(
                child: Center(child: Text(A[index], style: TextStyle(color: Colors.white, fontSize: 20),)),
              ),
            ),
          );
        }),
      );
  }
}

class Yearly extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 34,
        ),
        const Text("This Year statistic",   style:TextStyle(
          fontSize: 30,
          color: Colors.deepPurple,
        ),),
        Row( mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container( width: 20,
              height: 20,
              color: Colors.green,),
            const Text("  Taken   ",style: TextStyle( fontSize: 20, color: Colors.deepPurple,)),
            Container( width: 20,
              height: 20,
              color: Colors.amber,),
            const Text("  Some Taken   ",style: TextStyle( fontSize: 20, color: Colors.deepPurple,)),
            Container( width: 20,
              height: 20,
              color: Colors.red,),
            const Text("  Not Taken",style: TextStyle( fontSize: 20, color: Colors.deepPurple,)),
          ],),
        const SizedBox(
          height: 20,
        ),
        yearl(),
        const SizedBox(
          height: 20,
        ),
        const Text("For some taken, tap on the medicine name to see the day you miss in that month.",style: TextStyle( fontSize: 15, color: Colors.deepPurple,)),
      ],
    );
  }
}

class yearl extends StatelessWidget {
  //const weekl ({Key? key,}) : super(key: key);
  List<String> A = [
    'January','February','March','April','May','June','July','August','September','October','November','December'
  ];
  @override
  Widget build(BuildContext context) {
    return Column(  children: <Widget>[
      SizedBox(
        height: 470,  //        <-- Use Expanded
        child: ListView.builder(
          itemCount: A.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(A[index],style: const TextStyle(color:Colors.deepPurple, fontWeight: FontWeight.bold,fontSize: 25),),
              subtitle: Container(height: 100,
                decoration: const BoxDecoration(
                    color:Color(0xffededed),
                    borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                child: yeardl(),
              ),
            );
          },
        ),
      ),

    ],
    );
  }
}

class yeardl extends StatelessWidget {
  //const weekl ({Key? key,}) : super(key: key);
  List<String> A = [
    'Monday','T','w','th','f','st','s'
  ];
  @override
  Widget build(BuildContext context) {
    return
      Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        height: 20,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: A.length, itemBuilder: (context, index) {
          return Container(
            width: 150,
            child: Card(
              color: Colors.blue,
              child: Container(
                child: Center(child: Text(A[index], style: TextStyle(color: Colors.white, fontSize: 20),)),
              ),
            ),
          );
        }),
      );
  }
}