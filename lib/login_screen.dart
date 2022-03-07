import 'package:flutter/material.dart';

class login extends StatefulWidget {
  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<login>  {
  TextEditingController controlemail = new TextEditingController();

  TextEditingController controlpassword = new TextEditingController();

  bool flag = true;

  var formkey= GlobalKey<FormState>();
@override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor:Colors.cyan,
          leading: Icon(
            Icons.menu,
          ),
          title: Text(
            'Smart Home'
          ),

        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formkey,
              child: Column(
                children: [
                  Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  TextFormField(
                    controller: controlemail,
                    cursorColor: Colors.cyan,
                    keyboardType:TextInputType.emailAddress,
                    validator:(value){
                      if(!value!.contains('@') || !value.contains('.com')){
                        return 'the email must be contain @ and .com';
                      }
                      if(value.isEmpty)
                        return'email must not be empty';
                      return null;
                    },
                    onChanged: (value){
                      print(value);
                      if(formkey.currentState!.validate()){
                        print("++++");
                      }
                    },

                    decoration: InputDecoration(
                      labelText: 'Email',
                      prefixIcon: /**/Icon(
                        Icons.email,
                        size: 20,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),

                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller : controlpassword,
                    cursorColor: Colors.cyan,
                    obscureText: flag,
                    decoration: InputDecoration(
                      labelText: 'Passward',
                      prefixIcon: Icon(
                        Icons.lock,
                        size: 20,
                      ),
                      suffixIcon: IconButton(
                          onPressed: () {
                            if (flag)
                              flag=false;
                            else
                              flag=true;

                            setState(() {});
                          },
                          icon: Icon(
                            flag
                                ? Icons.remove_red_eye_outlined
                                : Icons.visibility_off_outlined,

                          )
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),

                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    color:Colors.cyan,

                    child: MaterialButton(

                        onPressed: (){
                          if(formkey.currentState!.validate()){
                          print(controlemail.text);
                          print(controlpassword.text);
                        }
                      },
                        child: Text(
                        'Login',
                          style: TextStyle(
                            fontSize:20.0,
                            color:Colors.white,
                          ),
                    ),
                    ),

                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                          'Not Have An Account ?',
                        style : TextStyle(
                          fontSize: 10.0,
                          color : Colors.lightBlue,
                        ),
                      ),
                      TextButton(
                        onPressed : (){
                          print('sign up');
                        },
                       child: Text(
                          'Sign Up',
                         style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
