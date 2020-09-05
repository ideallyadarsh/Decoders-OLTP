import 'dart:async';
import 'dart:ui';
import 'dart:html' as html;

import 'package:flutter/material.dart';
import 'package:oltp/models/QuestionModel.dart';
import 'package:oltp/models/StudentModel.dart';
import 'package:oltp/screens/FinishTest.dart';
import 'package:oltp/screens/widgets/QuestionPage.dart';

class TestPlatform extends StatefulWidget {
  String testID;
  List<Question> questions;
  String testTime;
  String testName;
  Student studentOne;
  Student studentTwo;
  int maxMembers;
  String maxQuestions;

  TestPlatform(this.testID,this.testName, this.studentOne,this.studentTwo,this.maxMembers,this.questions,this.testTime,this.maxQuestions);

  @override
  _TestPlatformState createState() => _TestPlatformState();
}

class _TestPlatformState extends State<TestPlatform> {
  ScrollController _controller;
  String ques="Which of the followings is correct for a function definition along with storage class specifier in C language?Which of the followings is correct for a function definition along with storage class specifier in C language?";
  String code="#include&lt;stdio.h&gt;\nInt * arrPtr[5];\nint main()\n{\nint a;\nint x;\nif(*(arrPtr+2) == *(arrPtr+4))\n{\nprintf(“Decoders”);\n}\nelse\n{\nprintf(“Sit”);\n}\nreturn 0;\n}\n#include&lt;stdio.h&gt;\nInt * arrPtr[5];\nint main()\n{\nint a;\nint x;\nif(*(arrPtr+2) == *(arrPtr+4))\n{\nprintf(“Decoders”);\n}\nelse\n{\nprintf(“Sit”);\n}\nreturn 0;\n}";
double _offset = 0;
var numLines;

  PageController _QuestionsController = PageController(
    initialPage: 0,
  );
  Timer _timer;
  int _secondsleft = 900;
  int totalTime;
  var maxQuestions=5;
  var currentPageValue= 0;
  var answerArray = new List(50);
  var questionsArray = new List(50);
  var answeredCount =0;
  int attendedCount=1;
  var attended = new List(50);

  void gotoNextPage()
  {
    print(currentPageValue);
    if(currentPageValue<maxQuestions-1) {
      if(attended[currentPageValue+1]==0)
        {
          attended[currentPageValue+1]=1;
          attendedCount++;
        }
      _QuestionsController.jumpToPage(currentPageValue + 1);

    }
  }
  void gotoPreviousPage()
  {
    if(currentPageValue>0) {
      if(attended[currentPageValue-1]==0)
      {
        attended[currentPageValue-1]=1;
        attendedCount++;
      }
      _QuestionsController.jumpToPage(currentPageValue - 1);
    }
  }

