import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heven2/shared/componants/componants.dart';
import 'package:heven2/shared/cubit/cubit.dart';
import 'package:heven2/shared/cubit/heven_states.dart';

class home extends StatelessWidget {

  TextEditingController namecontrol = new TextEditingController();
  TextEditingController phonecontrol = new TextEditingController();
  TextEditingController idcontrol = new TextEditingController();
  TextEditingController salarycontrol = new TextEditingController();
  var scaffoldkey = GlobalKey<ScaffoldState>();
  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>cubit()..create(),
      child: BlocConsumer <cubit,States>(
        listener: (context, state) {
          if(state is CreateEmpSucsessState ){
            Navigator.pop(context);
            toast(msg: 'Done', backcolor: Colors.green, textcolor: Colors.black);
          }
          if(state is CreateEmpErrorState ){
            toast(msg: state.error.toString(), backcolor: Colors.red, textcolor: Colors.black);
          }
        },
        builder: (context, state) {
          cubit cub = cubit.get(context);

          return Scaffold(
            key: scaffoldkey,
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                cub.apptitle[cub.cruntindex],
              ),

            ),
            drawer: Drawer(
              child: Column(
                children: [
                  SafeArea(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              CircleAvatar(
                                radius: 50,
                                backgroundColor: Colors.black,
                                child: Image(image: AssetImage('images/Add tasks-amico.png'),),
                              ),

                            ],
                            alignment: AlignmentDirectional.bottomEnd,
                          ),
                        ],
                      ),
                    ),
                  )

                ],
              ),
            ),
            body: ConditionalBuilder(
              condition:States is! GetDataBaseloadingState ,
              builder:(context)=> cub.screens[cub.cruntindex],
              fallback: (context)=> Center(child: CircularProgressIndicator()),
            ),
            floatingActionButton: Stack(
              children: [
                CircleAvatar(
                  radius: 24.5,
                  backgroundColor: Colors.white,
                ),
                FloatingActionButton(
                  onPressed: () {
                    if (cub.fbflag) {
                      if (formkey.currentState!.validate()) {
                        cub.CreateEmp(
                            name: namecontrol.text,
                            salary: salarycontrol.text,
                            phone: phonecontrol.text,
                            ID: idcontrol.text,
                            isatend: 0
                        );
                      }
                    } else {
                       namecontrol.text = "";
                       salarycontrol.text="";
                       idcontrol.text='';
                       phonecontrol.text='';
                       scaffoldkey.currentState?.showBottomSheet(
                             (context) => SingleChildScrollView(
                          child: Container(
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Form(
                                  key: formkey,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SizedBox(
                                        height: 15,
                                      ),
                                      dfulttextfilde(
                                          type: TextInputType.name,
                                          control: namecontrol,
                                          icon: Icons.title,
                                          lable: 'Name',
                                          validatetor: (value) {
                                            if (value.isEmpty)
                                              return 'Cann be Empty';
                                          }),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      dfulttextfilde(
                                          type: TextInputType.number,
                                          control: phonecontrol,
                                          icon: Icons.call,
                                          lable: 'Phone',
                                          validatetor: (value) {
                                            if (value.isEmpty)
                                              return 'Cann be Empty';
                                          }),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      dfulttextfilde(
                                          type: TextInputType.number,
                                          control: idcontrol,
                                          icon: Icons.card_membership_outlined,
                                          lable: 'Nathonal ID',
                                          validatetor: (value) {
                                            if (value.isEmpty)
                                              return 'Cann be Empty';
                                          }),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      dfulttextfilde(
                                          type: TextInputType.number,
                                          control: salarycontrol,
                                          icon: Icons.monetization_on_outlined,
                                          lable: 'Salary by week',
                                          validatetor: (value) {
                                            if (value.isEmpty)
                                              return 'Cann be Empty';
                                          }),
                                     ],
                                  ),
                                ),
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.black12,
                                  borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(0),
                                      bottomLeft: Radius.circular(0),
                                      topRight: Radius.circular(30),
                                      topLeft: Radius.circular(30)))),
                        ),
                      ).closed.then((value) {

                         cub.changeBottomSheetState(isshow: false, icon: Icons.edit);
                      });
                       cub.changeBottomSheetState(isshow: true, icon: Icons.add);
                    }
                  },
                  mini: true,
                  child: Icon(
                    cub.fbicon,
                  ),
                ),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              elevation: 0.0,
              selectedItemColor: Colors.black,
              unselectedItemColor: Colors.black26,
              type: BottomNavigationBarType.fixed,
              currentIndex: cub.cruntindex,
              onTap: (index){
                cub.changeindex(index);
              },
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.timelapse),
                    label: 'Attendans'
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.article),
                    label: 'Article'
                )
              ],

            ),
          );

        },
      ),
    );
  }
}

