import 'package:flutter/material.dart';
class Medcheck extends StatelessWidget {
  const Medcheck({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        const Text('Today Meds',style: TextStyle( fontSize: 20, color: Colors.deepPurple,),textAlign: TextAlign.left,),
        const SizedBox(
          height: 20,
        ),
        const check(),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height:50, //height of button
          width:400,
          child:       ElevatedButton(
            style: ElevatedButton.styleFrom(
              // foreground (text) color
              primary: const Color(0xffedc8f5),
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) =>
                    _buildPopupDialog(context),
              );
            },
            child: const Text('Check Meds Inventory',style: TextStyle( fontSize: 20, color: Colors.deepPurple,)),
          ),
        ),
  ]
              );
    //
  }
}

Widget _buildPopupDialog(BuildContext context) {
  return AlertDialog(
    title: const Text('Inventory'),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: const <Widget>[
        Text("You currently have enough medicine."),
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

class check extends StatelessWidget {
  const check( {Key? key}) : super(key: key);
static List<String> products =[
    'Painkiller',
    'random1',
    'random2',
  ];
  static List<String> INst =[
    'Take two',
    'Take one',
    'Take me on',
  ];
  @override
  Widget build(BuildContext context) {
    return Column(  children: <Widget>[
      SizedBox(
        height: 430,  //        <-- Use Expanded
        child: ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('${products[index]}',style: TextStyle(color:Colors.deepPurple, fontWeight: FontWeight.bold,fontSize: 25),),
          subtitle: Text(
             ' ${INst[index]}',style: TextStyle(fontSize: 20),

          ),
trailing: _AddButton(),
        );
      },
    ),
    ),

    ],
    );
  }
}

class _AddButton extends StatelessWidget {


  const _AddButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // The context.select() method will let you listen to changes to
    // a *part* of a model. You define a function that "selects" (i.e. returns)
    // the part you're interested in, and the provider package will not rebuild
    // this widget unless that particular part of the model changes.
    //
    // This can lead to significant performance improvements.
var check = false;
void change(){
  check=true;
}

    return TextButton(
      onPressed: check
          ? null
          : () {
        // If the item is not in cart, we let the user add it.
        // We are using context.read() here because the callback
        // is executed whenever the user taps the button. In other
        // words, it is executed outside the build method.
        change();
      },
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
          if (states.contains(MaterialState.pressed)) {
            return Theme.of(context).primaryColor;
          }
          return null; // Defer to the widget's default.
        }),
      ),
      child: check
          ? const Icon(Icons.check, semanticLabel: 'Checked')
          : const Text('Check'),
    );
  }
}
