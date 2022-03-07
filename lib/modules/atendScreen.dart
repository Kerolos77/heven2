

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heven2/shared/componants/componants.dart';
import 'package:heven2/shared/cubit/cubit.dart';
import 'package:heven2/shared/cubit/heven_states.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

import '../mobile.dart';

class AtendScreen extends StatelessWidget {
  String name;
  int id;
  cubit cub;
  AtendScreen({
    required this.name,
    required this.id,
    required this.cub,
  }) ;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>cubit(),
      child: BlocConsumer<cubit,States>
        (
          listener: (BuildContext context,States state){},
          builder: (BuildContext context,States state){
            return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                  onPressed: (){
                    Navigator.pop(context);
                  },
                ),
                title: Text(name),
              ),
              body: Container(
                color: Colors.white,
                child: Center(
                  child: ConditionalBuilder(
                      condition:cub.atenddata.length>0 ,
                      builder: (context) =>ListView.separated(
                          itemBuilder: (BuildContext context, int index) => itematend(cub.atenddata[index],context,cub),
                          itemCount: cub.atenddata.length,
                          separatorBuilder: (BuildContext context, int index) => Padding(
                            padding: const EdgeInsets.only(right: 15,left: 15,top: 10,bottom: 10),
                            child: Container(width: double.infinity,height: 1,color: Colors.grey,),
                          ),
                      ),
                      fallback: (context) => //Center(child: Image(image: AssetImage('images/Add tasks-amico.png'),)),
                                  Center(child: Image(image: AssetImage('images/Add tasks-amico.png'),)),
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
                      _createPDF(cub);
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
  Future<void> _createPDF(cubit cub) async {
    PdfDocument document = PdfDocument();
    final page =document.pages.add();
    var data = cub.atenddata;
    String d ='    DATE           START        END          H\n\n';

    for(int i=0;i<data.length;i++){
      d+='${data[i]['date']}    ${data[i]['starttime']}    ${data[i]['endtime']}    ${cub.subTime(data[i]['starttime'], data[i]['endtime'])}\n';
    }
    page.graphics.drawString(d,PdfStandardFont(PdfFontFamily.helvetica, 27));
    List<int> bytes = document.save();
    document.dispose();
    saveAndLaunchFile(bytes, '${DateFormat('yyyy-MM-dd').format(DateTime.now())}${name}.pdf');

  }
}
