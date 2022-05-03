import 'package:animated_stack/animated_stack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heven2/shared/componants/componants.dart';
import 'package:heven2/shared/cubit/main/mainCubit.dart';
import 'package:heven2/shared/cubit/main/mainStates.dart';

import '../modules/login.dart';
import '../shared/Network/local/cache_helper.dart';

class Home extends StatelessWidget {
  TextEditingController nameControl = TextEditingController();
  TextEditingController phoneControl = TextEditingController();
  TextEditingController nidControl = TextEditingController();
  TextEditingController salaryControl = TextEditingController();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();

  Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => MainCubit(),
      child: BlocConsumer<MainCubit, States>(
        listener: (context, state) {
          if (state is LogOutSucsessState) {
            CacheHelper.putData(key: "user", value: "").then((value) {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Login()));
            });
            toast(
                msg: 'LogOut Success',
                backColor: Colors.grey.shade300,
                textColor: Colors.black);
          }
        },
        builder: (context, state) {
          MainCubit cub = MainCubit.get(context);
          return AnimatedStack(
            scaleHeight: 40,
            scaleWidth: 40,
            backgroundColor: Colors.grey.shade300,
            fabBackgroundColor: Colors.grey.shade300,
            fabIconColor: Colors.black,
            buttonIcon: Icons.home_outlined,
            animateButton: false,
            columnWidget: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    cub.changeIndex(0);
                  },
                  icon: const Icon(
                    Icons.pending_actions,
                    size: 20,
                  ),
                ),
                const SizedBox(height: 20),
                IconButton(
                  onPressed: () {
                    cub.changeIndex(1);
                  },
                  icon: Icon(
                    cub.currentIndex == 1 ? Icons.person : Icons.person_outline,
                    size: 20,
                  ),
                ),
                const SizedBox(height: 20),
                IconButton(
                  onPressed: () {
                    cub.changeIndex(2);
                  },
                  icon: Icon(
                    cub.currentIndex == 2 ? Icons.edit : Icons.edit_outlined,
                    size: 20,
                  ),
                ),
                const SizedBox(height: 20),
                IconButton(
                  onPressed: () {
                    cub.changeIndex(3);
                  },
                  icon: Icon(
                    cub.currentIndex == 3
                        ? Icons.article
                        : Icons.article_outlined,
                    size: 20,
                  ),
                ),
              ],
            ),
            bottomWidget: Container(),
            foregroundWidget: Scaffold(
              key: scaffoldKey,
              appBar: AppBar(
                centerTitle: true,
                title: Text(
                  cub.appTitle[cub.currentIndex],
                ),
                leading: IconButton(
                  icon: const Icon(Icons.logout),
                  onPressed: () {
                    cub.logout();
                  },
                ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              body: cub.screens[cub.currentIndex],
            ),
          );
        },
      ),
    );
  }
}
