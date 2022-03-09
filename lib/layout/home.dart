import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heven2/shared/componants/componants.dart';
import 'package:heven2/shared/cubit/cubit.dart';
import 'package:heven2/shared/cubit/heven_states.dart';

class home extends StatelessWidget {

  TextEditingController namecontrol = new TextEditingController();
  var scaffoldkey = GlobalKey<ScaffoldState>();
  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>cubit()..create(),
      child: BlocConsumer <cubit,States>(
        listener: (context, state) {
          if(state is InsertDataBaseState ){
            Navigator.pop(context);
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
                  Image(
                    image: AssetImage('images/Movie Night-cuate.png'),
                    height: 250,
                  ),
                  SingleChildScrollView(
                    child: Column(
                      children: [

                        itemmenu(titel: 'Profil', icon: Icons.person_outline, iconcolor: Colors.cyan),
                        SizedBox(height: 20,),
                        itemmenu(titel: 'Wish List', icon: Icons.favorite_outline_outlined, iconcolor: Colors.cyan),
                        SizedBox(height: 20,),
                        itemmenu(titel: 'Downloads', icon: Icons.download_outlined, iconcolor: Colors.cyan),
                        SizedBox(height: 20,),
                        itemmenu(titel: 'Settings', icon: Icons.settings, iconcolor: Colors.cyan),
                      ],
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
                  elevation: 10,
                  onPressed: () {
                    if (cub.fbflag) {
                      if (formkey.currentState!.validate()) {

                        cub.insert(
                            name: namecontrol.text,
                            isatend: 0
                        );
                      }
                    } else {
                       namecontrol.text = "";
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
                                          type: TextInputType.emailAddress,
                                          control: namecontrol,
                                          icon: Icons.title,
                                          lable: 'Emplloy Name',
                                          validatetor: (value) {
                                            if (value.isEmpty)
                                              return 'Emplloy Name must not be empty';
                                            return null;
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

