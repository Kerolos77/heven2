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
    return BlocConsumer<cubit,States>(
        listener: (BuildContext context,States state){},
        builder: (BuildContext context,States state){
          cubit cub=cubit.get(context);
          return Container(
            color: Colors.white,
            child: Center(
              child: ConditionalBuilder(
                condition:cub.emplloyeeName.length>0 ,
                builder: (context) =>ListView.separated(
                    itemBuilder: (BuildContext context, int index) => itemnewemp(cub.emplloyeeName[index],context,cub),
                    itemCount: cub.emplloyeeName.length,
                    separatorBuilder: (BuildContext context, int index) => SizedBox(height: 10,)

                ),
                fallback: (context) => CircularProgressIndicator(
                  color: Colors.black,
                )
              ),
            ),
          );

      }
    );
  }

}

