import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heven2/modules/signup.dart';
import 'package:heven2/shared/Network/local/cache_helper.dart';
import 'package:heven2/shared/componants/componants.dart';

import '../layout/home.dart';
import '../shared/cubit/company/companyCubit.dart';
import '../shared/cubit/company/companyStates.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController userNameControl = TextEditingController();
  TextEditingController passwordControl = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => CompanyCubit(),
        child: BlocConsumer<CompanyCubit, CompanyState>(
          listener: (context, state) {
            if (state is LoginErrorUserState) {
              toast(
                  msg: state.error.toString(),
                  backColor: Colors.grey.shade300,
                  textColor: Colors.black);
            }
            if (state is LoginSuccessUserState) {
              CacheHelper.putData(key: "user", value: state.uId).then((value) {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Home()));
              });
              toast(
                  msg: "مرحبا بك",
                  backColor: Colors.grey.shade300,
                  textColor: Colors.black);
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
                                    text: "يسعدنا رجوعك",
                                    size: 15,
                                    color: Colors.grey.shade700,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              mainTextField(
                                  type: TextInputType.emailAddress,
                                  control: userNameControl,
                                  icon: CupertinoIcons.mail,
                                  hint: 'البريد الإلكتروني',
                                  onchange: (value) {
                                    if (!value.isEmpty) {
                                      companyCub.changeLoginUserNameFlag(true);
                                    } else {
                                      companyCub.changeLoginUserNameFlag(false);
                                    }
                                  }),
                              companyCub.loginUserNameFlag
                                  ? const SizedBox(
                                      height: 20,
                                    )
                                  : textRegester(
                                      text: 'ex : example@gmail.com'),
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
                                  if (!value.isEmpty) {
                                    companyCub.changeLoginPassFlag(true);
                                  } else {
                                    companyCub.changeLoginPassFlag(false);
                                  }
                                },
                              ),
                              companyCub.loginPassFlag
                                  ? const SizedBox(
                                      height: 20,
                                    )
                                  : textRegester(text: 'ex : 12345678'),
                              ConditionalBuilder(
                                condition: state is! LoginSuccessUserState,
                                builder: (context) => defaultButton(
                                    isDone: companyCub.loginPassFlag &&
                                        companyCub.loginUserNameFlag,
                                    text: 'تسجيل الدخول',
                                    onPress: () {
                                      if (formKey.currentState!.validate()) {
                                        print("${state}++++++++++++++++++++++");
                                        print(userNameControl.text);
                                        print(passwordControl.text);
                                        companyCub.login(
                                            email: userNameControl.text,
                                            password: passwordControl.text);
                                      }
                                    }),
                                fallback: (context) =>
                                    CupertinoActivityIndicator(),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => SignUp(),
                                          ));
                                    },
                                    child: arabicText(
                                      text: 'سجل الان',
                                      size: 10,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  arabicText(
                                    text: 'ليس لديك حساب ؟',
                                    size: 10,
                                    color: Colors.black,
                                  ),
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
        ));
  }
}
