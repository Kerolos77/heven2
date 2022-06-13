import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:heven2/modules/atendEmpScreen.dart';
import 'package:intl/intl.dart';
import 'package:status_alert/status_alert.dart';

import '../ID/CreateId.dart';
import '../cubit/attend/attendCubit.dart';
import '../cubit/emp/empCubit.dart';

Widget defaultTextField({
  required TextEditingController control,
  required TextInputType type,
  required String label,
  required IconData icon,
  bool enableKey = false,
  ValueChanged? onSubmit,
  ValueChanged? onchange,
  GestureTapCallback? onTape,
  FormFieldValidator? validate,
}) =>
    TextFormField(
      controller: control,
      keyboardType: type,
      onChanged: onchange,
      onTap: onTape,
      validator: validate,
      onFieldSubmitted: onSubmit,
      readOnly: enableKey,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.black),
        filled: true,
        fillColor: Colors.grey.shade200,
        prefixIcon: /**/ Icon(
          icon,
          size: 25,
          color: Colors.black,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );

Widget dialogText({
  required String label,
  required String model,
}) =>
    Text(
      '$label : $model',
      style: const TextStyle(
        color: Colors.black,
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
    );

Widget itemNewEmp(Map model, context) {
  late String id;
  AttendCubit attendCub = AttendCubit();
  EmpCubit empCub = EmpCubit.get(context);
  return Padding(
    padding: const EdgeInsets.only(top: 1, bottom: 1, left: 2, right: 2),
    child: GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      dialogText(
                        label: 'Name',
                        model: model['name'],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      dialogText(
                        label: 'Phone',
                        model: model['phone'],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      dialogText(
                        label: 'NID',
                        model: model['nid'],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      dialogText(
                        label: 'Salary',
                        model: model['salary'],
                      ),
                    ],
                  ),
                  clipBehavior: Clip.hardEdge,
                  elevation: 0,
                ),
              );
            });
      },
      child: Card(
        elevation: 2,
        clipBehavior: Clip.hardEdge,
        color: Colors.white,
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${model['name']}',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${model['id']}',
                        style: TextStyle(
                          color: Colors.grey.shade400,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    if (model['isAttend'] == 0) {
                      id = CreateId.createId();
                      attendCub.createAttend(
                        date: DateFormat('yyyy-MM-dd').format(DateTime.now()),
                        empId: model['id'],
                        endTime: "00:00AM",
                        startTime: DateFormat('hh:mma').format(DateTime.now()),
                        id: id,
                      );
                      empCub.updateEmp(
                        isAttend: 1,
                        id: model['id'],
                        nId: model['nid'],
                        phone: model['phone'],
                        name: model['name'],
                        salary: model['salary'],
                        lastAttendance: id,
                        startTime: DateFormat('hh:mma').format(DateTime.now()),
                      );
                      statusCard(
                        context: context,
                        title: " تم بداية العمل ",
                        subtitle: DateFormat('hh:mma').format(DateTime.now()),
                        configurationIcon: const IconConfiguration(
                            icon: Icons.check, color: Colors.green, size: 50),
                      );
                    } else {
                      statusCard(
                        context: context,
                        title: " الموظف بدأ العمل بالفعل ",
                        subtitle: model["startTime"],
                        configurationIcon: const IconConfiguration(
                            icon: Icons.error_outline_outlined,
                            color: Colors.red,
                            size: 50),
                      );
                    }
                  },
                  icon: Icon(
                    Icons.access_time,
                    color: Colors.green.shade300,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    if (model['isAttend'] == 1) {
                      attendCub.updateAttend(
                        startTime: model["startTime"],
                        endTime: DateFormat('hh:mma').format(DateTime.now()),
                        id: model['lastAttendance'],
                        empId: model['id'],
                      );
                      empCub.updateEmp(
                        isAttend: 0,
                        id: model['id'],
                        nId: model['nid'],
                        phone: model['phone'],
                        name: model['name'],
                        salary: model['salary'],
                        lastAttendance: model['lastAttendance'],
                        startTime: model["startTime"],
                      );
                      statusCard(
                        context: context,
                        title: " تم انهاء العمل ",
                        subtitle: DateFormat('hh:mma').format(DateTime.now()),
                        configurationIcon: const IconConfiguration(
                            icon: Icons.check, color: Colors.green, size: 50),
                      );
                    } else {
                      statusCard(
                        context: context,
                        title: " الموظف انتهي من العمل بالفعل ",
                        subtitle: "",
                        configurationIcon: const IconConfiguration(
                            icon: Icons.error_outline_outlined,
                            color: Colors.red,
                            size: 50),
                      );
                    }
                  },
                  icon: Icon(
                    Icons.access_time,
                    color: Colors.red.shade200,
                  ),
                  disabledColor: Colors.grey,
                ),
                IconButton(
                  onPressed: () {
                    // attendCub.getAttend(
                    //     date: DateFormat('yyyy-MM-dd').format(DateTime.now()),
                    //     empId: model['id']);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AttendScreen(
                                name: model['name'],
                                id: model['id'],
                                Salary: int.parse(model['salary']),
                                // cub: cub,
                              )),
                    );
                  },
                  icon: const Icon(
                    Icons.slideshow,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          decoration: BoxDecoration(
// borderRadius: BorderRadius.circular(10),
            border: Border(
              bottom: BorderSide(
                  width: 3.0,
                  color: model['isAttend'] == 1
                      ? Colors.green.shade300
                      : Colors.red.shade200),
// color: model['isAttend'] == 1 ? Colors.green : Colors.red,
// width: 2
            ),
          ),
        ),
      ),
    ),
  );
}

