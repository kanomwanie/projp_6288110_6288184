import 'package:flutter/material.dart';
import 'server.dart';
import 'login_data.dart' as udata;
import 'med_data.dart' as mdata;

class UUser extends StatefulWidget {

  UUser({Key? key}) : super(key: key);
  final server api = server();

  @override
  UUserstate createState() => UUserstate();
}


class UUserstate extends State<UUser> {
  List<med> allm = [];
  List<usermed> um = [] ;
  @override
  void initState() {
    super.initState();
    _loadallmed();
    _loadusermed();
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
  void out(){
    setState(() {
      udata.A.removecurrent();
    });
    Navigator.pop(context,'/');
  }
  @override
  Widget build(BuildContext context) {

    return Column(
      children:[
        const SizedBox(
          height: 10,
        ),
        Container(
            padding: EdgeInsets.fromLTRB(10, 10,20, 10),
            height: 300.0,
        width: 400.0,

        decoration: BoxDecoration(
        color: const Color(0xffedc8f5),
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: const [
        BoxShadow(
        color: Colors.grey ,
        blurRadius: 2.0,
        offset: Offset(2.0,2.0)
        )
        ],
          gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                 Color(0xffe8a2f4),
               Color(0xffedc8f5),
              ]
          ),

    ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,

          children: <Widget>[
            Row(
              children:[
                const SizedBox(
                width: 275,
              ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    // foreground (text) color
                    primary: const Color(0xffedc8f5),
                  ),
                  onPressed: () {
                    out();
                    // Respond to button press
                  },
                  child: const Text('Logout',style: TextStyle( fontSize: 20, color: Colors.deepPurple,)),
                )]),

            const SizedBox(
              height: 120,
            ),
            Expanded(
              child:  Text('Hello '+ udata.A.current.username ,style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 50, color: Colors.deepPurple,),textAlign: TextAlign.left),
            ),
            Expanded(
              child:  (mdata.checkm(allm, um))
    ? Text('\nYou currently taking '+ mdata.getumed(allm, um).length.toString()+ ' medicine',style: const TextStyle( fontSize: 20, color: Colors.deepPurple,), textAlign: TextAlign.left)
    : const Text('\nYou currently taking 0 medicine' , style: TextStyle( fontSize: 20, color: Colors.deepPurple,), textAlign: TextAlign.left)
            ),

          ],


        )
        //
),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          height:100, //height of button
          width:400,
         child:       ElevatedButton(
           style: ElevatedButton.styleFrom(
             // foreground (text) color
             primary: const Color(0xffedc8f5),
           ),
           onPressed: () {
             Navigator.pushNamed(context,'/med',);
           },
           child: const Text('Medicine database',style: TextStyle( fontSize: 40, color: Colors.deepPurple,)),
         ),
        ),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          height:100, //height of button
          width:400,
          child:       ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: const Color(0xffedc8f5),
              // foreground (text) color
            ),
            onPressed: () {
             Navigator.pushNamed(context,'/stat',);
            },
            child: const Text('Statistic',style: TextStyle( fontSize: 50, color: Colors.deepPurple,)),
          ),
        ),
      ],

    );
  }
}
