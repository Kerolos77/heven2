import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heven2/shared/cubit/cubit.dart';
import 'package:heven2/shared/cubit/heven_states.dart';
import 'package:intl/intl.dart';

import '../shared/componants/componants.dart';

class article extends StatefulWidget {
  const article({Key? key}) : super(key: key);

  @override
  _articleState createState() => _articleState();
}

class _articleState extends State<article> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => cubit(),
      child: BlocConsumer<cubit, States>(
          listener: (BuildContext context, States state) {
        print(state);
        if (state is GetEmpSucsessState)
          print(cubit.get(context).empModelList[0]["phone"]);
      }, builder: (BuildContext context, States state) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Flutter"),
          ),
          body: Center(
              child: defultBotton(
                  isdone: true,
                  text: 'Login',
                  onpress: () {
                    String d = "09:00AM";
                    String s = DateFormat("hh:mma").format(DateTime.now());
                    print(s);
                    print(subTime(d, s));
                  })),
        );
      }),
    );
  }

  String subTime(String startTime, String endTime) {
    DateTime startDate = DateFormat("hh:mma").parse(startTime);
    DateTime endDate = DateFormat("hh:mma").parse(endTime);
// Get the Duration using the diferrence method
//     Duration diff = endDate.difference(startDate);
//     String dif = '${diff.inHours}:${diff.inMinutes % 60}';
//     print(endDate.hour - startDate.hour);
//     print(endDate.minute - startDate.minute);
    return '${endDate.hour - startDate.hour}:${endDate.minute - startDate.minute}';
  }
}
