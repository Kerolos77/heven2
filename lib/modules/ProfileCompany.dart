import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../shared/cubit/main/mainCubit.dart';
import '../shared/cubit/main/mainStates.dart';

class ProfileUser extends StatelessWidget {
  const ProfileUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => MainCubit(),
      child: BlocConsumer<MainCubit, States>(
          listener: (BuildContext context, States state) {},
          builder: (BuildContext context, States state) {
            return Container(
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      CircleAvatar(
                        radius: 85,
                        backgroundColor: Colors.black45,
                      ),
                      CircleAvatar(
                        radius: 80,
                        backgroundColor: Colors.white,
                        child: Image(
                          image: AssetImage('images/heven logo.png'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
    );
  }
}
