import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../shared/componants/componants.dart';
import '../shared/cubit/main/mainCubit.dart';
import '../shared/cubit/main/mainStates.dart';
import 'login.dart';

class signup extends StatefulWidget {
  @override
  _signupState createState() => _signupState();
}

class _signupState extends State<signup> {
  var formkey = GlobalKey<FormState>();
  TextEditingController emailcontrol = new TextEditingController();
  TextEditingController passwordcontrol = new TextEditingController();
  TextEditingController adminkeycontrol = new TextEditingController();
  TextEditingController confirmpasswordcontrol = new TextEditingController();
  TextEditingController phonecontrol = new TextEditingController();
  TextEditingController namecontrol = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => MainCubit(),
        child: BlocConsumer<MainCubit, States>(
          listener: (context, state) {
            if (state is SignUpErrorState) {
              Fluttertoast.showToast(
                msg: state.error,
                toastLength: Toast.LENGTH_LONG,
                backgroundColor: Colors.red[20],
                textColor: Colors.white,
              );
            }
            if (state is CreateUserSucsessState) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Login(),
                  ));
            }
          },
          builder: (context, state) {
            var cub = MainCubit.get(context);
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
                          defaultLoginTextField(
                            type: TextInputType.emailAddress,
                            control: emailcontrol,
                            icon: Icons.perm_identity,
                            label: 'Email',
                            validate: (value) {
                              if (value.isEmpty) return 'Email is empty';
                            },
                            onchange: (value) {
                              if (value.contains('@') && value.contains('.com'))
                                cub.changeEmailFlag(true);
                              else
                                cub.changeEmailFlag(false);
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          defaultLoginTextField(
                            type: TextInputType.number,
                            control: adminkeycontrol,
                            icon: Icons.admin_panel_settings_outlined,
                            label: 'Admin Key',
                            validate: (value) {
                              if (value.isEmpty) return 'Admin key is empty';
                            },
                            onchange: (value) {
                              if (!value.contains('11'))
                                cub.changeAdminFlag(true);
                              else
                                cub.changeAdminFlag(false);
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          defaultLoginTextField(
                            type: TextInputType.emailAddress,
                            control: namecontrol,
                            icon: Icons.title_outlined,
                            label: 'User Name',
                            validate: (value) {
                              if (value.isEmpty) return 'Name is empty';
                            },
                            onchange: (value) {},
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          defaultLoginTextField(
                            type: TextInputType.number,
                            control: phonecontrol,
                            icon: Icons.phone,
                            label: 'Phone',
                            validate: (value) {
                              if (value.isEmpty) return 'Phone is empty';
                            },
                            onchange: (value) {
                              if (!value.contains('11'))
                                cub.changePhoneFlag(true);
                              else
                                cub.changePhoneFlag(false);
                            },
                          ),
                          SizedBox(
                            height: 10,
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
                                if (value.isEmpty) return 'passowrd is empty';
                              },
                              onchange: (value) {
                                RegExp regExcap =
                                    new RegExp(r"(?=.*[a-z])(?=.*[A-Z])\w+");
                                RegExp regExdigit =
                                    new RegExp(r"(?=.*[0-9])\w+");
                                if (regExdigit.hasMatch(value))
                                  cub.changePassDigitalFlag(true);
                                else
                                  cub.changePassDigitalFlag(false);
                                if (value.length >= 8)
                                  cub.changePassNumCharFlag(true);
                                else
                                  cub.changePassNumCharFlag(false);
                                if (regExcap.hasMatch(value))
                                  cub.changePassCapFlag(true);
                                else
                                  cub.changePassCapFlag(false);
                              }),
                          SizedBox(
                            height: 10,
                          ),
                          sufixLoginTextFiled(
                              type: TextInputType.visiblePassword,
                              obscure: cub.passFlag,
                              sufixIcon: cub.passFlag
                                  ? Icons.remove_red_eye_outlined
                                  : Icons.visibility_off_outlined,
                              control: confirmpasswordcontrol,
                              prifixIcon: Icons.confirmation_num_outlined,
                              label: 'Confirm Password',
                              onPressSufix: () {
                                cub.changePassFlag(!cub.passFlag);
                              },
                              validator: (value) {
                                if (value.isEmpty)
                                  return 'Confirm passowrd is empty';
                              },
                              onchange: (value) {
                                if (value == passwordcontrol.text)
                                  cub.changePassConfirmFlag(true);
                                else
                                  cub.changePassConfirmFlag(false);
                              }),
                          SizedBox(
                            height: 5,
                          ),
                          valedateRow(
                              flag: cub.passNumChar,
                              falseText: " atlast 8 characters",
                              trueText: " Done"),
                          SizedBox(
                            height: 5,
                          ),
                          valedateRow(
                              flag: cub.passDigitalFlag,
                              falseText: " contane digits",
                              trueText: " Done"),
                          SizedBox(
                            height: 5,
                          ),
                          valedateRow(
                              flag: cub.passCapFlag,
                              falseText: " contane upper & lowercase letters",
                              trueText: " Done"),
                          SizedBox(
                            height: 5,
                          ),
                          valedateRow(
                              flag: cub.passConfirmFlag,
                              falseText: " not match aconfirm",
                              trueText: " Done"),
                          SizedBox(
                            height: 5,
                          ),
                          ConditionalBuilder(
                            condition: state is! LoginSucsessState,
                            builder: (context) => defaultButton(
                                isDone: cub.emailFlag &&
                                    cub.adminFlag &&
                                    cub.passCapFlag &&
                                    cub.passNumChar &&
                                    cub.passDigitalFlag &&
                                    cub.passConfirmFlag &&
                                    cub.phoneFlag,
                                text: 'Sign Up',
                                onPress: () {
                                  if (formkey.currentState!.validate()) {
                                    cub.signUp(
                                        name: namecontrol.text,
                                        email: emailcontrol.text,
                                        adminKey: adminkeycontrol.text,
                                        phone: phonecontrol.text,
                                        password: passwordcontrol.text);
                                  }
                                }),
                            fallback: (context) => CupertinoActivityIndicator(),
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
