import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Friend extends StatelessWidget {
  const Friend({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
         const SizedBox(
         height: 20,
        ),
        const Text('You have xxx friends.',style: TextStyle( fontSize: 30, color: Colors.deepPurple,),textAlign: TextAlign.left,),
        const SizedBox(
          height: 10,
        ),
        Row(children: [
          const SizedBox(
            width: 10,
          ),
          SizedBox(
            height:30, //height of button
            width:180,
            child:       ElevatedButton(
              style: ElevatedButton.styleFrom(
                // foreground (text) color
                primary: const Color(0xffedc8f5),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => _buildPopupDialog(context),
                );
              },
              child: const Text('User code',style: TextStyle( fontSize: 20, color: Colors.deepPurple,)),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          SizedBox(
            height:30, //height of button
            width:200,
            child:       ElevatedButton(
              style: ElevatedButton.styleFrom(
                // foreground (text) color
                primary: const Color(0xffedc8f5),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => _buildPopupDialog2(context),
                );
              },
              child: const Text('Add New Friend',style: TextStyle( fontSize: 20, color: Colors.deepPurple,)),
            ),
          ),
        ],),

        const SizedBox(
          height: 20,
        ),
        const Listf(),
              ],

            );
          //
  }
}

class Listf extends StatelessWidget {
  const Listf( {Key? key}) : super(key: key);
  static List<String> products =[
    'Peter',
    'Petra',
    'Masha',
  ];
  @override
  Widget build(BuildContext context) {
    return Column(  children: <Widget>[
      SizedBox(
        height: 200,  //        <-- Use Expanded
        child: ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('${products[index]}',style: TextStyle(color:Colors.deepPurple, fontWeight: FontWeight.bold,fontSize: 25),),

            );
          },
        ),
      ),

    ],
    );
  }
}

Widget _buildPopupDialog(BuildContext context) {
  return AlertDialog(
    title: const Text('Your user code is :'),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: const <Widget>[
        Text("11037",style: TextStyle(fontSize: 50,fontWeight: FontWeight.bold),textAlign: TextAlign.center),
        Text("Send this code to your friend to add friend."),
      ],
    ),
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

Widget _buildPopupDialog2(BuildContext context) {
  return AlertDialog(
    title: const Text('Add Friend'),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: const <Widget>[
        TextField(
          decoration: InputDecoration(
              hintText: "User Code",
              hintStyle: TextStyle(color: Colors.grey),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Text("Type in your friend's user code."),
      ],
    ),
    actions: <Widget>[
      TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Text('ADD'),
      ),
      TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Text('Close'),
      ),
    ],
  );
}