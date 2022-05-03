import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heven2/calculate/CalculateSalary.dart';
import 'package:heven2/calculate/CalculateTime.dart';
import 'package:heven2/shared/componants/componants.dart';
import 'package:heven2/shared/cubit/attend/attendCubit.dart';
import 'package:intl/intl.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../mobile.dart';
import '../shared/cubit/attend/attendStates.dart';

class AttendScreen extends StatelessWidget {
  String name;

  String id;

  // MainCubit cub;

  AttendScreen({
    Key? key,
    required this.name,
    required this.id,
    // required this.cub,
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
              title: Text(name),
            ),
            body: Container(
              color: Colors.white,
              child: Center(
                child: ConditionalBuilder(
                  condition: state is! GetLoadingAttendState,
                  builder: (context) => attendCub.attendModelList.isEmpty
                      ? Center(
                          child: Icon(
                            Icons.announcement_outlined,
                            color: Colors.grey.shade300,
                            size: 200,
                          ),
                        )
                      : LiquidPullToRefresh(
                          backgroundColor: Colors.white,
                          color: Colors.grey.shade500,
                          showChildOpacityTransition: false,
                          onRefresh: () async {
                            attendCub.getAttend(
                                date: DateFormat('yyyy-MM-dd')
                                    .format(DateTime.now()),
                                empId: id);
                            print(attendCub.attendModelList);
                          },
                          child: ListView.separated(
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
                    child: CircularProgressIndicator(),
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
                    _createPDF(attendCub);
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

  Future<void> _createPDF(AttendCubit attendCub) async {
    String timeCount = '0:0';
    for (var i = 0; i < attendCub.attendModelList.length; i++) {
      timeCount = CalculateTime.totalTime(
          time: attendCub.attendModelList[i]['timeInDay'],
          totalTime: timeCount);
    }
    timeCount = CalculateTime.splitTime(time: timeCount);
    timeCount = CalculateSalary.calculateSalary(time: timeCount);
    final pdf = pw.Document();
    pdf.addPage(pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(10), // This is the page margin
        build: (pw.Context context) {
          return <pw.Widget>[
            pw.Header(
              level: 0,
              child: pw.Text(
                'Attendance Report \n\nname : $name\n',
                style: pw.TextStyle(
                  fontSize: 12,
                  fontWeight: pw.FontWeight.bold,
                  height: 1.5,
                ),
              ),
            ),
            pw.Table.fromTextArray(
              context: context,
              data: [
                ['Num', 'Date', 'Start Time', 'End Time', 'Duration'],
                for (var i = 0; i < attendCub.attendModelList.length; i++)
                  [
                    i + 1,
                    attendCub.attendModelList[i]['date'],
                    attendCub.attendModelList[i]['startTime'],
                    attendCub.attendModelList[i]['endTime'],
                    attendCub.attendModelList[i]['timeInDay'],
                  ],
              ],
              cellAlignment: pw.Alignment.center,
              cellStyle: const pw.TextStyle(fontSize: 12),
            ),
            pw.Text(
              '$timeCount',
              style: pw.TextStyle(
                fontSize: 20,
                fontWeight: pw.FontWeight.bold,
                height: 1.5,
              ),
            ),
          ];
        }));
    saveAndLaunchFile(await pdf.save(),
        'Attend Repo(${DateFormat('yyyy-MM-dd').format(DateTime.now())}) $id .pdf');
  }
}
