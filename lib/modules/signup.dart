import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../shared/componants/componants.dart';
import '../shared/cubit/company/companyCubit.dart';
import '../shared/cubit/company/companyStates.dart';
import 'login.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var formKey = GlobalKey<FormState>();
  TextEditingController emailControl = TextEditingController();
  TextEditingController passwordControl = TextEditingController();
  TextEditingController adminKeyControl = TextEditingController();
  TextEditingController confirmPasswordControl = TextEditingController();
  TextEditingController phoneControl = TextEditingController();
  TextEditingController nameControl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CompanyCubit(),
      child: BlocConsumer<CompanyCubit, CompanyState>(
        listener: (context, state) {
          print(state);
          if (state is SignUpErrorUserState) {
            Fluttertoast.showToast(
              msg: state.error,
              toastLength: Toast.LENGTH_LONG,
              backgroundColor: Colors.red[20],
              textColor: Colors.white,
            );
          }
          if (state is CreateSuccessUserState) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Login(),
                ));
          }
        },
        builder: (context, state) {
          CompanyCubit companyCub = CompanyCubit.get(context);
          return Scaffold(
              backgroundColor: Colors.white,
              body: SafeArea(
                child: noConnectionCard(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Image(
                              image: AssetImage(
                                'images/Time management.png',
                              ),
                              fit: BoxFit.cover,
                              // height: 150,
                            ),
                            Container(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: arabicText(
                                  text: "يسعدنا انضمام شركتك الينا",
                                  color: Colors.grey.shade700,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            mainTextField(
                              type: TextInputType.emailAddress,
                              control: emailControl,
                              icon: CupertinoIcons.mail,
                              hint: 'البريد الالكتروني',
                              onchange: (value) {
                                if (!value.isEmpty &&
                                    value.contains('@') &&
                                    value.contains('.com') &&
                                    !value.contains(' ')) {
                                  companyCub.changeEmailFlag(true);
                                } else {
                                  companyCub.changeEmailFlag(false);
                                }
                              },
                            ),
                            companyCub.emailFlag
                                ? const SizedBox(
                                    height: 20,
                                  )
                                : textRegester(text: 'ex : example@gmail.com'),
                            mainTextField(
                              type: TextInputType.emailAddress,
                              control: nameControl,
                              icon: CupertinoIcons.t_bubble,
                              hint: 'اسم الشركة',
                              onchange: (value) {
                                if (!value.isEmpty) {
                                  companyCub.changeNameFlag(true);
                                } else {
                                  companyCub.changeNameFlag(false);
                                }
                              },
                            ),
                            companyCub.nameFlag
                                ? const SizedBox(
                                    height: 20,
                                  )
                                : textRegester(text: 'ex : Attendants'),
                            mainTextField(
                              type: TextInputType.number,
                              control: phoneControl,
                              icon: CupertinoIcons.phone,
                              hint: 'رقم الهاتف',
                              onchange: (value) {
                                if (!value.contains(' ') && !value.isEmpty) {
                                  companyCub.changePhoneFlag(true);
                                } else {
                                  companyCub.changePhoneFlag(false);
                                }
                              },
                            ),
                            companyCub.phoneFlag
                                ? const SizedBox(
                                    height: 20,
                                  )
                                : textRegester(text: 'ex : 01234567890'),
                            sufixTextFiled(
                                type: TextInputType.visiblePassword,
                                obscure: companyCub.obscurePassFlag,
                                prifixIcon: companyCub.obscurePassFlag
                                    ? Icons.remove_red_eye_outlined
                                    : Icons.visibility_off_outlined,
                                control: passwordControl,
                                sufixIcon: CupertinoIcons.lock,
                                hint: 'كلمة المرور',
                                onPressPrifix: () {
                                  companyCub.changeObscurePassFlag(
                                      !companyCub.obscurePassFlag);
                                },
                                onchange: (value) {
                                  if (!value.isEmpty &&
                                      value.toString().length >= 8) {
                                    companyCub.changePassNumCharFlag(true);
                                  } else {
                                    companyCub.changePassNumCharFlag(false);
                                  }
                                  if (value == confirmPasswordControl.text) {
                                    companyCub.changePassConfirmFlag(true);
                                  } else {
                                    companyCub.changePassConfirmFlag(false);
                                  }
                                }),
                            companyCub.passNumChar
                                ? const SizedBox(
                                    height: 20,
                                  )
                                : textRegester(text: 'ex : 12345678'),
                            sufixTextFiled(
                                type: TextInputType.visiblePassword,
                                obscure: companyCub.obscureConfirmFlag,
                                prifixIcon: companyCub.obscureConfirmFlag
                                    ? Icons.remove_red_eye_outlined
                                    : Icons.visibility_off_outlined,
                                control: confirmPasswordControl,
                                sufixIcon: CupertinoIcons.lock,
                                hint: 'تأكيد كلمة المرور',
                                onPressPrifix: () {
                                  companyCub.changeObscureConfirmFlag(
                                      !companyCub.obscureConfirmFlag);
                                },
                                onchange: (value) {
                                  if (!value.isEmpty &&
                                      value == passwordControl.text) {
                                    companyCub.changePassConfirmFlag(true);
                                  } else {
                                    companyCub.changePassConfirmFlag(false);
                                  }
                                }),
                            companyCub.passConfirmFlag
                                ? const SizedBox(
                                    height: 20,
                                  )
                                : textRegester(
                                    text: 'ex : Not Identical Password'),
                            ConditionalBuilder(
                              condition: state is! LoginSuccessUserState,
                              builder: (context) => defaultButton(
                                  isDone: companyCub.emailFlag &&
                                      companyCub.passNumChar &&
                                      companyCub.passConfirmFlag &&
                                      companyCub.phoneFlag &&
                                      companyCub.nameFlag,
                                  text: 'تسجيل',
                                  onPress: () {
                                    if (formKey.currentState!.validate()) {
                                      companyCub.signUp(
                                          name: nameControl.text,
                                          email: emailControl.text,
                                          adminKey: adminKeyControl.text,
                                          phone: phoneControl.text,
                                          password: passwordControl.text);
                                    }
                                  }),
                              fallback: (context) =>
                                  CupertinoActivityIndicator(),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Login(),
                                        ));
                                    print('Login');
                                  },
                                  child: arabicText(
                                      text: 'تسجيل الدخول',
                                      size: 10,
                                      color: Colors.blue),
                                ),
                                arabicText(
                                    text: 'لديك حساب بالفعل ؟',
                                    size: 10,
                                    color: Colors.black),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ));
        },
      ),
    );
  }
}
