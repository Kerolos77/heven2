import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../login_screen.dart';
import '../shared/componants/componants.dart';
import '../shared/cubit/cubit.dart';
import '../shared/cubit/heven_states.dart';
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
        create: (BuildContext context) => cubit(),
        child: BlocConsumer<cubit, States>(
          listener: (context, state) {},
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
                          dfultlogintextfilde(
                            type: TextInputType.emailAddress,
                            control: emailcontrol,
                            icon: Icons.perm_identity,
                            lable: 'Email',
                            validatetor: (value) {
                              if (value.isEmpty)
                                return 'Email is empty';
                            },
                            onchange: (value) {
                              if (value.contains('@') &&
                                  value.contains('.com'))
                                cub.changeemailflag(true);
                              else
                                cub.changeemailflag(false);
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          dfultlogintextfilde(
                            type: TextInputType.number,
                            control: adminkeycontrol,
                            icon: Icons.admin_panel_settings_outlined,
                            lable: 'Admin Key',
                            validatetor: (value) {
                              if (value.isEmpty)
                                return 'Admin key is empty';
                            },
                            onchange: (value) {
                              if (!value.contains('11'))
                                cub.changeadminflag(true);
                              else
                                cub.changeadminflag(false);
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          dfultlogintextfilde(
                            type: TextInputType.emailAddress,
                            control: namecontrol,
                            icon: Icons.title_outlined,
                            lable: 'User Name',
                            validatetor: (value) {
                              if (value.isEmpty)
                                return 'Name is empty';
                            },
                            onchange: (value) {

                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          dfultlogintextfilde(
                            type: TextInputType.number,
                            control: phonecontrol,
                            icon: Icons.phone,
                            lable: 'Phone',
                            validatetor: (value) {
                              if (value.isEmpty)
                                return 'Phone is empty';
                            },
                            onchange: (value) {
                              if (!value.contains('11'))
                                cub.changephoneflag(true);
                              else
                                cub.changephoneflag(false);
                            },
                          ),
                          SizedBox(
                            height: 10,
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
                              validatetor: (value) {
                                if (value.isEmpty) return 'passowrd is empty';
                              },
                              onchange: (value) {
                                RegExp regExcap =
                                    new RegExp(r"(?=.*[a-z])(?=.*[A-Z])\w+");
                                RegExp regExdigit =
                                    new RegExp(r"(?=.*[0-9])\w+");
                                if (regExdigit.hasMatch(value))
                                  cub.changepassdigitalflag(true);
                                else
                                  cub.changepassdigitalflag(false);
                                if (value.length >= 8)
                                  cub.changepassnumcharflag(true);
                                else
                                  cub.changepassnumcharflag(false);
                                if (regExcap.hasMatch(value))
                                  cub.changepasscapflag(true);
                                else
                                  cub.changepasscapflag(false);
                              }),
                          SizedBox(
                            height: 10,
                          ),
                          sufixlogintextfilde(
                              type: TextInputType.visiblePassword,
                              obscure: cub.passflag,
                              sufixicon: cub.passflag
                                  ? Icons.remove_red_eye_outlined
                                  : Icons.visibility_off_outlined,
                              control: confirmpasswordcontrol,
                              prifixicon: Icons.confirmation_num_outlined,
                              lable: 'Confirm Password',
                              onpresssufix: () {
                                cub.changepassflag(!cub.passflag);
                              },
                              validatetor: (value) {
                                if (value.isEmpty)
                                  return 'Confirm passowrd is empty';
                              },
                              onchange: (value) {
                                if (value == passwordcontrol.text)
                                  cub.changepassconeirmflag(true);
                                else
                                  cub.changepassconeirmflag(false);
                              }),
                          SizedBox(
                            height: 5,
                          ),
                          valedaterow(
                              flag: cub.passnumchar,
                              falsetext: " atlast 8 characters",
                              truetext: " Done"),
                          SizedBox(
                            height: 5,
                          ),
                          valedaterow(
                              flag: cub.passdigitalflag,
                              falsetext:
                                  " contane digits",
                              truetext: " Done"),
                          SizedBox(
                            height: 5,
                          ),
                          valedaterow(
                              flag: cub.passcapflag,
                              falsetext:
                                  " contane upper & lowercase letters",
                              truetext: " Done"),
                          SizedBox(
                            height: 5,
                          ),
                          valedaterow(
                              flag: cub.passconfirmflag,
                              falsetext:
                                  " not match aconfirm",
                              truetext: " Done"),
                          SizedBox(
                            height: 5,
                          ),

                          defultBotton(
                              isdone: cub.emailflag && cub.adminflag && cub.passcapflag && cub.passnumchar && cub.passdigitalflag && cub.passconfirmflag && cub.phoneflag,
                              text: 'Sign Up',
                              onpress: () {
                                if (formkey.currentState!.validate() && cub.emailflag && cub.adminflag && cub.passcapflag && cub.passnumchar && cub.passdigitalflag && cub.passconfirmflag) {
cub.signUp(email: emailcontrol.text, adminkey: adminkeycontrol.text, phone: phonecontrol.text, password: passwordcontrol.text);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Login(),
                                      ));
                                }
                              }),
                        ],
                      ),
                    ),
                  ),
                ));
          },
        ));
  }
}