  void unAnswer()
  {
    if(currentPageValue>=0&&currentPageValue<maxQuestions)
      if(answerArray[currentPageValue]!=0) {
        answerArray[currentPageValue] = 0;
        answeredCount--;
      }
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) => setState(
            () {
          if (_secondsleft < 1) {
            timer.cancel();
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) => FinishTest(widget.testID,widget.studentOne,widget.studentTwo,widget.maxMembers,answerArray,questionsArray,maxQuestions),
            )
            );
          } else {
            _secondsleft = _secondsleft - 1;
          }
        },
      ),
    );
  }

  void onAnswerDataChange(int newData,int position) {

    setState(() {
      if(answerArray[position]==0)
        answeredCount++;
      answerArray[position] = newData;

    });
    print("ans"+answeredCount.toString());
  }

  @override
  void initState() {
    _QuestionsController.addListener(() {
      setState(() {
        print(_QuestionsController.page);
        currentPageValue = _QuestionsController.page.floor();
      });
    });
    for(var i=0;i<50;i++) {
      answerArray[i] = 0;
      attended[i] =0;
      if(i<widget.questions.length)
      questionsArray[i]=widget.questions[i].id;
    }
    attended[0]=1;
print(questionsArray);

    setState(() {
      _secondsleft = int.parse(widget.testTime)*60;
      totalTime = int.parse(widget.testTime)*60;
      maxQuestions = int.parse(widget.maxQuestions);
    });
    //needs rework
    html.window.onBeforeUnload.listen((event) async{
      print("exiting");
      event.preventDefault();
    });
    startTimer();
    print(widget.questions.length);

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
      body: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width*0.1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height*0.05,),
                Container(
                  height: MediaQuery.of(context).size.height*0.1,
                  width: MediaQuery.of(context).size.height*0.1,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white70,),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Center(child: Text((currentPageValue+1).toString(),style: TextStyle(color: Colors.white70,fontSize: 30,fontWeight: FontWeight.w500,height: 1.5))),
                )
              ],
            ),
          ),

    Column(
      children: [
        SizedBox(
    height: MediaQuery.of(context).size.height*0.02,
    ),
        Container(
        width : MediaQuery.of(context).size.width * 0.64,
        height: MediaQuery.of(context).size.height * 0.72,
          child: PageView.builder(
    controller: _QuestionsController,
    physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, position) {
          return QuestionPage(widget.questions[position].question,widget.questions[position].type,widget.questions[position].code,widget.questions[position].opt1,widget.questions[position].opt2,widget.questions[position].opt3,widget.questions[position].opt4,answerArray,onAnswerDataChange,position);
          },
          itemCount: maxQuestions, // Can be null
          ),
        ),
    SizedBox(
    height: MediaQuery.of(context).size.height*0.02,
    ),
    Container(
    width : MediaQuery.of(context).size.width * 0.64,
      child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
      InkWell(
      onTap: ()=>{
      gotoPreviousPage()
      },
      child: Container(
      width : MediaQuery.of(context).size.width * 0.15,
      height: MediaQuery.of(context).size.height * 0.06,
      decoration: BoxDecoration(
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.circular(5.0),
    color: Color(0xff6f4a8e),
      ),
      child: Center(
      child: Text("PREVIOUS",style: TextStyle(color: Colors.white70,fontSize: 18,letterSpacing: 1),textAlign: TextAlign.center,),
      )
      ),
      ),
      InkWell(
      onTap: ()=>{
          unAnswer()
      },
      child: Container(
      width : MediaQuery.of(context).size.width * 0.15,
      height: MediaQuery.of(context).size.height * 0.06,
      decoration: BoxDecoration(
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.circular(5.0),
      color: Color(0xffa35d6a),
      ),
      child: Center(
      child: Text("UNANSWER",style: TextStyle(color: Colors.white70,fontSize: 18,letterSpacing: 1),textAlign: TextAlign.center,),
      )
      ),
      ),
      InkWell(
      onTap: ()=>{
      gotoNextPage()
      },
      child: Container(
      width : MediaQuery.of(context).size.width * 0.15,
      height: MediaQuery.of(context).size.height * 0.06,
      decoration: BoxDecoration(
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.circular(5.0),
    color: Color(0xff6f4a8e),
      ),
      child: Center(
      child: Text("NEXT",style: TextStyle(color: Colors.white70,fontSize: 18,letterSpacing: 1),textAlign: TextAlign.center,),
      )
      ),
      ),
      ],
      ),
    )
      ],
    ),

          SizedBox(
            width: MediaQuery.of(context).size.width*0.07,
          ),
          Expanded(
            child: Container(
              
              decoration: BoxDecoration(
                color: Color(0xff2f3136),
                shape: BoxShape.rectangle,
                ),
              child: Column(
                children: [
              SizedBox(
              height: MediaQuery.of(context).size.height*0.02,
            ),
                    Text("Time Left",style: TextStyle(color: Colors.white70,fontSize: 18,fontWeight: FontWeight.w500,height: 1.2),textAlign: TextAlign.center,),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.02,
              ),
              Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width*0.03,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width*0.05,
                            child: Text((_secondsleft/3600).floor()<10?"0"+(_secondsleft/3600).floor().toString():(_secondsleft/3600).floor().toString(),style: TextStyle(color: Colors.white70,fontSize: 25,fontWeight: FontWeight.w500,height: 1.2),textAlign: TextAlign.center,)
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width*0.05,
                            child: Text(((_secondsleft%3600)/60).floor()<10?"0"+((_secondsleft%3600)/60).floor().toString():((_secondsleft%3600)/60).floor().toString(),style: TextStyle(color: Colors.white70,fontSize: 25,fontWeight: FontWeight.w500,height: 1.2),textAlign: TextAlign.center,)),
                        Container(
                            width: MediaQuery.of(context).size.width*0.05,
                            child: Text((_secondsleft%60).floor()<10?"0"+(_secondsleft%60).floor().toString():(_secondsleft%60).floor().toString(),style: TextStyle(color: Colors.white70,fontSize: 25,fontWeight: FontWeight.w500,height: 1.2),textAlign: TextAlign.center,)),
                      ],
                    ),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.01,
              ),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.03,
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width*0.05,
                      child: Text("hours",style: TextStyle(color: Colors.white70,fontSize: 16,fontWeight: FontWeight.w500,height: 1.2),textAlign: TextAlign.center,)
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width*0.05,
                      child: Text("minutes",style: TextStyle(color: Colors.white70,fontSize: 16,fontWeight: FontWeight.w500,height: 1.2),textAlign: TextAlign.center,)),
                  Container(
                      width: MediaQuery.of(context).size.width*0.05,
                      child: Text("seconds",style: TextStyle(color: Colors.white70,fontSize: 16,fontWeight: FontWeight.w500,height: 1.2),textAlign: TextAlign.center,)),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.02,
              ),

    Center(
    child: InkWell(
    onTap: ()async=>{
    showDialog(
    context: context,
    builder: (BuildContext context) {
    return Dialog(
    backgroundColor: Color(0xff2f3136),
    shape: RoundedRectangleBorder(
    borderRadius:
    BorderRadius.circular(15.0)), //this right here
    child: Container(
    height: MediaQuery.of(context).size.height*0.5,
    width: MediaQuery.of(context).size.height,
    child: Column(
    children: [
    SizedBox(
    height: MediaQuery.of(context).size.height*0.05,
    ),
    Container(
    width : MediaQuery.of(context).size.width * 0.2,
    height: MediaQuery.of(context).size.height*0.05,
    decoration: BoxDecoration(
    shape: BoxShape.rectangle,
    borderRadius: BorderRadius.circular(5.0),
    color: Color(0xff145cae),
    ),
    child: FittedBox(fit:BoxFit.scaleDown,child: Text("REVIEW TEST",style: TextStyle(color: Colors.white70,fontSize: 18,letterSpacing: 1),textAlign: TextAlign.center,))
    ),
    SizedBox(
    height: MediaQuery.of(context).size.height*0.075,
    ),
    Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
    Stack(
    children: <Widget>[
    Container(
    height: MediaQuery.of(context).size.height*0.1,
    width: MediaQuery.of(context).size.height*0.1,
    child: CircularProgressIndicator(
    strokeWidth: 10,
    value: attendedCount/maxQuestions,
    backgroundColor: Colors.white.withOpacity(0.1),
    ),
    ),

    Positioned.fill(child: Center(child: Text((attendedCount/maxQuestions*100).round().toString()+"%",style: TextStyle(color: Colors.white70,fontSize: 20,fontWeight: FontWeight.bold),textAlign: TextAlign.center,)))
    ],
    ),
    Stack(
    children: <Widget>[
    Container(
    height: MediaQuery.of(context).size.height*0.1,
    width: MediaQuery.of(context).size.height*0.1,
    child: CircularProgressIndicator(
    strokeWidth: 10,
    value: answeredCount/maxQuestions,
    backgroundColor: Colors.white.withOpacity(0.1),
    ),
    ),

    Positioned.fill(child: Center(child: Text((answeredCount/maxQuestions*100).round().toString()+"%",style: TextStyle(color: Colors.white70,fontSize: 20,fontWeight: FontWeight.bold),textAlign: TextAlign.center,)))
    ],
    ),
    Stack(
    children: <Widget>[
    Container(
    height: MediaQuery.of(context).size.height*0.1,
    width: MediaQuery.of(context).size.height*0.1,
    child: CircularProgressIndicator(
    strokeWidth: 10,
    value: (totalTime-_secondsleft)/totalTime,
    backgroundColor: Colors.white.withOpacity(0.1),
    ),
    ),

    Positioned.fill(child: Center(child: Text(((totalTime-_secondsleft)/totalTime*100).round().toString()+"%",style: TextStyle(color: Colors.white70,fontSize: 20,fontWeight: FontWeight.bold),textAlign: TextAlign.center,)))
    ],
    )
    ],
    ),
    SizedBox(
    height: MediaQuery.of(context).size.height*0.02,
    ),
Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Container(
    width: MediaQuery.of(context).size.height*0.1,
    child: Text("Attended",style: TextStyle(color: Colors.white70,fontSize: 16,fontWeight: FontWeight.w500,height: 1.2),textAlign: TextAlign.center,)
    ),
    Container(
    width: MediaQuery.of(context).size.height*0.1,
    child: Text("Answered",style: TextStyle(color: Colors.white70,fontSize: 16,fontWeight: FontWeight.w500,height: 1.2),textAlign: TextAlign.center,)
    ),
    Container(
    width: MediaQuery.of(context).size.height*0.1,
    child: Text("Time",style: TextStyle(color: Colors.white70,fontSize: 16,fontWeight: FontWeight.w500,height: 1.2),textAlign: TextAlign.center,)
    ),
    ],
    ),
    SizedBox(
    height: MediaQuery.of(context).size.height*0.075,
    ),
    InkWell(
    onTap: ()=>{
    Navigator.pushReplacement(context, MaterialPageRoute(
    builder: (context) => FinishTest(widget.testID,widget.studentOne,widget.studentTwo,widget.maxMembers,answerArray,questionsArray,maxQuestions),
    )
    ),
    },
      child: Container(
      width : MediaQuery.of(context).size.width * 0.15,
      height: MediaQuery.of(context).size.height * 0.06,
      decoration: BoxDecoration(
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.circular(5.0),
      color: Color(0xff145cae),
      ),
      child: Center(
      child: Text("FINISH TEST",style: TextStyle(color: Colors.white70,fontSize: 18,),textAlign: TextAlign.center,),
      )
      ),
    ),
    ],
    ),
    ),
    );
    }),
    },
    child: Container(
    width : MediaQuery.of(context).size.width * 0.15,
    height: MediaQuery.of(context).size.height * 0.06,
    decoration: BoxDecoration(
    shape: BoxShape.rectangle,
    borderRadius: BorderRadius.circular(5.0),
    color: Color(0xff145cae),
    ),
    child: Center(
    child: Text("FINISH TEST",style: TextStyle(color: Colors.white70,fontSize: 18,),textAlign: TextAlign.center,),
    )
    ),
    ),
    ),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.03,
              ),
              Text("Navigation Panel",style: TextStyle(color: Colors.white70,fontSize: 18,fontWeight: FontWeight.w500,height: 1.2),textAlign: TextAlign.center,),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.02,
              ),
              for(int j=0;j<maxQuestions/5;j++)
              Padding(
                padding: const EdgeInsets.only(bottom: 20,left: 20,right: 20),
                child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    for(int i=0;i<5;i++)
                    InkWell(
                      onTap: ()=>{
    if(attended[((j*5+i*1))]==0)
    {
    attended[((j*5+i*1))]=1,
    attendedCount++,
    },
                        _QuestionsController.jumpToPage(((j*5+i*1)))
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width*0.03,
                        decoration: currentPageValue==(j*5+i*1)?BoxDecoration(
    shape: BoxShape.circle,
    color: Colors.indigo,
    border: Border.all(color: Colors.white70,),
    ):answerArray[(j*5+i*1)]==0?BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white70,),
                        ):BoxDecoration(
    color: Color(0xff158467),
    shape: BoxShape.circle,
    border: Border.all(color: Color(0xff197163)),
    ),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(((j*5+i*1)+1).toString(),style: TextStyle(color: Colors.white70,fontSize: 18,fontWeight: FontWeight.w500,height: 1.2),textAlign: TextAlign.center,),
                        ),
                      ),
                    ),
                  ],
                ),
              )
                ],
              ),
            ),
          )
        ],
      ),
    );


  }
}

