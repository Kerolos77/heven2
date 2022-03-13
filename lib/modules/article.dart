import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heven2/shared/cubit/cubit.dart';
import 'package:heven2/shared/cubit/heven_states.dart';
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:syncfusion_flutter_pdf/pdf.dart';

import '../mobile.dart';

class article extends StatefulWidget {
  const article({Key? key}) : super(key: key);

  @override
  _articleState createState() => _articleState();
}

class _articleState extends State<article> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => cubit(),
      child: BlocConsumer<cubit, States>(
          listener: (BuildContext context, States state) {},
          builder: (BuildContext context, States state) {
            cubit cub = cubit.get(context);
            final _formKey = GlobalKey<FormState>();
            return Scaffold(
              appBar: AppBar(
                title: Text("Flutter"),
              ),
              body: Center(
                child: RaisedButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text("Open Popup"),
                                Text("Open Popup"),
                                Text("Open Popup"),
                                Text("Open Popup"),
                                Text("Open Popup"),
                              ],
                            ),
                          );
                        });
                  },
                  child: Text("Open Popup"),
                ),
              ),
            );
          }),
    );
  }
}
