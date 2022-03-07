import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heven2/modules/signup.dart';
import 'package:heven2/shared/componants/componants.dart';
import 'package:heven2/shared/cubit/cubit.dart';
import 'package:heven2/shared/cubit/heven_states.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../layout/home.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController usernamecontrol = new TextEditingController();
  TextEditingController passwordcontrol = new TextEditingController();
  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => cubit(),
        child: BlocConsumer<cubit, States>(
          listener: (context, state) {
            if(state is ErrorState){
              Fluttertoast.showToast(
                  msg: state.error,
                  toastLength: Toast.LENGTH_LONG,
                  backgroundColor: Colors.black26,
                  textColor: Colors.white,
              );
            }

          },
          builder: (context, state) {
            var cub = cubit.get(context);
            return Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  title: Text(
                    "",
                  ),
                ),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Form(
                      key: formkey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(
                            image: AssetImage(
                              'images/heven logo.png',
                            ),
                            height: 150,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          dfultlogintextfilde(
                            type: TextInputType.emailAddress,
                            control: usernamecontrol,
                            icon: Icons.perm_identity,
                            lable: 'Email',
                              onchange: (value){
                                if(!value.toString().isEmpty)
                                  cub.changeloginusernameflag(true);
                                else
                                  cub.changeloginusernameflag(false);
                              }
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          sufixlogintextfilde(
                            type: TextInputType.visiblePassword,
                            obscure: cub.passflag,
                            sufixicon: cub.passflag
                                ? Icons.remove_red_eye_outlined
                                : Icons.visibility_off_outlined,
                            control: passwordcontrol,
                            prifixicon: Icons.lock_outline,
                            lable: 'Password',
                            onpresssufix: () {
                              cub.changepassflag(!cub.passflag);
                            },
                            onchange: (value){
                              if(!value.toString().isEmpty)
                                cub.changeloginpassflag(true);
                              else
                                cub.changeloginpassflag(false);
                            }
                          ),
                          SizedBox(
                            height: 30,
                          ),

                          ConditionalBuilder(
                              condition: state is! LoginLoadingState ,
                              builder:(context) => defultBotton(
                                  isdone: cub.loginpassflag && cub.loginusernameflag,
                                  text: 'Login',
                                  onpress: () {
                                    print(usernamecontrol.text);
                                    print(passwordcontrol.text);
                                    cub.login(email: usernamecontrol.text, password: passwordcontrol.text);
                                    if (state is LoginState) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>home(),
                                          ));
                                    }
                                  }
                              ),
                              fallback: (context) =>CupertinoActivityIndicator(),
                          ),

                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Dont Have An Account ?',
                                style : TextStyle(
                                  fontSize: 10.0,
                                  color : Colors.black,
                                ),
                              ),
                              TextButton(
                                onPressed : (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>signup(),
                                      ));
                                  print('sign up');
                                },
                                child: Text(
                                  'Sign Up',
                                  style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ));
          },
        ));
  }
}
