
import 'package:flutter/material.dart';
import 'package:oltp/models/QuestionModel.dart';
import 'package:oltp/models/StudentModel.dart';
import 'package:oltp/screens/TestPlatform.dart';

class Instructions extends StatefulWidget {

  String testID;
  bool isactive;
  bool isover;
  String instructions;
  String testName;
  List<Question> questions;
  String testTime;
  Student studentOne;
  Student studentTwo;
  int maxMembers;
  String maxQuestions;

  Instructions(this.testID,this.testName,this.isactive,this.isover,this.instructions,this.studentOne,this.studentTwo,this.maxMembers,this.questions,this.testTime,this.maxQuestions);

  @override
  _InstructionsState createState() => _InstructionsState();
}

class _InstructionsState extends State<Instructions> {
  DateTime _myTime;
  DateTime _ntpTime;
  @override
  Future<void> initState()  {
    widget.questions.shuffle();
    super.initState();
  }
  // gettime() async{
  //
  //   Response response=await get(Uri.parse('http://worldtimeapi.org/api/timezone/Asia/Kolkata'));
  //   Map data=jsonDecode(response.body);
  //   print(data);
  //
  //   String datetim=data['datetime'];
  //   String offset=data['utc_offset'].substring(1,3);
  //   print(datetim);
  //   print(offset);
  //   DateTime now=DateTime.parse(datetim);
  //   now=now.add(Duration(hours:int.parse(offset)));
  //   print(now);
  //
  //   // _myTime = await NTP.now();
  //   // final int offset = await NTP.getNtpOffset(localTime: DateTime.now());
  //   // _ntpTime = _myTime.add(Duration(milliseconds: offset));
  //   // print('Curent Time:$_myTime');
  //   // print('Network TIme:$_ntpTime');
  // }

  @override
  Widget build(BuildContext context) {
    //gettime();
    return Scaffold(
      backgroundColor: Color(0xff36393f),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.of(context).size.height*0.13),
        child: AppBar(
            backgroundColor: Color(0xff2f3136),
            automaticallyImplyLeading: false, // hides leading widget
            flexibleSpace: Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width*0.05,
                ),
                Container(
                    width:MediaQuery.of(context).size.width*0.1,child: Hero(tag:'logo',child: Image(image: AssetImage('assets/images/dlogo.png',),height: 120,))
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width*0.025,
                ),
                Container(
                  width:MediaQuery.of(context).size.width*0.675,
                  height: 100,
                  child: FittedBox(fit: BoxFit.scaleDown,child: Text(widget.testName.toUpperCase(),style: TextStyle(color: Colors.white70,fontSize:50,fontWeight: FontWeight.bold,letterSpacing: 0.5))),
                )
              ],
            )
        ),
      ),
      body: Column(
          children: [
      SizedBox(
      height: MediaQuery.of(context).size.height*0.02,
    ),
    Center(
    child: Container(
    width : MediaQuery.of(context).size.width * 0.5,
    margin: EdgeInsets.symmetric(horizontal: 20),
    decoration: BoxDecoration(
    color: Color(0xff2f3136),
    shape: BoxShape.rectangle,
    borderRadius: BorderRadius.circular(5.0),
    ),
    child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
    SizedBox(
    height: 15,
    ),
    Container(
    width : MediaQuery.of(context).size.width * 0.2,
    height: MediaQuery.of(context).size.height*0.05,
    decoration: BoxDecoration(
    shape: BoxShape.rectangle,
    borderRadius: BorderRadius.circular(5.0),
    color: Color(0xff145cae),
    ),
    child: FittedBox(fit:BoxFit.scaleDown,child: Text("INSTRUCTIONS",style: TextStyle(color: Colors.white70,fontSize: 18,letterSpacing: 1),textAlign: TextAlign.center,))
    ),

    SizedBox(
    height: MediaQuery.of(context).size.height*0.04,
    ),

      Container(
        width : MediaQuery.of(context).size.width * 0.45,
        height: MediaQuery.of(context).size.height*0.6,
        child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (OverscrollIndicatorNotification overScroll) {
              overScroll.disallowGlow();
              return false;
            },child: SingleChildScrollView(child: Text(widget.instructions==null?"":(String.fromCharCode(0x2022)+"  "+widget.instructions.replaceAll("^", "\n"+String.fromCharCode(0x2022)+"  ")),style: TextStyle(color: Colors.white70,fontSize: 20,fontWeight: FontWeight.w500,height: 1.5)))
        ),
      ),

    SizedBox(
      height: MediaQuery.of(context).size.height*0.04,
    ),
    ],
    ),
    ),
    ),
      SizedBox(
        height: MediaQuery.of(context).size.height*0.02,
      ),
    widget.isactive?Center(
    child: InkWell(
    onTap: ()async=>{
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) => TestPlatform(widget.testID,widget.testName,widget.studentOne,widget.studentTwo,widget.maxMembers,widget.questions,widget.testTime,widget.maxQuestions),
    )
    ),
    },
    child: Container(
    width : MediaQuery.of(context).size.width * 0.3,
    height: MediaQuery.of(context).size.height * 0.06,
    decoration: BoxDecoration(
    shape: BoxShape.rectangle,
    borderRadius: BorderRadius.circular(5.0),
    color: Color(0xff145cae),
    ),
    child: Center(
    child: Text("START TEST",style: TextStyle(color: Colors.white70,fontSize: 18,),textAlign: TextAlign.center,),
    )
    ),
    ),
    ):widget.isover?Container(
    width : MediaQuery.of(context).size.width * 0.3,
    height: MediaQuery.of(context).size.height * 0.06,
    decoration: BoxDecoration(
    shape: BoxShape.rectangle,
    borderRadius: BorderRadius.circular(5.0),
    color: Color(0xff145cae),
    ),
    child: Center(
    child: Text("Test is Over!",style: TextStyle(color: Colors.white70,fontSize: 18,),textAlign: TextAlign.center,),
    )
    ):
    Container(
        width : MediaQuery.of(context).size.width * 0.3,
        height: MediaQuery.of(context).size.height * 0.06,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.grey,
        ),
        child: Center(
          child: Text("Test Will Start at 19:00 IST",style: TextStyle(color: Colors.white,fontSize: 18,),textAlign: TextAlign.center,),
        )
    ),
    ],
    ),
    );
  }
}
