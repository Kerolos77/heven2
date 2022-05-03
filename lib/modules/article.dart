import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heven2/shared/cubit/main/mainCubit.dart';
import 'package:heven2/shared/cubit/main/mainStates.dart';

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
      create: (BuildContext context) => MainCubit(),
      child: BlocConsumer<MainCubit, States>(
          listener: (BuildContext context, States state) {},
          builder: (BuildContext context, States state) {
            return Scaffold(
              appBar: AppBar(
                title: Text("Flutter++++++++++"),
              ),
              body: Center(
                  child: defaultButton(
                      isDone: true,
                      text: 'Login',
                      onPress: () {
                        print("" == null);
                      })),
            );
          }),
    );
  }
}
