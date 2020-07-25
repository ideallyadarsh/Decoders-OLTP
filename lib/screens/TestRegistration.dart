import 'package:flutter/material.dart';

class TestRegistration extends StatefulWidget {
  final String TestID;

  TestRegistration(this.TestID);

  @override
  _TestRegistrationState createState() => _TestRegistrationState();
}

class _TestRegistrationState extends State<TestRegistration> {

  final studentOneNameController = TextEditingController();
  final studentOneUSNController = TextEditingController();
  final studentOnePhoneController = TextEditingController();
  final studentOneEmailController = TextEditingController();

  var maxMembers=2;

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
                      child: FittedBox(fit:BoxFit.scaleDown,child: Text("TEST INFO",style: TextStyle(color: Colors.white70,fontSize: 18,letterSpacing: 1),textAlign: TextAlign.center,))
                  ),

                  SizedBox(
                    height: MediaQuery.of(context).size.height*0.02,
                  ),
                  Row(
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width : MediaQuery.of(context).size.width * 0.03,
                              ),
                              Container(
                                //color: Colors.blue,
                                width : MediaQuery.of(context).size.width * 0.03,
                                height: MediaQuery.of(context).size.height*0.04,
                                child: FittedBox(fit:BoxFit.scaleDown,child: Icon(Icons.date_range,color: Colors.white70,)),
                              ),
                              Container(
                                //color: Colors.pink,
                                width : MediaQuery.of(context).size.width * 0.09,
                                height: MediaQuery.of(context).size.height*0.04,
                                child: FittedBox(fit:BoxFit.scaleDown,child: Align(alignment:Alignment.centerLeft,child: Text("DATE :         ",style: TextStyle(color: Colors.white70,fontSize: 20,fontWeight: FontWeight.w600),))),
                              ),
                              Container(
                                //color: Colors.pink,
                                width : MediaQuery.of(context).size.width * 0.1,
                                height: MediaQuery.of(context).size.height*0.04,
                                child: FittedBox(fit:BoxFit.scaleDown,child: Text("17th April, 2021",style: TextStyle(color: Colors.white70,fontSize: 20,fontWeight: FontWeight.w500),)),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height*0.004,
                          ),
                          Row(
                            children: [
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width : MediaQuery.of(context).size.width * 0.03,
                                      ),
                                      Container(
                                        width : MediaQuery.of(context).size.width * 0.03,
                                        height: MediaQuery.of(context).size.height*0.04,
                                        child: FittedBox(fit:BoxFit.scaleDown,child: Icon(Icons.pie_chart_outlined,color: Colors.white70,)),
                                      ),
                                      Container(
                                        width : MediaQuery.of(context).size.width * 0.09,
                                        height: MediaQuery.of(context).size.height*0.04,
                                        child: FittedBox(fit:BoxFit.scaleDown,child: Align(alignment:Alignment.centerLeft,child: Text("TEST TYPE :",style: TextStyle(color: Colors.white70,fontSize: 20,fontWeight: FontWeight.w600),))),
                                      ),
                                      Container(
                                        width : MediaQuery.of(context).size.width * 0.1,
                                        height: MediaQuery.of(context).size.height*0.04,
                                        child: FittedBox(fit:BoxFit.scaleDown,child: Text("MCQs",style: TextStyle(color: Colors.white70,fontSize: 20,fontWeight: FontWeight.w500),)),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height*0.004,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width : MediaQuery.of(context).size.width * 0.03,
                                      ),
                                      Container(
                                        width : MediaQuery.of(context).size.width * 0.03,
                                        height: MediaQuery.of(context).size.height*0.04,
                                        child: FittedBox(fit:BoxFit.scaleDown,child: Icon(Icons.people,color: Colors.white70,)),
                                      ),
                                      Container(
                                        width : MediaQuery.of(context).size.width * 0.09,
                                        height: MediaQuery.of(context).size.height*0.04,
                                        child: FittedBox(fit:BoxFit.scaleDown,child: Align(alignment:Alignment.centerLeft,child: Text("MEMBERS : ",style: TextStyle(color: Colors.white70,fontSize: 20,fontWeight: FontWeight.w600),))),
                                      ),
                                      Container(
                                        width : MediaQuery.of(context).size.width * 0.1,
                                        height: MediaQuery.of(context).size.height*0.04,
                                        child: FittedBox(fit:BoxFit.scaleDown,child: Text("1",style: TextStyle(color: Colors.white70,fontSize: 20,fontWeight: FontWeight.w500),)),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width : MediaQuery.of(context).size.width * 0.03,
                              ),
                              Container(
                                //color: Colors.blue,
                                width : MediaQuery.of(context).size.width * 0.03,
                                height: MediaQuery.of(context).size.height*0.04,
                                child: FittedBox(fit:BoxFit.scaleDown,child: Icon(Icons.timer,color: Colors.white70,)),
                              ),
                              Container(
                                //color: Colors.pink,
                                width : MediaQuery.of(context).size.width * 0.09,
                                height: MediaQuery.of(context).size.height*0.04,
                                child: FittedBox(fit:BoxFit.scaleDown,child: Align(alignment:Alignment.centerLeft,child: Text("DURATION :  ",style: TextStyle(color: Colors.white70,fontSize: 20,fontWeight: FontWeight.w600),))),
                              ),
                              Container(
                                //color: Colors.pink,
                                width : MediaQuery.of(context).size.width * 0.1,
                                height: MediaQuery.of(context).size.height*0.04,
                                child: FittedBox(fit:BoxFit.scaleDown,child: Text("90 minutes",style: TextStyle(color: Colors.white70,fontSize: 20,fontWeight: FontWeight.w500),)),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height*0.004,
                          ),
                          Row(
                            children: [
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width : MediaQuery.of(context).size.width * 0.03,
                                      ),
                                      Container(
                                        width : MediaQuery.of(context).size.width * 0.03,
                                        height: MediaQuery.of(context).size.height*0.04,
                                        child: FittedBox(fit:BoxFit.scaleDown,child: Icon(Icons.library_books,color: Colors.white70,)),
                                      ),
                                      Container(
                                        width : MediaQuery.of(context).size.width * 0.09,
                                        height: MediaQuery.of(context).size.height*0.04,
                                        child: FittedBox(fit:BoxFit.scaleDown,child: Align(alignment:Alignment.centerLeft,child: Text("QUESTIONS :",style: TextStyle(color: Colors.white70,fontSize: 20,fontWeight: FontWeight.w600),))),
                                      ),
                                      Container(
                                        width : MediaQuery.of(context).size.width * 0.1,
                                        height: MediaQuery.of(context).size.height*0.04,
                                        child: FittedBox(fit:BoxFit.scaleDown,child: Text("40",style: TextStyle(color: Colors.white70,fontSize: 20,fontWeight: FontWeight.w500),)),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height*0.004,
                          ),
                          Row(
                            children: [
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width : MediaQuery.of(context).size.width * 0.03,
                                      ),
                                      Container(
                                        width : MediaQuery.of(context).size.width * 0.03,
                                        height: MediaQuery.of(context).size.height*0.04,
                                        child: FittedBox(fit:BoxFit.scaleDown,child: Icon(Icons.assessment,color: Colors.white70,)),
                                      ),
                                      Container(
                                        width : MediaQuery.of(context).size.width * 0.09,
                                        height: MediaQuery.of(context).size.height*0.04,
                                        child: FittedBox(fit:BoxFit.scaleDown,child: Align(alignment:Alignment.centerLeft,child: Text("TEST ID :      ",style: TextStyle(color: Colors.white70,fontSize: 20,fontWeight: FontWeight.w600),))),
                                      ),
                                      Container(
                                        width : MediaQuery.of(context).size.width * 0.1,
                                        height: MediaQuery.of(context).size.height*0.04,
                                        child: FittedBox(fit:BoxFit.scaleDown,child: Text(widget.TestID.toUpperCase(),style: TextStyle(color: Colors.white70,fontSize: 20,fontWeight: FontWeight.w500),)),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      )
                    ],
                  ),


                  SizedBox(
                    height: MediaQuery.of(context).size.height*0.02,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width*0.45,
                    height: MediaQuery.of(context).size.height*0.12,
                    child: Text("SARK is a technical group based out of SIT Tumakuru, which carries on technical events throughout the year for the students and encourages project based learning to keep up with the latest requirements in the ever changing industry.",style: TextStyle(color: Colors.white70,fontSize: 20,fontWeight: FontWeight.w400),),
                  )

                ],
              ),
            ),
          ),
          maxMembers==2?
          SizedBox(
            height: MediaQuery.of(context).size.height*0.01,
          ):
          SizedBox(
            height: MediaQuery.of(context).size.height*0.03,
          ),
          maxMembers==2?
          Center(
            child: Container(
              width : MediaQuery.of(context).size.width * 0.31,
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
                  Column(
                    children: [
                      Container(
                        child: TextField(
                          controller: studentOneNameController,
                          style: TextStyle(color: Colors.white70),
                          decoration: new InputDecoration(
                            fillColor: Color(0xff36393f),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Color(0xff2f3136))
                            ),
                            prefixIcon: Icon(Icons.people,color: Colors.white70,),
                            labelText: "TEAM NAME",
                            labelStyle: TextStyle(color: Colors.white70),
                          ),
                        ),
                        width: MediaQuery.of(context).size.width * 0.3,
                        decoration: BoxDecoration(
                            color: Color(0xff2a2c31),
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12))
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height*0.01,
                  ),

                ],
              ),
            ),
          ):
              SizedBox(
                height: 0,
              ),
          maxMembers==2?
          SizedBox(
            height: MediaQuery.of(context).size.height*0.015,
          ):
          SizedBox(
            height: 0,
          ),
          maxMembers==1?
          Center(
            child: Container(
              width : MediaQuery.of(context).size.width * 0.4,
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
                    height: MediaQuery.of(context).size.height*0.03,
                  ),

                  Container(
                      width : MediaQuery.of(context).size.width * 0.2,
                      height: MediaQuery.of(context).size.height*0.05,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(5.0),
                        color: Color(0xff145cae),
                      ),
                      child: FittedBox(fit:BoxFit.scaleDown,child: Text("STUDENT DETAILS",style: TextStyle(color: Colors.white70,fontSize: 18,letterSpacing: 1),textAlign: TextAlign.center,))
                  ),

                  SizedBox(
                    height: MediaQuery.of(context).size.height*0.03,
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width : MediaQuery.of(context).size.width * 0.03,
                          ),
                          Container(
                            child: TextField(
                              controller: studentOneNameController,
                              style: TextStyle(color: Colors.white70),
                              decoration: new InputDecoration(
                                fillColor: Color(0xff36393f),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Color(0xff2f3136))
                                ),
                                prefixIcon: Icon(Icons.perm_identity,color: Colors.white70,),
                                labelText: "NAME",
                                labelStyle: TextStyle(color: Colors.white70),
                              ),
                            ),
                            width: MediaQuery.of(context).size.width * 0.15,
                            decoration: BoxDecoration(
                                color: Color(0xff2a2c31),
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12))
                            ),
                          ),
                          SizedBox(
                            width : MediaQuery.of(context).size.width * 0.03,
                          ),
                          Container(
                            child: TextField(
                              controller: studentOneUSNController,
                              style: TextStyle(color: Colors.white70),
                              decoration: new InputDecoration(
                                fillColor: Color(0xff36393f),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Color(0xff2f3136))
                                ),
                                prefixIcon: Icon(Icons.format_list_numbered,color: Colors.white70,),
                                labelText: "USN",
                                labelStyle: TextStyle(color: Colors.white70),
                              ),
                            ),
                            width: MediaQuery.of(context).size.width * 0.15,
                            decoration: BoxDecoration(
                                color: Color(0xff2a2c31),
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12))
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height*0.02,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width : MediaQuery.of(context).size.width * 0.03,
                          ),
                          Container(
                            child: TextField(
                              controller: studentOneNameController,
                              style: TextStyle(color: Colors.white70),
                              decoration: new InputDecoration(
                                fillColor: Color(0xff36393f),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Color(0xff2f3136))
                                ),
                                prefixIcon: Icon(Icons.email,color: Colors.white70,),
                                labelText: "EMAIL ADDRESS",
                                labelStyle: TextStyle(color: Colors.white70),
                              ),
                            ),
                            width: MediaQuery.of(context).size.width * 0.15,
                            decoration: BoxDecoration(
                                color: Color(0xff2a2c31),
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12))
                            ),
                          ),
                          SizedBox(
                            width : MediaQuery.of(context).size.width * 0.03,
                          ),
                          Container(
                            child: TextField(
                              controller: studentOneUSNController,
                              style: TextStyle(color: Colors.white70),
                              decoration: new InputDecoration(
                                fillColor: Color(0xff36393f),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Color(0xff2f3136))
                                ),
                                prefixIcon: Icon(Icons.phone,color: Colors.white70,),
                                labelText: "PHONE",
                                labelStyle: TextStyle(color: Colors.white70),
                              ),
                            ),
                            width: MediaQuery.of(context).size.width * 0.15,
                            decoration: BoxDecoration(
                                color: Color(0xff2a2c31),
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12))
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height*0.02,
                  ),

                ],
              ),
            ),
          ):
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width : MediaQuery.of(context).size.width * 0.4,
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
                      height: MediaQuery.of(context).size.height*0.02,
                    ),

                    Container(
                        width : MediaQuery.of(context).size.width * 0.2,
                        height: MediaQuery.of(context).size.height*0.05,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(5.0),
                          color: Color(0xff145cae),
                        ),
                        child: FittedBox(fit:BoxFit.scaleDown,child: Text("STUDENT 1 DETAILS",style: TextStyle(color: Colors.white70,fontSize: 18,letterSpacing: 1),textAlign: TextAlign.center,))
                    ),

                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.015,
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width : MediaQuery.of(context).size.width * 0.03,
                            ),
                            Container(
                              child: TextField(
                                controller: studentOneNameController,
                                style: TextStyle(color: Colors.white70),
                                decoration: new InputDecoration(
                                  fillColor: Color(0xff36393f),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(color: Color(0xff2f3136))
                                  ),
                                  prefixIcon: Icon(Icons.perm_identity,color: Colors.white70,),
                                  labelText: "NAME",
                                  labelStyle: TextStyle(color: Colors.white70),
                                ),
                              ),
                              width: MediaQuery.of(context).size.width * 0.15,
                              decoration: BoxDecoration(
                                  color: Color(0xff2a2c31),
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12))
                              ),
                            ),
                            SizedBox(
                              width : MediaQuery.of(context).size.width * 0.03,
                            ),
                            Container(
                              child: TextField(
                                controller: studentOneUSNController,
                                style: TextStyle(color: Colors.white70),
                                decoration: new InputDecoration(
                                  fillColor: Color(0xff36393f),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(color: Color(0xff2f3136))
                                  ),
                                  prefixIcon: Icon(Icons.format_list_numbered,color: Colors.white70,),
                                  labelText: "USN",
                                  labelStyle: TextStyle(color: Colors.white70),
                                ),
                              ),
                              width: MediaQuery.of(context).size.width * 0.15,
                              decoration: BoxDecoration(
                                  color: Color(0xff2a2c31),
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12))
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height*0.015,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width : MediaQuery.of(context).size.width * 0.03,
                            ),
                            Container(
                              child: TextField(
                                controller: studentOneNameController,
                                style: TextStyle(color: Colors.white70),
                                decoration: new InputDecoration(
                                  fillColor: Color(0xff36393f),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(color: Color(0xff2f3136))
                                  ),
                                  prefixIcon: Icon(Icons.email,color: Colors.white70,),
                                  labelText: "EMAIL ADDRESS",
                                  labelStyle: TextStyle(color: Colors.white70),
                                ),
                              ),
                              width: MediaQuery.of(context).size.width * 0.15,
                              decoration: BoxDecoration(
                                  color: Color(0xff2a2c31),
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12))
                              ),
                            ),
                            SizedBox(
                              width : MediaQuery.of(context).size.width * 0.03,
                            ),
                            Container(
                              child: TextField(
                                controller: studentOneUSNController,
                                style: TextStyle(color: Colors.white70),
                                decoration: new InputDecoration(
                                  fillColor: Color(0xff36393f),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(color: Color(0xff2f3136))
                                  ),
                                  prefixIcon: Icon(Icons.phone,color: Colors.white70,),
                                  labelText: "PHONE",
                                  labelStyle: TextStyle(color: Colors.white70),
                                ),
                              ),
                              width: MediaQuery.of(context).size.width * 0.15,
                              decoration: BoxDecoration(
                                  color: Color(0xff2a2c31),
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12))
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.015,
                    ),

                  ],
                ),
              ),

              Container(
                width : MediaQuery.of(context).size.width * 0.4,
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
                      height: MediaQuery.of(context).size.height*0.02,
                    ),

                    Container(
                        width : MediaQuery.of(context).size.width * 0.2,
                        height: MediaQuery.of(context).size.height*0.05,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(5.0),
                          color: Color(0xff145cae),
                        ),
                        child: FittedBox(fit:BoxFit.scaleDown,child: Text("STUDENT 2 DETAILS",style: TextStyle(color: Colors.white70,fontSize: 18,letterSpacing: 1),textAlign: TextAlign.center,))
                    ),

                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.015,
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width : MediaQuery.of(context).size.width * 0.03,
                            ),
                            Container(
                              child: TextField(
                                controller: studentOneNameController,
                                style: TextStyle(color: Colors.white70),
                                decoration: new InputDecoration(
                                  fillColor: Color(0xff36393f),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(color: Color(0xff2f3136))
                                  ),
                                  prefixIcon: Icon(Icons.perm_identity,color: Colors.white70,),
                                  labelText: "NAME",
                                  labelStyle: TextStyle(color: Colors.white70),
                                ),
                              ),
                              width: MediaQuery.of(context).size.width * 0.15,
                              decoration: BoxDecoration(
                                  color: Color(0xff2a2c31),
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12))
                              ),
                            ),
                            SizedBox(
                              width : MediaQuery.of(context).size.width * 0.03,
                            ),
                            Container(
                              child: TextField(
                                controller: studentOneUSNController,
                                style: TextStyle(color: Colors.white70),
                                decoration: new InputDecoration(
                                  fillColor: Color(0xff36393f),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(color: Color(0xff2f3136))
                                  ),
                                  prefixIcon: Icon(Icons.format_list_numbered,color: Colors.white70,),
                                  labelText: "USN",
                                  labelStyle: TextStyle(color: Colors.white70),
                                ),
                              ),
                              width: MediaQuery.of(context).size.width * 0.15,
                              decoration: BoxDecoration(
                                  color: Color(0xff2a2c31),
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12))
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height*0.015,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width : MediaQuery.of(context).size.width * 0.03,
                            ),
                            Container(
                              child: TextField(
                                controller: studentOneNameController,
                                style: TextStyle(color: Colors.white70),
                                decoration: new InputDecoration(
                                  fillColor: Color(0xff36393f),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(color: Color(0xff2f3136))
                                  ),
                                  prefixIcon: Icon(Icons.email,color: Colors.white70,),
                                  labelText: "EMAIL ADDRESS",
                                  labelStyle: TextStyle(color: Colors.white70),
                                ),
                              ),
                              width: MediaQuery.of(context).size.width * 0.15,
                              decoration: BoxDecoration(
                                  color: Color(0xff2a2c31),
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12))
                              ),
                            ),
                            SizedBox(
                              width : MediaQuery.of(context).size.width * 0.03,
                            ),
                            Container(
                              child: TextField(
                                controller: studentOneUSNController,
                                style: TextStyle(color: Colors.white70),
                                decoration: new InputDecoration(
                                  fillColor: Color(0xff36393f),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(color: Color(0xff2f3136))
                                  ),
                                  prefixIcon: Icon(Icons.phone,color: Colors.white70,),
                                  labelText: "PHONE",
                                  labelStyle: TextStyle(color: Colors.white70),
                                ),
                              ),
                              width: MediaQuery.of(context).size.width * 0.15,
                              decoration: BoxDecoration(
                                  color: Color(0xff2a2c31),
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12))
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.015,
                    ),

                  ],
                ),
              ),
            ],
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
    child: Text("SUBMIT",style: TextStyle(color: Colors.white70,fontSize: 18,),textAlign: TextAlign.center,),
    )
    ),
    ),
    ),
        ],
      ),
    );
  }
}
