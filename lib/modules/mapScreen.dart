import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:heven2/shared/componants/componants.dart';

class MapScreen extends StatefulWidget {
  MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  var lat = LatLng(30.142990940582557, 31.327104605734345);
  TextEditingController mapController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: noConnectionCard(
        child: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: lat,
                zoom: 14.4746,
              ),
              markers: <Marker>{
                Marker(
                  markerId: const MarkerId('1'),
                  position: lat,
                ),
              },

              buildingsEnabled: true,
              circles: <Circle>{
                Circle(
                  circleId: const CircleId('1'),
                  center: lat,
                  radius: 20,
                  fillColor: Colors.blue.withOpacity(0.2),
                  strokeColor: Colors.blue,
                  strokeWidth: 1,
                ),
              },
              mapToolbarEnabled: true,
              mapType: MapType.normal,
              onTap: (LatLng latLng) {
                print(latLng);
                setState(() {
                  lat = latLng;
                });
              },
              rotateGesturesEnabled: true,
              scrollGesturesEnabled: true,
              zoomControlsEnabled: false,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: sufixTextFiled(
                  iconColor: Colors.blue,
                  control: mapController,
                  type: TextInputType.text,
                  hint: 'ابحث عن موقعك',
                  prifixIcon: Icons.arrow_back_ios,
                  onPressPrifix: () {
                    Navigator.pop(context);
                  },
                  sufixIcon: CupertinoIcons.search,
                  obscure: false),
            ),
            Stack(
              children: [
                SizedBox(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: arabicText(
                          text: 'حدد موقع شركتك باستخدام المارك الاحمر',
                          size: 10,
                          color: Colors.white,
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      clipBehavior: Clip.hardEdge,
                      color: Colors.grey,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 15.0, left: 15.0),
                      child: Card(
                        child: Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          child: MaterialButton(
                            onPressed: () {},
                            child: arabicText(text: 'أحفظ'),
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        clipBehavior: Clip.hardEdge,
                        elevation: 10,
                        color: Colors.blue.shade100,
                      ),
                    ),
                  ],
                ),
              ],
              alignment: Alignment.bottomCenter,
            ),
          ],
        ),
      ),
    );
  }
}
