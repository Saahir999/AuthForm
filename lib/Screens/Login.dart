import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as developer;
import '../Data/Server.dart';
import 'Home.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  bool change = false;
  String s = "Sign Up";
  String l = "Log In";
  String _pass = "";
  String _email = "";
  final _formKey = GlobalKey<FormState>();
  int k = 0;
  // final _formKey2 = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final FocusNode _focusNode2 = FocusNode();

  @override
  void initState(){
    FlutterNativeSplash.remove();
    super.initState();
    _focusNode.addListener((){
      if(!_focusNode.hasFocus) {
        _formKey.currentState?.validate();
      }
    });
    _focusNode2.addListener((){
      if(!_focusNode2.hasFocus) {
        _formKey.currentState?.validate();
      }
    });
  }

  @override
  void dispose(){
    super.dispose();
    _focusNode.dispose();
    _focusNode2.dispose();
    _controller.dispose();
    _controller2.dispose();
  }

  @override
  Widget build(BuildContext context) {
    k = 0;
    final formState = _formKey.currentState;

    return Scaffold(
      appBar: AppBar(
        title: Text((change)?s:l),
        actions: [
          Stack(
            children: [
              Text((change)?l:s),
              IconButton(onPressed: (){
                setState((){
                  change = !change;
                  _controller.text = "";
                  _controller2.text = "";
                });},
                icon: const Icon(Icons.turned_in_outlined),
              ),
            ]
          )],
      ),
        body: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Card(
                    child: ListTile(
                      title: TextFormField(
                        decoration: const InputDecoration(
                          hintText: "Email",
                          focusColor: Colors.deepOrange,
                        ),
                        focusNode: _focusNode,
                        controller: _controller,
                        validator: validateEmail,
                        onSaved: (s){
                          _email = s!;
                        },
                      ),
                      leading: const Icon(Icons.message_rounded, color: Colors.blueAccent,),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: TextFormField(
                        decoration: const InputDecoration(
                          hintText: "Password",
                          focusColor: Colors.deepOrange,
                        ),
                        initialValue: null,
                        focusNode: _focusNode2,
                        controller: _controller2,
                        validator: validatePassword,
                        onSaved: (s){
                          _pass = s!;
                        },
                      ),
                      leading: const Icon(Icons.key_rounded, color: Colors.black,),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      onPressed: (){
                        if(validatePassword(_controller2.text) == null && validateEmail(_controller.text) == null) {
                            developer.log("https://validated.com");
                            formState?.save();
                            send(_pass, _email, ((change)
                                ? "https://reqres.in/api/register"
                                : "https://reqres.in/api/login")).then(
                                    (value) {
                                  showAlertDialog(context, title: "Successful " +
                                      ((change) ? s : l),
                                    content: (change)?"token:${value["token"]}"+"\nid:"+"${value["id"]}"
                                        :"token: ${value["token"]}",
                                    actions: [
                                      TextButton(
                                        child: const Text("Ok"),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                      TextButton(
                                        child: const Text("Proceed"),
                                        onPressed: () {
                                          Navigator.pushAndRemoveUntil(context,
                                              MaterialPageRoute(builder: (
                                                  BuildContext context) => const Home()),
                                                  (route) => false);
                                        },
                                      )
                                    ],
                                  );
                                },
                                onError: (e) {
                                  developer.log("https://google.com");
                                  developer.log(e.toString());
                                }
                            );
                        }
                        else {
                          showAlertDialog(context,title: "Alert",content: "Please enter your details properly",
                              actions: [
                                TextButton(
                                 child: const Text("Ok"), onPressed: (){Navigator.pop(context);},
                                )
                              ],
                          );
                        }
                      },
                      child: Container(
                        child: Text((change)?"Sign Up":"Log In"),
                        color: Colors.blueAccent,
                      ),
                  ),
                ]
              ),
            ),
          ),
        )
    );
  }


  void showAlertDialog(BuildContext context,
  {required String title,required String content,required, required List<Widget>? actions}) {

    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: actions,
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

    String? validateEmail(String? s){
      if(s != null){
        if( s.contains("@") && (s.indexOf("@") == s.lastIndexOf("@")) ){
          k++;
          return null;
        }
        else {
          return "This is not a email";
        }
      }
      else{
        return "Please enter your email";
      }
    }

    String? validatePassword(String? s){
      if(s != null && s != ""){
        k++;
        return null;
      }
      else{
        return "Please enter your password";
      }
    }

}
