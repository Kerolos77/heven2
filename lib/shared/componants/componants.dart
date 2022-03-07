import 'package:flutter/material.dart';
import 'package:heven2/modules/atendScreen.dart';

import 'package:heven2/shared/cubit/cubit.dart';
import 'package:intl/intl.dart';

Widget dfulttextfilde({
  required TextEditingController control,
  required TextInputType type,
  required String lable,
  required IconData icon,
  bool enablekey = false,
  ValueChanged? onsubmit,
  ValueChanged? onchange,
  GestureTapCallback? ontape,
  FormFieldValidator? validatetor,
}) =>
    TextFormField(
      controller: control,
      keyboardType: type,
      onChanged: onchange,
      onTap: ontape,
      validator: validatetor,
      onFieldSubmitted: onsubmit,
      readOnly: enablekey,
      decoration: InputDecoration(
        labelText: lable,
        labelStyle: TextStyle(color: Colors.white),
        filled: true,
        fillColor: Colors.black12,
        prefixIcon: /**/ Icon(
          icon,
          size: 20,
          color: Colors.white,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );

Widget itemnewemp(Map model, context, cubit cub) => Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        child: Row(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.black,
                  child: Text(
                    '${model['id']}',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                CircleAvatar(
                  radius: 7,
                  backgroundColor: Colors.white,
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                    end: 2,
                    bottom: 2,
                  ),
                  child: CircleAvatar(
                    radius: 5,
                    backgroundColor:
                        model['isatend'] == 1 ? Colors.green : Colors.red,
                  ),
                ),
              ],
              alignment: AlignmentDirectional.bottomEnd,
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                '${model['name']}',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                if (model['isatend'] == 0) {
                  print("press");
                  cub.insertatend(
                    date: "${DateFormat('yyyy-MM-dd').format(DateTime.now())}",
                    empid: model['id'],
                    endtime: "00:00AM",
                    starttime: "${DateFormat('hh:mma').format(DateTime.now())}",
                  );
                  cub.update(isatend: 1, id: model['id']);
                  print("isatend = ${model['isatend']}");
                  ScaffoldMessenger.of(context)
                      .showSnackBar(cub.snack("Presence ", Colors.green));
                } else
                  ScaffoldMessenger.of(context)
                      .showSnackBar(cub.snack("Presence ", Colors.red));
              },
              icon: Icon(
                Icons.access_time,
                color: Colors.green,
              ),
            ),
            IconButton(
              onPressed: () {
                if (model['isatend'] == 1) {
                  cubit.get(context).updateatend(
                      endtime: '${DateFormat('hh:mma').format(DateTime.now())}',
                      id: model['id'],
                      date:
                          '${DateFormat('yyyy-MM-dd').format(DateTime.now())}');
                  cub.update(isatend: 0, id: model['id']);
                  ScaffoldMessenger.of(context)
                      .showSnackBar(cub.snack("departure ", Colors.green));
                } else
                  ScaffoldMessenger.of(context)
                      .showSnackBar(cub.snack("departure ", Colors.red));
              },
              icon: Icon(
                Icons.access_time,
                color: Colors.red,
              ),
              disabledColor: Colors.grey,
            ),
            IconButton(
              onPressed: () {
                cub.getatend(cub.database, model['id']);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AtendScreen(
                            name: model['name'],
                            id: model['id'],
                            cub: cub,
                          )),
                );
              },
              icon: Icon(
                Icons.slideshow,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );

Widget itematend(Map model, context, cubit cub) => Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    '${model['date']}',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    '${model['starttime']}',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    '${model['endtime']}',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  '${cub.subTime(model['starttime'], model['endtime'])}',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

Widget dfultlogintextfilde({
  required TextEditingController control,
  required TextInputType type,
  required String lable,
  required IconData icon,
  bool enablekey = false,
  ValueChanged? onsubmit,
  ValueChanged? onchange,
  GestureTapCallback? ontape,
  FormFieldValidator? validatetor,
}) =>
    TextFormField(
      controller: control,
      keyboardType: type,
      onChanged: onchange,
      onTap: ontape,
      validator: validatetor,
      onFieldSubmitted: onsubmit,
      cursorColor: Colors.black,
      readOnly: enablekey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
          labelText: lable,
          labelStyle: TextStyle(color: Colors.black),
          filled: true,
          fillColor: Colors.white,
          prefixIcon: /**/ Icon(
            icon,
            size: 25,
            color: Colors.black,
          ),
          enabledBorder: OutlineInputBorder(
              //Outline border type for TextFeild
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(
                color: Colors.black,
                width: 2,
              )),
          focusedBorder: OutlineInputBorder(
              //Outline border type for TextFeild
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(
                color: Colors.black,
                width: 2,
              ))),
    );

Widget sufixlogintextfilde({
  required TextEditingController control,
  required TextInputType type,
  required String lable,
  required IconData prifixicon,
  required IconData sufixicon,
  required bool obscure,
  VoidCallback? onpresssufix,
  bool enablekey = false,
  ValueChanged? onsubmit,
  ValueChanged? onchange,
  GestureTapCallback? ontape,
  FormFieldValidator? validatetor,
}) =>
    TextFormField(
      controller: control,
      keyboardType: type,
      onChanged: onchange,
      onTap: ontape,
      validator: validatetor,
      onFieldSubmitted: onsubmit,
      readOnly: enablekey,
      obscureText: obscure,
      cursorColor: Colors.black,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
          labelText: lable,
          labelStyle: TextStyle(color: Colors.black),
          filled: true,
          fillColor: Colors.white,
          prefixIcon: /**/ Icon(
            prifixicon,
            size: 25,
            color: Colors.black,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              sufixicon,
              size: 25,
              color: Colors.black,
            ),
            onPressed: onpresssufix,
          ),
          enabledBorder: OutlineInputBorder(
              //Outline border type for TextFeild
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(
                color: Colors.black,
                width: 2,
              )),
          focusedBorder: OutlineInputBorder(
              //Outline border type for TextFeild
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(
                color: Colors.black,
                width: 2,
              ))),
    );

Widget defultBotton({required String text,required bool isdone, VoidCallback? onpress}) => Container(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(top: 1, bottom: 1, left: 20, right: 20),
        child: MaterialButton(
          onPressed: onpress,
          child: Text(
            text,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
      decoration: BoxDecoration(
        color: isdone?Colors.black:Colors.black26,
        borderRadius: BorderRadius.circular(20),
      ),
    );

Widget valedaterow({
  required bool flag,
  required String truetext,
  required String falsetext,
}) =>
    Row(
      children: [
        flag
            ? Icon(
                Icons.check_circle_outline,
                color: Colors.green,
              )
            : Icon(
                Icons.error_outline_outlined,
                color: Colors.red,
              ),
        Text(
          flag ? truetext:falsetext,
          style: TextStyle(color: flag ? Colors.black : Colors.red),
        ),
      ],
    );
