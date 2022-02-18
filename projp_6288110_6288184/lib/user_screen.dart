import 'package:flutter/material.dart';

class user extends StatelessWidget {
  const user({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Container(
            padding: EdgeInsets.fromLTRB(10, 10,20, 10),
            height: 400.0,
        width: 400.0,
        decoration: BoxDecoration(
        color: const Color(0xffedc8f5),
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
        BoxShadow(
        color: Colors.grey ,
        blurRadius: 2.0,
        offset: Offset(2.0,2.0)
        )
        ],

    ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,

          children: const <Widget>[
            Expanded(
              child:  Text('Hello username',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50, color: Colors.deepPurple,),textAlign: TextAlign.left),
            ),
            Expanded(
              child: Text(' You currently taking 8 medicine',style: TextStyle( fontSize: 20, color: Colors.deepPurple,), textAlign: TextAlign.left),
            ),
          ],

        )
        //
), SizedBox(
          height: 20,
        ),
        SizedBox(
          height:100, //height of button
          width:400,
         child:       ElevatedButton(
           style: ElevatedButton.styleFrom(
             // foreground (text) color
           ),
           onPressed: () {
             // Respond to button press
           },
           child: Text('See Medicine database'),
         ),
        ),

      ],

    );
  }
}
