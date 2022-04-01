import 'package:flutter/material.dart';
import 'server.dart';
import 'login_data.dart' as udata;
import 'med_data.dart' as mdata;

class Medcheck extends StatefulWidget {
  Medcheck({Key? key}) : super(key: key);
  final server api = server();
  @override
  Medchecks createState() => Medchecks();
}

class Medchecks extends State<Medcheck> {
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
  Widget build(BuildContext context) {
    return Column(
      children: (mdata.checkm(allm, um))
      ?[
        const SizedBox(
          height: 20,
        ),
        const Text('Today Meds',style: TextStyle( fontSize: 20, color: Colors.deepPurple,),textAlign: TextAlign.left,),
        const SizedBox(
          height: 20,
        ),
        check(mmed: mdata.getumed(allm, um)),
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
                    _buildPopupDialog(context,mdata.getumed(allm, um)),
              );
            },
            child: const Text('Check Meds Inventory',style: TextStyle( fontSize: 20, color: Colors.deepPurple,)),
          ),
        ),
  ]
        : [const SizedBox(
        height: 20,
      ),
        const Text('Today Meds',style: TextStyle( fontSize: 20, color: Colors.deepPurple,),textAlign: TextAlign.left,),
        const SizedBox(
          height: 20,
        ),
        const SizedBox(
          height: 430,
          child: Text("You currently don't have any medicine. You can go to medicine database to add medicine."),
        ),]
              );
    //
  }
}

Widget _buildPopupDialog(BuildContext context,List<med> my) {
  return AlertDialog(
    title: const Text('Inventory'),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children:  <Widget>[
        Text(mdata.intvcheck(my)),
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
  const check( {required this.mmed,Key? key,}) : super(key: key);
  final List<med> mmed;
  @override
  Widget build(BuildContext context) {
    return Column(  children: <Widget>[
      SizedBox(
        height: 420,  //        <-- Use Expanded
        child: ListView.builder(
      itemCount: mmed.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(mmed[index].name,style: const TextStyle(color:Colors.deepPurple, fontWeight: FontWeight.bold,fontSize: 25),),
          subtitle: Text(
             mdata.shortentext(mmed[index].add),style: const TextStyle(fontSize: 20),

          ),
trailing: const _AddButton(),
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
