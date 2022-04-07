import 'package:flutter/material.dart';
import 'server.dart';
import 'stat_data.dart' as sdata;
import 'med_data.dart' as mdata;

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
        title: const Text('Dailymeds', style: TextStyle(fontSize: 30),),
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
            child: Text(
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
          height: 20,
        ),
        const Text("This week statistic", style: TextStyle(
          fontSize: 30,
          color: Colors.deepPurple,
        ),),
        const SizedBox(
          height: 10,
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(width: 20,
              height: 20,
              color: Colors.green,),
            const Text("  Taken   ",
                style: TextStyle(fontSize: 20, color: Colors.deepPurple,)),
            Container(width: 20,
              height: 20,
              color: Colors.red,),
            const Text("  Not Taken   ",
                style: TextStyle(fontSize: 20, color: Colors.deepPurple,)),
            Container(width: 20,
                height: 20,
                color: const Color(0xff999999)),
            const Text("  N/A",
                style: TextStyle(fontSize: 20, color: Colors.deepPurple,)),
          ],),
        const SizedBox(
          height: 20,
        ),
        weekl(),

      ],
    );
  }
}

class weekl extends StatefulWidget {
  weekl({Key? key}) : super(key: key);
  final server api = server();

  @override
  weekls createState() => weekls();
}


class weekls extends State<weekl> {
  //const weekl ({Key? key,}) : super(key: key);
  List<String> A = [
    'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'
  ];
  List<med> allm = [];
  List<usermed> um = [];
  List<stat> st = [];

  @override
  void initState() {
    super.initState();
    _loadallmed();
    _loadusermed();
    _loadstat();
  }

  void _loadallmed() {
    widget.api.getall('med').then((A) {
      setState(() {
        allm = A;
      });
    });
  }

  void _loadusermed() {
    widget.api.getall('usermed').then((A) {
      setState(() {
        um = A;
      });
    });
  }

  void _loadstat() {
    widget.api.getall('stat').then((A) {
      setState(() {
        st = A;
      });
    });
  }

