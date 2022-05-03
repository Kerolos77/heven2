import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heven2/modules/signup.dart';
import 'package:heven2/shared/Network/local/cache_helper.dart';
import 'package:heven2/shared/componants/componants.dart';
import 'package:heven2/shared/cubit/main/mainCubit.dart';
import 'package:heven2/shared/cubit/main/mainStates.dart';

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
        create: (BuildContext context) => MainCubit(),
        child: BlocConsumer<MainCubit, States>(
          listener: (context, state) {
            if (state is LoginErrorState) {
              toast(
                  msg: state.error.toString(),
                  backColor: Colors.grey.shade300,
                  textColor: Colors.black);
            }
            if (state is LoginSucsessState) {
              CacheHelper.putData(key: "user", value: state.uId).then((value) {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Home()));
              });
              toast(
                  msg: 'Welcome',
                  backColor: Colors.grey.shade300,
                  textColor: Colors.black);
            }
          },
          builder: (context, state) {
            var cub = MainCubit.get(context);
            return Scaffold(
                backgroundColor: Colors.white,
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Form(
                      key: formkey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 40,
                          ),
                          Image(
                            image: AssetImage(
                              'images/heven logo.png',
                            ),
                            height: 150,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            "Welcome Back",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[600],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          defaultLoginTextField(
                              type: TextInputType.emailAddress,
                              control: usernamecontrol,
                              icon: Icons.perm_identity,
                              label: 'Email',
                              validate: (value) {
                                if (value.toString().isEmpty) {
                                  return "Cann be Empty";
                                }
                              },
                              onchange: (value) {
                                if (!value.toString().isEmpty)
                                  cub.changeLoginUserNameFlag(true);
                                else
                                  cub.changeLoginUserNameFlag(false);
                              }),
                          SizedBox(
                            height: 30,
                          ),
                          sufixLoginTextFiled(
                              type: TextInputType.visiblePassword,
                              obscure: cub.passFlag,
                              sufixIcon: cub.passFlag
                                  ? Icons.remove_red_eye_outlined
                                  : Icons.visibility_off_outlined,
                              control: passwordcontrol,
                              prifixIcon: Icons.lock_outline,
                              label: 'Password',
                              onPressSufix: () {
                                cub.changePassFlag(!cub.passFlag);
                              },
                              validator: (value) {
                                if (value.toString().isEmpty) {
                                  return "Cann be Empty";
                                }
                              },
                              onchange: (value) {
                                if (!value.toString().isEmpty)
                                  cub.changeLoginPassFlag(true);
                                else
                                  cub.changeLoginPassFlag(false);
                              }),
                          SizedBox(
                            height: 30,
                          ),
                          ConditionalBuilder(
                            condition: state is! LoginSucsessState,
                            builder: (context) => defaultButton(
                                isDone:
                                    cub.loginPassFlag && cub.loginUserNameFlag,
                                text: 'Login',
                                onPress: () {
                                  if (formkey.currentState!.validate()) {
                                    print("${state}++++++++++++++++++++++");
                                    print(usernamecontrol.text);
                                    print(passwordcontrol.text);
                                    cub.login(
                                        email: usernamecontrol.text,
                                        password: passwordcontrol.text);
                                  }
                                }),
                            fallback: (context) => CupertinoActivityIndicator(),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Dont Have An Account ?',
                                style: TextStyle(
                                  fontSize: 10.0,
                                  color: Colors.black,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => signup(),
                                      ));
                                  print('sign up');
                                },
                                child: Text(
                                  'Sign Up',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
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
