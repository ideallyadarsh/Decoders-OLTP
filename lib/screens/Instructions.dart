
import 'package:flutter/material.dart';
import 'package:oltp/models/QuestionModel.dart';
import 'package:oltp/models/StudentModel.dart';
import 'package:oltp/screens/TestPlatform.dart';

class Instructions extends StatefulWidget {

  String testID;
  String instructions;
  String testName;
  List<Question> questions;
  String testTime;
  Student studentOne;
  Student studentTwo;
  int maxMembers;

  Instructions(this.testID,this.testName,this.instructions,this.studentOne,this.studentTwo,this.maxMembers,this.questions,this.testTime);

  @override
  _InstructionsState createState() => _InstructionsState();
}

class _InstructionsState extends State<Instructions> {

  @override
  void initState() {
    widget.questions.shuffle();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
        width : MediaQuery.of(context).size.width * 0.4,
        height: MediaQuery.of(context).size.height*0.6,
        child: Text(widget.instructions==null?"":(String.fromCharCode(0x2022)+"  "+widget.instructions.replaceAll("^", "\n"+String.fromCharCode(0x2022)+"  ")),style: TextStyle(color: Colors.white70,fontSize: 20,fontWeight: FontWeight.w500,height: 1.5)),
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
    Center(
    child: InkWell(
    onTap: ()async=>{
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) => TestPlatform(widget.testID,widget.testName,widget.studentOne,widget.studentTwo,widget.maxMembers,widget.questions,widget.testTime),
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
    ),
    ],
    ),
    );
  }
}
