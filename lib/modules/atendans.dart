import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heven2/shared/componants/componants.dart';
import 'package:heven2/shared/cubit/cubit.dart';
import 'package:heven2/shared/cubit/heven_states.dart';

class atendans extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<cubit, States>(
        listener: (BuildContext context, States state) {
      print(state);
    }, builder: (BuildContext context, States state) {
      cubit cub = cubit.get(context);
      return Container(
        color: Colors.white,
        child: Center(
          child: ConditionalBuilder(
            condition: cub.empModelList.length > 0,
            builder: (context) => RefreshIndicator(
              color: Colors.black,
              onRefresh: () async {
                cub.GetEmp();
              },
              child: ListView.separated(
                  itemBuilder: (BuildContext context, int index) =>
                      itemnewemp(cub.empModelList[index], context, cub),
                  itemCount: cub.empModelList.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      SizedBox(
                        height: 10,
                      )),
            ),
            fallback: (context) => cub.empModelList.length == 0
                ? Center(
                    child: Image(
                    image: AssetImage('images/Add User-pana.png'),
                  ))
                : Center(
                    child: CircularProgressIndicator(),
                  ),
          ),
        ),
      );
    });
  }
}