  List<DateTime> B = sdata.Dweekly(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      SizedBox(
        height: 420, //        <-- Use Expanded
        child: ListView.builder(
          itemCount: A.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: RichText(
                text: TextSpan(
                  // Note: Styles for TextSpans must be explicitly defined.
                  // Child text spans will inherit styles from parent
                  style: const TextStyle(
                  ),
                  children: <TextSpan>[
                    TextSpan(text: A[index] + '  ',
                      style: const TextStyle(color: Colors.deepPurple,
                          fontWeight: FontWeight.bold,
                          fontSize: 25),),
                    TextSpan(text: B[index].day.toString() + ' ' +
                        sdata.getmonth(B[index].month) + ' ' +
                        B[index].year.toString(),
                        style: const TextStyle(
                            color: Colors.grey, fontSize: 15)),
                  ],
                ),
              ),
              subtitle: Container(height: 100,
                decoration: const BoxDecoration(
                    color: Color(0xffededed),
                    borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                child: weekdl(
                  date: B[index], my: mdata.getumed(allm, um), allst: st,),
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
  const weekdl(
      {required this.date, required this.my, required this.allst, Key? key})
      : super(key: key);
  final DateTime date;
  final List<med> my;
  final List<stat> allst;

  @override
  Widget build(BuildContext context) {
    return
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        height: 20,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: my.length, itemBuilder: (context, index) {
          return SizedBox(
              width: 150,
              child: (DateTime.now().isBefore(date)) ?  Card(
                color: const Color(0xff999999),
                child: Center(child: Text(my[index].name,
                  style: const TextStyle(color: Colors.white, fontSize: 20),)),
              ) : Card(
          color: (sdata.checktakew(date, allst, my[index].
              id)) ?Colors.green :Colors.red,
          child: Center(child: Text(my[index].name, style: const TextStyle(color: Colors.white, fontSize: 20),)
          )
          ,
          )
          ,
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
          height: 20,
        ),
        const Text("This month statistic", style: TextStyle(
          fontSize: 30,
          color: Colors.deepPurple,
        ),),
        const SizedBox(
          height: 10,
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(width: 20,
              height: 20,
              color: Colors.green,),
            const Text(" Taken ",
                style: TextStyle(fontSize: 20, color: Colors.deepPurple,)),
            Container(width: 20,
              height: 20,
              color: Colors.amber,),
            const Text(" SomeTaken ",
                style: TextStyle(fontSize: 20, color: Colors.deepPurple,)),
            Container(width: 20,
              height: 20,
              color: Colors.red,),
            const Text(" NotTaken ",
                style: TextStyle(fontSize: 20, color: Colors.deepPurple,)),
            Container(width: 20,
                height: 20,
                color: const Color(0xff999999)),
            const Text(" N/A",
                style: TextStyle(fontSize: 20, color: Colors.deepPurple,)),
          ],),

        const SizedBox(
          height: 20,
        ),
        monthl(),
        const SizedBox(
          height: 15,
        ),
        const Text(
            "*For some taken, tap on the medicine name to see the day you miss in that week.*",
            style: TextStyle(fontSize: 11, color: Colors.deepPurple,),
            textAlign: TextAlign.center),
        const SizedBox(
          height: 5,
        ),
        const Text(
            "*Please wait for week to complete to see the statistic*",
            style: TextStyle(fontSize: 15, color: Colors.deepPurple,),
            textAlign: TextAlign.center),
      ],
    );
  }
}

class monthl extends StatefulWidget {
  monthl({Key? key}) : super(key: key);
  final server api = server();

  @override
  monthls createState() => monthls();
}


class monthls extends State<monthl> {
  //const weekl ({Key? key,}) : super(key: key);
  List <List<DateTime>> B = sdata.Dmonthly(DateTime.now());
  List<med> allm = [];
  List<usermed> um = [];
  List<stat> st = [];

  @override
  void initState() {
    super.initState();
    _loadallmed();
    _loadusermed();
    _loadstat();
  }

  void _loadallmed() {
    widget.api.getall('med').then((A) {
      setState(() {
        allm = A;
      });
    });
  }

  void _loadusermed() {
    widget.api.getall('usermed').then((A) {
      setState(() {
        um = A;
      });
    });
  }

  void _loadstat() {
    widget.api.getall('stat').then((A) {
      setState(() {
        st = A;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    List<String> A = sdata.getweeklist(B.length);
    return Column(children: <Widget>[
      SizedBox(
        height: 370, //        <-- Use Expanded
        child: ListView.builder(
          itemCount: A.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: RichText(
                text: TextSpan(
                  // Note: Styles for TextSpans must be explicitly defined.
                  // Child text spans will inherit styles from parent
                  style: const TextStyle(
                  ),
                  children: <TextSpan>[
                    TextSpan(text: A[index] + '  ',
                      style: const TextStyle(color: Colors.deepPurple,
                          fontWeight: FontWeight.bold,
                          fontSize: 25),),
                    TextSpan(text: sdata.printmonth(B[index]),
                        style: const TextStyle(
                            color: Colors.grey, fontSize: 15)),
                  ],
                ),
              ),
              subtitle: Container(height: 100,
                decoration: const BoxDecoration(
                    color: Color(0xffededed),
                    borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                child: monthdl( date: B[index], my: mdata.getumed(allm, um), allst: st,),
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
const monthdl ( {required this.date, required this.my, required this.allst, Key? key})
    : super(key: key);
final List<DateTime> date;
final List<med> my;
final List<stat> allst;


  @override
  Widget build(BuildContext context) {
    return
      Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        height: 20,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount:my.length, itemBuilder: (context, index) {
          return Container(
            width: 150,
            child:(DateTime.now().isBefore(date[date.length-1])) ?Card(
              color: const Color(0xff999999),
              child: Container(
                child: Center(child: Text(my[index].name,
                  style: const TextStyle(color: Colors.white, fontSize: 20),)),
              )
            ): (sdata.Checktake(date, allst, my[index].id)[0] == 'S')?
            GestureDetector( onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) =>
                    _buildPopupDialog(context, sdata.Checktake(date, allst, my[index].id)[1],my[index].name),
              );
            }, child:Card(
          color: Colors.amber,
          child: Container(
          child: Center(child: Text(my[index].name,
          style: const TextStyle(color: Colors.white, fontSize: 20),)),
          ))
          ) :   Card(
                color: (sdata.Checktake(date, allst, my[index].id)[0] == 'Y') ? Colors.green :Colors.red,
                child: Container(
                  child: Center(child: Text(my[index].name,
                    style: const TextStyle(color: Colors.white, fontSize: 20),)),
                )
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
          height: 20,
        ),
        const Text("This Year statistic", style: TextStyle(
          fontSize: 30,
          color: Colors.deepPurple,
        ),),
        const SizedBox(
          height: 10,
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(width: 20,
              height: 20,
              color: Colors.green,),
            const Text(" Taken ",
                style: TextStyle(fontSize: 20, color: Colors.deepPurple,)),
            Container(width: 20,
              height: 20,
              color: Colors.amber,),
            const Text(" SomeTaken ",
                style: TextStyle(fontSize: 20, color: Colors.deepPurple,)),
            Container(width: 20,
              height: 20,
              color: Colors.red,),
            const Text(" NotTaken ",
                style: TextStyle(fontSize: 20, color: Colors.deepPurple,)),
            Container(width: 20,
                height: 20,
                color: const Color(0xff999999)),
            const Text(" N/A",
                style: TextStyle(fontSize: 20, color: Colors.deepPurple,)),
          ],),
        const SizedBox(
          height: 20,
        ),
        yearl(),
        const SizedBox(
          height: 15,
        ),
        const Text(
            "*For some taken, tap on the medicine name to see the day you miss in that month.*",
            style: TextStyle(fontSize: 11, color: Colors.deepPurple,),
            textAlign: TextAlign.center),
        const SizedBox(
          height: 5,
        ),
        const Text(
            "*Please wait for month to complete to see the statistic*",
            style: TextStyle(fontSize: 15, color: Colors.deepPurple,),
            textAlign: TextAlign.center),
      ],
    );
  }
}

class  yearl extends StatefulWidget {
  yearl({Key? key}) : super(key: key);
  final server api = server();

  @override
  yearls createState() => yearls();
}

class yearls extends State<yearl> {
  //const weekl ({Key? key,}) : super(key: key);
  List<String> A = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
  List <List<DateTime>> B = sdata.Dyearly(DateTime.now());
  List<med> allm = [];
  List<usermed> um = [];
  List<stat> st = [];

  @override
  void initState() {
    super.initState();
    _loadallmed();
    _loadusermed();
    _loadstat();
  }

  void _loadallmed() {
    widget.api.getall('med').then((A) {
      setState(() {
        allm = A;
      });
    });
  }

  void _loadusermed() {
    widget.api.getall('usermed').then((A) {
      setState(() {
        um = A;
      });
    });
  }

  void _loadstat() {
    widget.api.getall('stat').then((A) {
      setState(() {
        st = A;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      SizedBox(
        height: 370, //        <-- Use Expanded
        child: ListView.builder(
          itemCount: A.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(A[index], style: const TextStyle(
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.bold,
                  fontSize: 25),),
              subtitle: Container(height: 100,
                decoration: const BoxDecoration(
                    color: Color(0xffededed),
                    borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                child: yeardl(date: B[index], my: mdata.getumed(allm, um), allst: st,),
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
  const yeardl ({required this.date, required this.my, required this.allst, Key? key})
      : super(key: key);
  final List<DateTime> date;
  final List<med> my;
  final List<stat> allst;

  @override
  Widget build(BuildContext context) {
    return
      Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        height: 20,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: my.length, itemBuilder: (context, index) {
          return Container(
            width: 150,
            child: (DateTime.now().isBefore(date[date.length-1])) ?Card(
                color: const Color(0xff999999),
                child: Container(
                  child: Center(child: Text(my[index].name,
                    style: const TextStyle(color: Colors.white, fontSize: 20),)),
                )
            ): (sdata.Checktake(date, allst, my[index].id)[0] == 'S')?
            GestureDetector( onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) =>
                    _buildPopupDialog(context, sdata.Checktake(date, allst, my[index].id)[1],my[index].name),
              );
            }, child:Card(
                color: Colors.amber,
                child: Container(
                  child: Center(child: Text(my[index].name,
                    style: const TextStyle(color: Colors.white, fontSize: 20),)),
                ))
            ) :   Card(
                color: (sdata.Checktake(date, allst, my[index].id)[0] == 'Y') ? Colors.green :Colors.red,
                child: Container(
                  child: Center(child: Text(my[index].name,
                    style: const TextStyle(color: Colors.white, fontSize: 20),)),
                )
            ),
          );
        }),
      );
  }
}

Widget _buildPopupDialog(BuildContext context, String my, String name) {
  return AlertDialog(
    title: Text(name),
    content: SingleChildScrollView(child:Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const Text('You miss taking the medicine in following day: '),
        Text(my),
      ],
    ) ,) ,
    actions: <Widget>[
      TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Text('Close'),
      ),
    ],
  );
}