Widget itemAttend(Map model) => Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        width: double.infinity,
        child: Row(
          children: [
            Expanded(
              child: Text(
                '${model['date']}',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: Text(
                '${model['startTime']}',
                style: TextStyle(
                  color: Colors.green.shade300,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: Text(
                '${model['endTime']}',
                style: TextStyle(
                  color: Colors.red.shade200,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              model['timeInDay'],
              style: const TextStyle(
                color: Colors.black,
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );

Widget mainTextField({
  required TextEditingController control,
  required TextInputType type,
  required String hint,
  required IconData icon,
  bool readOnly = false,
  ValueChanged? onSubmit,
  ValueChanged? onchange,
  GestureTapCallback? onTape,
  FormFieldValidator? validate,
  Color iconColor = Colors.black,
}) =>
    Card(
      child: TextFormField(
        controller: control,
        keyboardType: type,
        onChanged: onchange,
        onTap: onTape,
        validator: validate,
        onFieldSubmitted: onSubmit,
        cursorColor: Colors.black,
        readOnly: readOnly,
        textDirection: ui.TextDirection.rtl,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          errorStyle: TextStyle(
            fontSize: 10,
            color: Colors.grey,
          ),
          hintText: hint,
          hintTextDirection: ui.TextDirection.rtl,
          hintStyle: const TextStyle(
            color: Colors.black26,
            fontSize: 15,
            fontFamily: 'Cairo',
            fontWeight: FontWeight.bold,
          ),
          suffixIcon: /**/ Icon(
            icon,
            color: iconColor,
          ),
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      clipBehavior: Clip.hardEdge,
      elevation: 10,
      color: Colors.blue.shade50,
    );

Widget sufixTextFiled(
        {required TextEditingController control,
        required TextInputType type,
        required String hint,
        required IconData prifixIcon,
        required IconData sufixIcon,
        required bool obscure,
        VoidCallback? onPressPrifix,
        bool enableKey = false,
        ValueChanged? onSubmit,
        ValueChanged? onchange,
        GestureTapCallback? onTape,
        FormFieldValidator? validator,
        Color iconColor = Colors.black}) =>
    Card(
      child: TextFormField(
        controller: control,
        keyboardType: type,
        onChanged: onchange,
        onTap: onTape,
        validator: validator,
        onFieldSubmitted: onSubmit,
        readOnly: enableKey,
        obscureText: obscure,
        cursorColor: Colors.black,
        textDirection: ui.TextDirection.rtl,
        decoration: InputDecoration(
          hintText: hint,
          hintTextDirection: ui.TextDirection.rtl,
          hintStyle: const TextStyle(
            color: Colors.black26,
            fontSize: 15,
            fontFamily: 'Cairo',
            fontWeight: FontWeight.bold,
          ),
          prefixIcon: IconButton(
            icon: Icon(
              prifixIcon,
              color: iconColor,
            ),
            onPressed: onPressPrifix,
          ),
          suffixIcon: Icon(
            sufixIcon,
            color: iconColor,
          ),
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      clipBehavior: Clip.hardEdge,
      elevation: 10,
      color: Colors.blue.shade50,
    );

Widget defaultButton(
        {required String text, required bool isDone, VoidCallback? onPress}) =>
    Container(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(top: 1, bottom: 1, left: 20, right: 20),
        child: MaterialButton(
            onPressed: isDone ? onPress : () {},
            child: arabicText(
              text: text,
              color: Colors.white,
              size: 20,
            )),
      ),
      decoration: BoxDecoration(
        color: isDone ? Colors.black : Colors.black26,
        borderRadius: BorderRadius.circular(20),
      ),
    );

Widget itemMenu({
  required String title,
  required IconData icon,
  required Color iconColor,
}) =>
    Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 10,
        end: 10,
      ),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Icon(
                icon,
                color: iconColor,
                size: 30,
              ),
              const SizedBox(
                width: 20,
              ),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                ),
              )
            ],
          ),
        ),
        decoration: const BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                topLeft: Radius.circular(20))),
      ),
    );

