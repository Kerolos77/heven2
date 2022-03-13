import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
        labelStyle: TextStyle(color: Colors.black),
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

Widget itemnewemp(Map model, context, cubit cub) => Padding(
      padding: const EdgeInsets.only(top: 5,bottom: 5,left: 10,right: 10),
      child: GestureDetector(
        onTap: (){
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Name : ${model['name']}',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10,),
                      Text(
                        'Phone : 01225536602',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10,),
                      Text(
                        'ID : 29912231401235',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                    ],
                  ),
                );
              });
        },
        child: Material(
          elevation:15,
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [

                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${model['name']}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '29912231401235',
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
                        toast(msg: 'Acceptance', backcolor: Colors.green, textcolor: Colors.black);

                      } else
                        toast(msg: 'Reject', backcolor: Colors.red, textcolor: Colors.black);

                    },
                    icon: Icon(
                      Icons.access_time,
                      color: Colors.green.shade300,
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
                        toast(msg: 'Acceptance', backcolor: Colors.green, textcolor: Colors.black);
                      } else
                        toast(msg: 'Reject', backcolor: Colors.red, textcolor: Colors.black);
                    },
                    icon: Icon(
                      Icons.access_time,
                      color: Colors.red.shade200,
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
            decoration: BoxDecoration(
              color: Colors.white,
              // borderRadius: BorderRadius.circular(10),
              border: Border(
                bottom: BorderSide(width: 3.0, color: model['isatend'] == 1 ? Colors.green.shade300 : Colors.red.shade200 ),
                // color: model['isatend'] == 1 ? Colors.green : Colors.red,
                // width: 2
              ),
            ),
          ),
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
                      color: Colors.green.shade300,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    '${model['endtime']}',
                    style: TextStyle(
                      color: Colors.red.shade200,
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

Widget itemmenu({
  required String titel,
  required IconData icon,
  required Color iconcolor,
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
                color: iconcolor,
                size: 30,
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                titel,
                style: TextStyle(
                  fontSize: 20,
                ),
              )
            ],
          ),
        ),
        decoration: BoxDecoration(
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
  required Color backcolor,
  required Color textcolor,
})=>Fluttertoast.showToast(
msg: "Done",
toastLength: Toast.LENGTH_LONG,
gravity: ToastGravity.BOTTOM,
timeInSecForIosWeb: 1,
backgroundColor: backcolor,
textColor: textcolor,
);