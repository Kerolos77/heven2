import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heven2/shared/componants/componants.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import '../shared/cubit/emp/empCubit.dart';
import '../shared/cubit/emp/empStates.dart';

class Employ extends StatelessWidget {
  Employ({Key? key}) : super(key: key);
  TextEditingController nameControl = TextEditingController();
  TextEditingController phoneControl = TextEditingController();
  TextEditingController nidControl = TextEditingController();
  TextEditingController salaryControl = TextEditingController();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => EmpCubit()..getEmp(),
      child: BlocConsumer<EmpCubit, EmpState>(
          listener: (BuildContext context, EmpState state) {
        print(state);
        if (state is CreateSuccessEmpState) {
          Navigator.pop(context);
          toast(
              msg: 'تم إضافة الموظف بنجاح',
              backColor: Colors.grey.shade300,
              textColor: Colors.black);
        }
        if (state is CreateErrorEmpState) {
          toast(
              msg: state.error.toString(),
              backColor: Colors.grey.shade300,
              textColor: Colors.black);
        }
      }, builder: (BuildContext context, EmpState state) {
        EmpCubit empCub = EmpCubit.get(context);
        return Scaffold(
          key: scaffoldKey,
          backgroundColor: Colors.blue.shade50,
          body: Center(
            child: ConditionalBuilder(
              condition: state is! GetLoadingEmpState,
              builder: (context) => empCub.empModelList.isEmpty
                  ? const Center(
                      child: Image(
                      image: AssetImage('images/Add User-pana.png'),
                    ))
                  : LiquidPullToRefresh(
                      backgroundColor: Colors.white,
                      color: Colors.grey.shade500,
                      showChildOpacityTransition: false,
                      onRefresh: () async {
                        empCub.getEmp();
                      },
                      child: ListView.builder(
                        itemBuilder: (BuildContext context, int index) =>
                            itemNewEmp(empCub.empModelList[index], context),
                        itemCount: empCub.empModelList.length,
                      ),
                    ),
              fallback: (context) => const Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              ),
            ),
          ),
          bottomNavigationBar: Container(
            height: 35,
            color: Colors.grey.shade300,
          ),
          floatingActionButtonLocation: empCub.floatButtonFlag
              ? FloatingActionButtonLocation.centerDocked
              : FloatingActionButtonLocation.startDocked,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              if (empCub.floatButtonFlag) {
                if (formKey.currentState!.validate()) {
                  empCub.createEmp(
                    name: nameControl.text,
                    salary: salaryControl.text,
                    phone: phoneControl.text,
                    nId: nidControl.text,
                  );
                }
              } else {
                nameControl.text = "";
                salaryControl.text = "";
                nidControl.text = '';
                phoneControl.text = '';
                scaffoldKey.currentState
                    ?.showBottomSheet(
                      (context) => bottomSheet(
                          key: formKey,
                          nameControl: nameControl,
                          salaryControl: salaryControl,
                          nidControl: nidControl,
                          phoneControl: phoneControl),
                    )
                    .closed
                    .then((value) {
                  empCub.changeBottomSheetState(icon: Icons.edit, flag: false);
                });
                empCub.changeBottomSheetState(icon: Icons.edit, flag: true);
              }
            },
            elevation: 8,
            heroTag: "fabEmp",
            backgroundColor: Colors.grey.shade300,
            mini: true,
            child: const Icon(
              Icons.add,
              size: 25,
            ),
          ),
        );
      }),
    );
  }
}
