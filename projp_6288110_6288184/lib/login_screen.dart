import 'package:flutter/material.dart';
import 'server.dart';
import 'login_data.dart' as udata;

class login extends StatefulWidget {
  static const String id = 'mentor sample 1';

 login({Key? key}) : super(key: key);
  final server api = server();

  @override
  _Sample1State createState() => _Sample1State();
}

class _Sample1State extends State<login> {
  List<user> contacts = [];
late bool B = false;
  final usercontrol = TextEditingController();
  final passcontrol = TextEditingController();

  @override

  void initState() {
    super.initState();
    _loadContacts();
  }
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    usercontrol.dispose();
    passcontrol.dispose();
    super.dispose();
  }

  void _loadContacts() {
    widget.api.getall('user').then((A) {
      setState(() {
        contacts = A;
      });
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(

        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                colors: [
                  Colors.purple.shade900,
                  Colors.purple.shade500,
                  Colors.purple.shade400,
                ]
            )
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 80),
            // #login, #welcome
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const[
                  Text("DailyMeds",style: TextStyle(color: Colors.white,fontSize: 40),),
                  SizedBox(height: 10,),
                  Text("Login",style: TextStyle(color: Colors.white,fontSize: 20),),
                ],
              ),
            ),
            const SizedBox(height: 20),

            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(60),topRight: Radius.circular(60)),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      children: [
                        const SizedBox(height: 60,),
                        // #email, #password
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const[
                              BoxShadow(
                                  color: Color.fromRGBO(171, 171, 171, .7),blurRadius: 20,offset: Offset(0,10)),
                            ],
                          ),


                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
                                ),
                                child: TextField(
                                  controller: usercontrol,
                                  decoration: const InputDecoration(
                                      hintText: "Username",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
                                ),
                                child:  TextField(
                                  obscureText:true,
                                  controller: passcontrol,
                                  decoration: const InputDecoration(
                                      hintText: "Password",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none,

                                  ),


                                ),
                              ),

                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                        // #login
                        Visibility(
                          child: const Text("Incorrect username or password.",style:TextStyle(color:Colors.red,fontWeight: FontWeight.bold)),
                          visible: B,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                    InkWell(
                        child: Container(
                          height: 50,
                          margin: const EdgeInsets.symmetric(horizontal: 50),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.purple[800]

                          ),
                          child: const Center(
                            child: Text("Login",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                          ),
                        ),
                      onTap: () {
                          var w = udata.login(usercontrol.text, passcontrol.text, contacts);
                          if( w==true){
                            Navigator.pushNamed(context,'/ufc');
                          }
                          else{
                            setState(() {
                              B = true;
                            });
                          }
                      },
                    ),

                        const SizedBox(height: 30),
                        // #login SNS
                    //    const Text("Sign in",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),),
                        TextButton(
                          onPressed:(){
                            Navigator.pushNamed(context,'/sign');
                          },

                          child: const Text('Sign in',style: TextStyle(color: Colors.purple)),
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

///signup part/////
class SignUpPage extends StatefulWidget {
  static const String id = "sign_up_page";
 SignUpPage({Key? key}) : super(key: key);
  final server api = server();
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late bool B = false;
  final usercontrol = TextEditingController();
  final passcontrol = TextEditingController();
  late String tool = 'NO';
  List<user> contacts = [];
  @override
  void initState() {
    super.initState();
    _loadContacts();
  }
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    usercontrol.dispose();
    passcontrol.dispose();
    super.dispose();
  }

  void _loadContacts() {
    widget.api.getall('user').then((AA) {
      setState(() {
        contacts = AA;
      });
    });
  }

_adduser(String u, String p) async {
    if(u!= '' && p!=''){
      final  user createdContact = await widget.api.sign(u,p);
      setState(() {
        tool =  createdContact.username;
        contacts.add(createdContact);
        udata.A.addcurrent(contacts[contacts.length -1]) ;

      });
      Navigator.pushNamed(context,'/ufc');
    }

  }

  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Colors.grey.shade900,
                    Colors.grey.shade700,
                    Colors.grey.shade500,
                  ])),
          child: Column(
            children: [
              Expanded(
                  flex: 2,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: const [
                        // #signup_text
                        Text(
                          "Dailymeds",
                          textAlign: TextAlign.right,
                          style: TextStyle(color: Colors.white, fontSize: 32.5),
                        ),
                        SizedBox(
                          height: 5,
                        ),

                        // #welcome
                        Text(
                          "Sign in",
                          textAlign: TextAlign.right,
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ],
                    ),
                  )),
              Expanded(
                flex: 5,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50))),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 60,
                      ),

                      // #text_field
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 30),
                        height: MediaQuery.of(context).size.height*0.2,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.shade300,
                                  blurRadius: 20,
                                  spreadRadius: 10,
                                  offset: const Offset(0, 10))
                            ]),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextField(
                              controller: usercontrol,
                              decoration: const InputDecoration(
                                  contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                                  border: InputBorder.none,
                                  hintText: "Username",
                                  hintStyle: TextStyle(color: Colors.grey)),
                            ),
                            const Divider(
                              thickness: 0.5,
                              height: 10,
                            ),

                            TextField(
                              controller: passcontrol,
                              decoration: const InputDecoration(
                                  contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                                  border: InputBorder.none,
                                  hintText: "Password",
                                  hintStyle: TextStyle(color: Colors.grey)),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Visibility(
                        child: const Text("Username have been used. If you already have account please go to 'Login' page.",style:TextStyle(color:Colors.red,fontWeight: FontWeight.bold)),
                        visible: B,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      // #signup_button
                      MaterialButton(
                        onPressed: (){
                          var w = udata.sign(usercontrol.text, passcontrol.text, contacts);
                         if( w==true){
                         _adduser(usercontrol.text, passcontrol.text);
                         }
                          else{
                            setState(() {
                              B = true;
                            });
                          }
                        },
                        height: 45,
                        minWidth: 240,
                        shape: const StadiumBorder(),
                        color: Colors.grey.shade700,
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),

                      ),
                      const SizedBox(
                        height: 30,
                      ),

                      // #text
                      TextButton(
                        onPressed:(){
                          Navigator.pushNamed(context,'/');

                        },

                        child: const Text('Login',style: TextStyle(color: Colors.grey)),
                      ),
                      const SizedBox(
                        height: 30,
                      ),

                      // #buttons(facebook & github)

                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}