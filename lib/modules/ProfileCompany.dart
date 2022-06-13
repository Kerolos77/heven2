import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

import '../shared/componants/componants.dart';
import '../shared/cubit/main/mainCubit.dart';
import '../shared/cubit/main/mainStates.dart';

class ProfileUser extends StatefulWidget {
  const ProfileUser({Key? key}) : super(key: key);

  @override
  State<ProfileUser> createState() => _ProfileUserState();
}

class _ProfileUserState extends State<ProfileUser> {
  late File imageFile = File('images/Image folder-amico.png');

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => MainCubit(),
      child: BlocConsumer<MainCubit, States>(
          listener: (BuildContext context, States state) {},
          builder: (BuildContext context, States state) {
            return Scaffold(
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 5.0),
                          child: Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.08,
                              ),
                              Card(
                                child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.25,
                                  height:
                                      MediaQuery.of(context).size.height * 0.09,
                                  child: Image.asset(imageFile.path,
                                      fit: BoxFit.fill),
                                ),
                                elevation: 5,
                                color: Colors.white,
                                clipBehavior: Clip.none,
                                shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                ),
                              ),
                              Expanded(
                                child: Center(
                                  child: Column(
                                    children: [
                                      arabicText(
                                          text: "Cpmpany Name", size: 20),
                                      arabicText(
                                          text: "kerolofaie@gmaie.com",
                                          size: 10),
                                      arabicText(text: "0123456789", size: 10),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        elevation: 5,
                        color: Colors.blue.shade50,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          arabicText(text: 'مرتب شهري', color: Colors.blue),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.05,
                          ),
                          arabicText(text: 'نوع المرتب'),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          arabicText(text: '8', color: Colors.blue),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.05,
                          ),
                          arabicText(text: 'ساعات العمل'),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          arabicText(text: '1', color: Colors.blue),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.08,
                          ),
                          arabicText(text: 'الاجازات الاسبوعية'),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Card(
                        child: SizedBox(
                          child: GoogleMap(
                            initialCameraPosition: const CameraPosition(
                              target: LatLng(
                                31.977,
                                35.928,
                              ),
                              zoom: 12,
                            ),
                            markers: {
                              const Marker(
                                markerId: MarkerId('1'),
                                position: LatLng(
                                  31.977,
                                  35.928,
                                ),
                              ),
                            },
                            zoomControlsEnabled: false,
                          ),
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.4,
                        ),
                        elevation: 10,
                        clipBehavior: Clip.hardEdge,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }

  Future<void> pickImageFromGallery() async {
    final File imgFile = await ImagePicker.platform
        .pickImage(source: ImageSource.gallery) as File;
    setState(() => imageFile = imgFile);
  }
}
