import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class QuestionPage extends StatefulWidget {
  String ques;
  String link;
  String code;
  String type;
  String opt1;
  String opt2;
  String opt3;
  String opt4;

  QuestionPage(this.ques,this.type,this.link, this.code,this.opt1,this.opt2,this.opt3,this.opt4,this.answerData,this.onDataChange,this.position);
  final position;
  final answerData;
  final Function(int,int) onDataChange;

  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> with AutomaticKeepAliveClientMixin<QuestionPage>{
  ScrollController _controller;
//  var selectedAnswer=-1;
  double _offset = 0;
  var numLines;


  void selectAnswer(int n)
  {
    widget.onDataChange(n,widget.position);
  }
  static const AREA_LOST_PERCENT = 5;

  double autoSize({@required int quoteLength, @required int parentArea}) {
    assert(quoteLength != null, "`quoteLength` may not be null");
    assert(parentArea != null, "`parentArea` may not be null");
    final areaOfLetter = parentArea / quoteLength;
    final pixelOfLetter = sqrt(areaOfLetter);
    final pixelOfLetterP = pixelOfLetter - (pixelOfLetter * AREA_LOST_PERCENT) / 100;
    if(pixelOfLetterP>20)
      return 20;
    return pixelOfLetterP;
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    _controller = ScrollController();
    numLines = '\n'.allMatches(widget.code).length + 2;
    print(numLines);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width : MediaQuery.of(context).size.width * 0.6,
          height: MediaQuery.of(context).size.height * 0.7,
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
                height: MediaQuery.of(context).size.height*0.01,
              ),
              Row(
                children: [
                  widget.type=="code"?
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.35,
                        height: MediaQuery.of(context).size.height * 0.2,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                            child: Text(widget.ques, style: TextStyle(color: Colors.white70,fontSize: autoSize(quoteLength: widget.ques.length, parentArea: (MediaQuery.of(context).size.width * 0.35*MediaQuery.of(context).size.height * 0.25).round()),fontWeight: FontWeight.w500,height: 1.5),),

                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height*0.01,
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width * 0.35,
                          height: MediaQuery.of(context).size.height * 0.4,
                          child: Stack(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: NotificationListener<OverscrollIndicatorNotification>(
                                  onNotification: (OverscrollIndicatorNotification overScroll) {
                                    overScroll.disallowGlow();
                                    return false;
                                  },child: SingleChildScrollView(
                                  controller: _controller,
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                                    child: Text(widget.code.replaceAll(r"!-!", ''), style: TextStyle(color: Colors.white70,fontSize: 18,fontWeight: FontWeight.w500,height: 1.5)),

                                  ),
                                ),
                                ),
                              ),
                              Container(
                                  alignment: Alignment.centerRight,
                                  height: MediaQuery.of(context).size.height*0.4,
                                  width: 20.0,
                                  margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.35- 20.0),
                                  decoration: BoxDecoration(color: Colors.black12),
                                  child: Container(
                                    alignment: Alignment.topCenter,
                                    child: GestureDetector(
                                      behavior: HitTestBehavior.translucent,
                                      child: Container(
                                        height: 40.0,
                                        width: 15.0,
                                        margin:
                                        EdgeInsets.only(left: 5.0, right: 5.0, top: _offset),
                                        decoration: BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius: BorderRadius.all(Radius.circular(3.0))),
                                      ),
                                      onVerticalDragUpdate: (dragUpdate) {
                                        _controller.position.moveTo((dragUpdate.globalPosition.dy -MediaQuery.of(context).size.height*0.439)*((numLines-11.5)*26/264));

                                        setState(() {
                                          if(dragUpdate.globalPosition.dy >= 0) {
                                            _offset = (dragUpdate.globalPosition.dy-MediaQuery.of(context).size.height*0.44)<0?0:(dragUpdate.globalPosition.dy-MediaQuery.of(context).size.height*0.44)>MediaQuery.of(context).size.height*0.35?MediaQuery.of(context).size.height*0.35:(dragUpdate.globalPosition.dy-MediaQuery.of(context).size.height*0.44);
                                          }
                                          print("View offset ${_controller.offset} scroll-bar offset ${_offset} Pos offset ${dragUpdate.globalPosition.dy}");
                                        });
                                      },
                                    ),
                                  )
                              ),
                            ],
                          )
                      ),
                    ],
                  ):
                      widget.link==""?
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.35,
                        height: MediaQuery.of(context).size.height * 0.6,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                            child: Text(widget.ques, style: TextStyle(color: Colors.white70,fontSize: 21,fontWeight: FontWeight.w500,height: 1.5),textAlign: TextAlign.justify,),

                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height*0.01,
                      ),

                    ],
                  ):
                  Column(children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.35,
                      height: MediaQuery.of(context).size.height * 0.6,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: Text(widget.ques, style: TextStyle(color: Colors.white70,fontSize: 21,fontWeight: FontWeight.w500,height: 1.5),textAlign: TextAlign.justify,),

                        ),
                      ),
                    ),
                    CachedNetworkImage(
                      imageUrl: widget.link,
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.01,
                    ),
                  ],),
                  if(widget.type=="standard")
                  Container(
                    width: MediaQuery.of(context).size.width*0.001,
                    height: MediaQuery.of(context).size.height * 0.4,
                    decoration: BoxDecoration(
                      color: Colors.white24,
                    ),
                  ),

                  Container(
                    width: MediaQuery.of(context).size.width*0.249,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //SizedBox(height: MediaQuery.of(context).size.height*0.1,),
                        InkWell(
                          onTap: ()=>{
                              selectAnswer(1),
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width*0.2,
                            decoration: widget.answerData[widget.position]==1?BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: Color(0xff158467),
                              border: Border.all(color: Color(0xff197163)),
                              borderRadius: BorderRadius.circular(5.0),
                            ):BoxDecoration(
                              border: Border.all(color: Colors.white70,),
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal:8.0,vertical: 10),
                              child: Center(child: Text(widget.opt1,style: TextStyle(color: Colors.white70,fontSize: 18,fontWeight: FontWeight.w500,height: 1.2),textAlign: TextAlign.center,)),
                            ),
                          ),
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                        InkWell(
                          onTap: ()=>{
                          selectAnswer(2),
                        },
                          child: Container(
                            width: MediaQuery.of(context).size.width*0.2,
                            decoration: widget.answerData[widget.position]==2?BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: Color(0xff158467),
                              border: Border.all(color: Color(0xff197163)),
                              borderRadius: BorderRadius.circular(5.0),
                            ):BoxDecoration(
                              border: Border.all(color: Colors.white70,),
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal:8.0,vertical: 10),
                              child: Center(child: Text(widget.opt2,style: TextStyle(color: Colors.white70,fontSize: 18,fontWeight: FontWeight.w500,height: 1.2),textAlign: TextAlign.center,)),
                            ),
                          ),
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                        InkWell(
                          onTap: ()=>{
                          selectAnswer(3),
                        },
                          child: Container(
                            width: MediaQuery.of(context).size.width*0.2,
                            decoration: widget.answerData[widget.position]==3?BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: Color(0xff158467),
                              border: Border.all(color: Color(0xff197163)),
                              borderRadius: BorderRadius.circular(5.0),
                            ):BoxDecoration(
                              border: Border.all(color: Colors.white70,),
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal:8.0,vertical: 10),
                              child: Center(child: Text(widget.opt3,style: TextStyle(color: Colors.white70,fontSize: 18,fontWeight: FontWeight.w500,height: 1.2),textAlign: TextAlign.center,)),
                            ),
                          ),
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                        InkWell(
                          onTap: ()=>{
                          selectAnswer(4),
                        },
                          child: Container(
                            width: MediaQuery.of(context).size.width*0.2,
                            decoration: widget.answerData[widget.position]==4?BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: Color(0xff158467),
                              border: Border.all(color: Color(0xff197163)),
                              borderRadius: BorderRadius.circular(5.0),
                            ):BoxDecoration(
                              border: Border.all(color: Colors.white70,),
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal:8.0,vertical: 10),
                              child: Center(child: Text(widget.opt4,style: TextStyle(color: Colors.white70,fontSize: 18,fontWeight: FontWeight.w500,height: 1.2),textAlign: TextAlign.center,)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.02,
              ),
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height*0.02,
        ),

      ],
    );
  }
}