Future<bool?> toast({
  required String msg,
  required Color backColor,
  required Color textColor,
}) =>
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: backColor,
      textColor: textColor,
    );

Widget bottomSheet({
  required GlobalKey key,
  required TextEditingController nameControl,
  required TextEditingController phoneControl,
  required TextEditingController nidControl,
  required TextEditingController salaryControl,
}) {
  return SingleChildScrollView(
    child: Container(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: key,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 15,
                ),
                mainTextField(
                    type: TextInputType.name,
                    control: nameControl,
                    icon: CupertinoIcons.t_bubble,
                    hint: 'اسم الموظف',
                    validate: (value) {
                      if (value.isEmpty) {
                        return 'ادخل اسم الموظف';
                      }
                      return null;
                    }),
                mainTextField(
                    type: TextInputType.number,
                    control: phoneControl,
                    icon: CupertinoIcons.phone,
                    hint: 'رقم الهاتف',
                    validate: (value) {
                      if (value.isEmpty) {
                        return 'ادخل رقم الهاتف';
                      }
                      return null;
                    }),
                mainTextField(
                    type: TextInputType.number,
                    control: nidControl,
                    icon: Icons.card_membership_outlined,
                    hint: 'الرقم القومي',
                    validate: (value) {
                      if (value.isEmpty) {
                        return 'ادخل الرقم القومي';
                      }
                      return null;
                    }),
                mainTextField(
                    type: TextInputType.number,
                    control: salaryControl,
                    icon: Icons.monetization_on_outlined,
                    hint: 'المرتب',
                    validate: (value) {
                      if (value.isEmpty) {
                        return 'ادخل المرتب';
                      }
                      return null;
                    }),
              ],
            ),
          ),
        ),
        decoration: const BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(0),
                bottomLeft: Radius.circular(0),
                topRight: Radius.circular(30),
                topLeft: Radius.circular(30)))),
  );
}

Widget defaultIconCard({
  required IconData icon,
  required VoidCallback? onTap,
}) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      clipBehavior: Clip.hardEdge,
      child: IconButton(
        icon: Icon(
          icon,
          size: 20,
        ),
        onPressed: onTap,
      ),
    ),
  );
}

void statusCard({
  required BuildContext context,
  required String title,
  required String subtitle,
  required IconConfiguration configurationIcon,
}) {
  return StatusAlert.show(
    context,
    duration: const Duration(seconds: 3),
    title: title,
    subtitle: subtitle,
    configuration: configurationIcon,
    backgroundColor: Colors.grey.shade300,
  );
}

Widget textRegester({
  required String text,
}) {
  return Column(
    children: [
      const SizedBox(
        height: 5,
      ),
      Padding(
        padding: const EdgeInsets.only(left: 15.0),
        child: Text(
          text,
          style: TextStyle(
            color: Colors.grey.shade500,
            fontSize: 12,
          ),
        ),
      ),
      const SizedBox(
        height: 15,
      )
    ],
  );
}

Widget noConnection() {
  return Container(
    color: Colors.blue.shade50,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Center(
          child: Image(
            image: AssetImage('images/No connection.png'),
            fit: BoxFit.contain,
            // height: 200,
            // width: 200,
          ),
        ),
        arabicText(text: 'Opps!', size: 20),
        const SizedBox(height: 10),
        arabicText(text: 'تاكد من الاتصال بالانترنت ', size: 16),
      ],
    ),
  );
}

Widget noConnectionCard({
  required Widget child,
}) {
  return OfflineBuilder(
    connectivityBuilder: (
      BuildContext context,
      ConnectivityResult connectivity,
      Widget child,
    ) {
      final bool connected = connectivity != ConnectivityResult.none;
      return connected ? child : noConnection();
    },
    child: child,
  );
}

Widget arabicText({
  required String text,
  double size = 15,
  Color color = Colors.black,
}) {
  return Text(
    text,
    style: TextStyle(
      fontSize: size,
      fontWeight: FontWeight.bold,
      fontFamily: 'Cairo',
      color: color,
    ),
  );
}
