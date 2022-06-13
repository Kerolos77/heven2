import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heven2/shared/componants/componants.dart';
import 'package:heven2/shared/cubit/attend/attendCubit.dart';
import 'package:intl/intl.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import '../pdfHelper/PdfHelper.dart';
import '../shared/cubit/attend/attendStates.dart';

class AttendScreen extends StatelessWidget {
  String name;

  String id;

  int Salary;

  // MainCubit cub;

  AttendScreen({
    Key? key,
    required this.name,
    required this.id,
    required this.Salary,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AttendCubit()
        ..getAttend(
            empId: id, date: DateFormat('yyyy-MM-dd').format(DateTime.now())),
      child: BlocConsumer<AttendCubit, AttendState>(
        listener: (BuildContext context, AttendState state) {
          print(state);
        },
        builder: (BuildContext context, AttendState state) {
          AttendCubit attendCub = AttendCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: Text(
                name,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {},
                  child: Text(
                    attendCub.publicDate,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.date_range,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2020),
                      lastDate: DateTime.now(),
                      builder: (context, child) {
                        return Theme(
                          data: Theme.of(context).copyWith(
                            colorScheme: ColorScheme.light(
                              primary: Colors.grey.shade300,
                              // header background color
                              onPrimary: Colors.black,
                              // header text color
                              onSurface: Colors.black, // body text color
                            ),
                            textButtonTheme: TextButtonThemeData(
                              style: TextButton.styleFrom(
                                primary: Colors.black, // button text color
                              ),
                            ),
                          ),
                          child: child!,
                        );
                      },
                    ).then((date) {
                      print(date);
                      attendCub.ChangeDate(
                          date: DateFormat('yyyy-MM').format(date!));
                      attendCub.getAttend(
                          empId: id, date: DateFormat('yyyy-MM').format(date));
                    });
                  },
                ),
              ],
            ),
            body: Container(
              color: Colors.white,
              child: Center(
                child: ConditionalBuilder(
                  condition: state is! GetLoadingAttendState,
                  builder: (context) => LiquidPullToRefresh(
                    backgroundColor: Colors.white,
                    color: Colors.grey.shade500,
                    showChildOpacityTransition: false,
                    onRefresh: () async {
                      attendCub.getAttend(
                          date: DateFormat('yyyy-MM-dd').format(DateTime.now()),
                          empId: id);
                      print(attendCub.attendModelList);
                    },
                    child: attendCub.attendModelList.isEmpty
                        ? Center(
                            child: Icon(
                              Icons.announcement_outlined,
                              color: Colors.grey.shade300,
                              size: 200,
                            ),
                          )
                        : ListView.separated(
                            itemBuilder: (BuildContext context, int index) =>
                                itemAttend(attendCub.attendModelList[index]),
                            itemCount: attendCub.attendModelList.length,
                            separatorBuilder:
                                (BuildContext context, int index) => Padding(
                              padding: const EdgeInsets.only(
                                  right: 15, left: 15, top: 10, bottom: 10),
                              child: Container(
                                width: double.infinity,
                                height: 1,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                  ),
                  fallback: (context) => const Center(
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
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
                    PdfHelper.createPDF(attendCub, name, id, Salary);
                  },
                  child: Icon(
                    Icons.picture_as_pdf_outlined,
                    color: Colors.black,
                    size: 30,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
