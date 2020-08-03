
import 'package:flutter/material.dart';

class Instructions extends StatefulWidget {
  @override
  _InstructionsState createState() => _InstructionsState();
}

class _InstructionsState extends State<Instructions> {

  String ins="This is a 30 minute test with 30 questions. ^Each question carries +1 mark for right answer and -0.33 for wrong answer. ^0 mark will be awarded for non attempted questions. ^The timer will start as soon as you click the Start Test button below. ^Please do not use keyboard from here onwards ^Use only mouse for any activity. ^Any use of keyboard will be seen as a cheating attempt ^The scores will be automatically submitted as soon as time runs out,or you press the Submit Button, which ever happens first. ^Each question has four options.Only one of them is correct answer.There are no multiple correct answers. ^You can switch from one question to the next or previous question using Next or Previous button. ^You can use Unanswer button to remove your selected answer for any question.";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff36393f),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0),
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
                  child: FittedBox(fit: BoxFit.scaleDown,child: Text("Recruitment - 2021 (2nd Years)".toUpperCase(),style: TextStyle(color: Colors.white70,fontSize:50,fontWeight: FontWeight.bold,letterSpacing: 0.5))),
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
        child: Text(String.fromCharCode(0x2022)+"  "+ins.replaceAll("^", "\n"+String.fromCharCode(0x2022)+"  "),style: TextStyle(color: Colors.white70,fontSize: 20,fontWeight: FontWeight.w500,height: 1.5)),
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
