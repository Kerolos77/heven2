import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../shared/componants/componants.dart';
import '../shared/componants/editProfileComponants.dart';
import '../shared/cubit/editProfile/editProfileCubit.dart';
import '../shared/cubit/editProfile/editProfileStates.dart';
import 'mapScreen.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  int val = -1;
  TextEditingController locationControl = TextEditingController();
  TextEditingController emailControl = TextEditingController();
  TextEditingController phoneControl = TextEditingController();
  TextEditingController passwordControl = TextEditingController();
  TextEditingController confirmPasswordControl = TextEditingController();
  late File imageFile = File('images/Image folder-amico.png');

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext) => EditProfileCubit(),
        child: BlocConsumer<EditProfileCubit, EditProfileState>(
            listener: (context, state) {},
            builder: (context, state) {
              EditProfileCubit editProfileCubit = EditProfileCubit.get(context);
              return Scaffold(
                backgroundColor: Colors.white,
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Card(
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 5.0),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.08,
                                  ),
                                  Stack(
                                      alignment: Alignment.bottomRight,
                                      children: [
                                        Card(
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.25,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.09,
                                            child: Image.asset(imageFile.path,
                                                fit: BoxFit.fill),
                                          ),
                                          elevation: 5,
                                          color: Colors.white,
                                          clipBehavior: Clip.none,
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15)),
                                          ),
                                        ),
                                        CircleAvatar(
                                          radius: 15,
                                          backgroundColor: Colors.white30,
                                          child: IconButton(
                                            icon: Icon(
                                              Icons.edit,
                                              color: Colors.blue,
                                              size: 15,
                                            ),
                                            onPressed: () async =>
                                                await pickImageFromGallery(),
                                          ),
                                        )
                                      ]),
                                  const Expanded(
                                    child: Center(
                                      child: Text(
                                        'Heven 2',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          elevation: 5,
                          color: Colors.blue.shade50,
                        ),
                        arabicText(text: 'نوع المرتب'),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.08,
                            ),
                            RadioButton(
                              value: 1,
                              groupValue: val,
                              onChanged: (value) {
                                setState(() {
                                  val = value as int;
                                });
                              },
                              title: 'مرتب شهري',
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.08,
                            ),
                            RadioButton(
                              value: 2,
                              groupValue: val,
                              onChanged: (value) {
                                setState(() {
                                  val = value as int;
                                });
                              },
                              title: 'مرتب اسبوعي',
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              height: 40,
                              child: Row(
                                children: [
                                  IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        CupertinoIcons.add,
                                        color: Colors.blue,
                                        size: 20,
                                      )),
                                  arabicText(text: '4'),
                                  IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.remove,
                                        color: Colors.blue,
                                        size: 20,
                                      )),
                                ],
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  color: Colors.blue.shade600,
                                  width: 1,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.08,
                            ),
                            arabicText(text: 'ساعات العمل'),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              height: 40,
                              child: Row(
                                children: [
                                  IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.add,
                                        color: Colors.blue,
                                        size: 20,
                                      )),
                                  arabicText(text: '4'),
                                  IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.remove,
                                        color: Colors.blue,
                                        size: 20,
                                      )),
                                ],
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  color: Colors.blue.shade600,
                                  width: 1,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.08,
                            ),
                            arabicText(text: 'الاجازات الاسبوعية'),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        mainTextField(
                          type: TextInputType.emailAddress,
                          control: locationControl,
                          icon: CupertinoIcons.location_solid,
                          iconColor: Colors.blue,
                          readOnly: true,
                          hint: 'موقع الشركه',
                          onTape: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MapScreen(),
                              ),
                            );
                          },
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        mainTextField(
                          type: TextInputType.emailAddress,
                          control: emailControl,
                          icon: CupertinoIcons.mail_solid,
                          iconColor: Colors.blue,
                          hint: 'البريد الالكتروني',
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        mainTextField(
                          type: TextInputType.phone,
                          control: phoneControl,
                          icon: CupertinoIcons.phone_fill,
                          iconColor: Colors.blue,
                          hint: 'رقم الهاتف',
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        sufixTextFiled(
                          type: TextInputType.emailAddress,
                          control: passwordControl,
                          iconColor: Colors.blue,
                          hint: 'كلمة المرور الجديدة ',
                          prifixIcon: editProfileCubit.obscurePassFlag
                              ? Icons.remove_red_eye_outlined
                              : Icons.visibility_off_outlined,
                          sufixIcon: CupertinoIcons.lock_fill,
                          obscure: editProfileCubit.obscurePassFlag,
                          onPressPrifix: () {
                            editProfileCubit.changeObscurePassFlag(
                                !editProfileCubit.obscurePassFlag);
                          },
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        sufixTextFiled(
                          type: TextInputType.emailAddress,
                          control: confirmPasswordControl,
                          iconColor: Colors.blue,
                          hint: 'تاكيد كلمة المرور الجديد ',
                          prifixIcon: editProfileCubit.obscureConfirmFlag
                              ? Icons.remove_red_eye_outlined
                              : Icons.visibility_off_outlined,
                          sufixIcon: CupertinoIcons.lock_fill,
                          obscure: editProfileCubit.obscureConfirmFlag,
                          onPressPrifix: () {
                            editProfileCubit.changeObscureConfirmFlag(
                                !editProfileCubit.obscureConfirmFlag);
                          },
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Card(
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.33,
                                  child: MaterialButton(
                                    onPressed: () {},
                                    child: arabicText(
                                      text: 'إلغاء',
                                      color: Colors.black45,
                                    ),
                                  ),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                clipBehavior: Clip.hardEdge,
                                elevation: 10,
                                color: Colors.blue.shade100,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Card(
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.33,
                                  child: MaterialButton(
                                    onPressed: () {},
                                    child: arabicText(text: 'أحفظ'),
                                  ),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                clipBehavior: Clip.hardEdge,
                                elevation: 10,
                                color: Colors.blue.shade100,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }));
  }

  Future<Null> pickImageFromGallery() async {
    final File imgFile = await ImagePicker.platform
        .pickImage(source: ImageSource.gallery) as File;
    setState(() => imageFile = imgFile);
  }
}
