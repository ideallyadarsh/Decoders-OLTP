import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminAddQuestion extends StatefulWidget {
  @override
  _AdminAddQuestionState createState() => _AdminAddQuestionState();
}

class _AdminAddQuestionState extends State<AdminAddQuestion> {

  final testIDController = TextEditingController();
  final questionController = TextEditingController();
  final codeController = TextEditingController();
  final optAController = TextEditingController();
  final optBController = TextEditingController();
  final optCController = TextEditingController();
  final optDController = TextEditingController();
  var _optValue=1;
  String testID;
  var submitButtonStatus=1; //1:idle,2:pending,3:success,4:failure
  final fireStoreInstance = Firestore.instance;

  returnIdleButtonDelay(){
    Future.delayed(const Duration(seconds: 2),(){
      setState(() {
        submitButtonStatus =1;
      });
    });
  }


  submitQuestion()async{
    setState(() {
      submitButtonStatus = 2;
    });
    if(questionController.text==""||optDController.text==""||optCController.text==""||optBController.text==""||optAController.text==""||testID=="")
      {
        setState(() {
          submitButtonStatus = 4;
        });
        returnIdleButtonDelay();
      }
      else {
      try {
        DocumentReference ref = fireStoreInstance.collection("tests").document(
            testID).collection("questions").document();
        String docID = ref.documentID;
        await ref.setData({
          "id": docID,
          "ques": questionController.text,
          "code": codeController.text,
          "type": codeController.text == "" ? "standard" : "code",
          "opt1": optAController.text,
          "opt2": optBController.text,
          "opt3": optCController.text,
          "opt4": optDController.text,
        });
        await fireStoreInstance.collection("answers")
            .document(testID)
            .collection("correctanswers")
            .document(docID).setData({
          "id": docID, "opt": _optValue.toString()
        });
        var questionsCount;
        await fireStoreInstance.collection("tests").document(testID.toLowerCase()).get().then((querySnapshot) => {
        questionsCount=int.parse(querySnapshot.data["noofquestions"])
        });
        questionsCount++;
        await fireStoreInstance.collection("tests").document(testID).updateData({
          "noofquestions": questionsCount.toString()
        });
        setState(() {
          submitButtonStatus = 3;
        });
        questionController.clear();
        codeController.clear();
        optAController.clear();
        optBController.clear();
        optCController.clear();
        optDController.clear();
        returnIdleButtonDelay();
      }
      catch (error) {
        print(error);
        setState(() {
          submitButtonStatus = 4;
        });
        returnIdleButtonDelay();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.05,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: TextField(
                controller: testIDController,
                style: TextStyle(color: Colors.white70),
                decoration: new InputDecoration(
                  fillColor: Color(0xff36393f),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff2f3136))
                  ),
                  prefixIcon: Icon(Icons.keyboard_hide,color: Colors.white70,),
                  labelText: "Input Test ID",
                  labelStyle: TextStyle(color: Colors.white70),
                ),
              ),
              width: MediaQuery.of(context).size.width * 0.3,
              decoration: BoxDecoration(
                  color: Color(0xff2f3136),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12),)
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width*0.02,
            ),
            InkWell(
              onTap: (){
                  setState(() {
                    testID = testIDController.text;
                  });
              },
              child: Container(
                height: MediaQuery.of(context).size.height * 0.08,
                width: MediaQuery.of(context).size.height * 0.08,
                decoration: BoxDecoration(
                    color: Color(0xff145cae),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12),bottomRight: Radius.circular(12),bottomLeft: Radius.circular(12))
                ),
                child: Center(
                  child: Icon(Icons.search),
                ),
              ),
            )
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.05,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width*0.35,
              height: MediaQuery.of(context).size.height*0.25,
              child: TextField(
                controller: questionController,
                expands: true,
                minLines: null,
                maxLines: null,
                style: TextStyle(color: Colors.white70),
                decoration: new InputDecoration(
                  fillColor: Color(0xff36393f),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff2f3136))
                  ),
                  labelText: "Question Input",
                  labelStyle: TextStyle(color: Colors.white70,),
                  floatingLabelBehavior: FloatingLabelBehavior.always
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width*0.05,
            ),
            Container(
              width: MediaQuery.of(context).size.width*0.35,
              height: MediaQuery.of(context).size.height*0.25,
              child: TextField(
                controller: codeController,
                expands: true,
                minLines: null,
                maxLines: null,
                style: TextStyle(color: Colors.white70),
                decoration: new InputDecoration(
                  fillColor: Color(0xff36393f),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff2f3136))
                  ),
                  labelText: "Code Input",
                  labelStyle: TextStyle(color: Colors.white70),
                  floatingLabelBehavior: FloatingLabelBehavior.always
                ),
              ),
            )
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.05,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width*0.05,
              child: Radio(value: 1, groupValue: _optValue, onChanged: (var value){
                setState(() {
                  _optValue = value;
                });
              }),
            ),
            Container(
              width: MediaQuery.of(context).size.width*0.35,
              height: MediaQuery.of(context).size.height*0.1,
              child: TextField(
                controller: optAController,
                expands: true,
                minLines: null,
                maxLines: null,
                style: TextStyle(color: Colors.white70),
                decoration: new InputDecoration(
                    fillColor: Color(0xff36393f),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff2f3136))
                    ),
                    labelText: "Option A Input",
                    labelStyle: TextStyle(color: Colors.white70,),
                    floatingLabelBehavior: FloatingLabelBehavior.always
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width*0.05,
              child: Radio(value: 2, groupValue: _optValue, onChanged: (var value){
                setState(() {
                  _optValue = value;
                });
              }),
            ),
            Container(
              width: MediaQuery.of(context).size.width*0.35,
              height: MediaQuery.of(context).size.height*0.1,
              child: TextField(
                controller: optBController,
                expands: true,
                minLines: null,
                maxLines: null,
                style: TextStyle(color: Colors.white70),
                decoration: new InputDecoration(
                    fillColor: Color(0xff36393f),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff2f3136))
                    ),
                    labelText: "Option B Input",
                    labelStyle: TextStyle(color: Colors.white70),
                    floatingLabelBehavior: FloatingLabelBehavior.always
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width*0.05,
            )
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.05,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width*0.05,
              child: Radio(value: 3, groupValue: _optValue, onChanged: (var value){
                setState(() {
                  _optValue = value;
                });
              }),
            ),
            Container(
              width: MediaQuery.of(context).size.width*0.35,
              height: MediaQuery.of(context).size.height*0.1,
              child: TextField(
                controller: optCController,
                expands: true,
                minLines: null,
                maxLines: null,
                style: TextStyle(color: Colors.white70),
                decoration: new InputDecoration(
                    fillColor: Color(0xff36393f),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff2f3136))
                    ),
                    labelText: "Option C Input",
                    labelStyle: TextStyle(color: Colors.white70,),
                    floatingLabelBehavior: FloatingLabelBehavior.always
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width*0.05,
              child: Radio(value: 4, groupValue: _optValue, onChanged: (var value){
                setState(() {
                  _optValue = value;
                });
              }),
            ),
            Container(
              width: MediaQuery.of(context).size.width*0.35,
              height: MediaQuery.of(context).size.height*0.1,
              child: TextField(
                controller: optDController,
                expands: true,
                minLines: null,
                maxLines: null,
                style: TextStyle(color: Colors.white70),
                decoration: new InputDecoration(
                    fillColor: Color(0xff36393f),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff2f3136))
                    ),
                    labelText: "Option D Input",
                    labelStyle: TextStyle(color: Colors.white70),
                    floatingLabelBehavior: FloatingLabelBehavior.always
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width*0.05,
            )
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.05,
        ),
    Center(
    child: InkWell(
    onTap: ()=>{
if(submitButtonStatus==1){
  submitQuestion()
    }
    },
    child: Container(
    width : MediaQuery.of(context).size.width * 0.3,
    height: MediaQuery.of(context).size.height * 0.06,
    decoration: BoxDecoration(
    shape: BoxShape.rectangle,
    borderRadius: BorderRadius.circular(5.0),
    color: submitButtonStatus==3?Colors.green:submitButtonStatus==4?Colors.deepOrange:Color(0xff145cae),
    ),
    child: Center(
    child: submitButtonStatus==2?CircularProgressIndicator():Text(submitButtonStatus==1?"SUBMIT":submitButtonStatus==3?"SUCCESS":"FAILED",style: TextStyle(color: Colors.white70,fontSize: 18,),textAlign: TextAlign.center,),
    )
    ),
    ),
    ),
      ],
    );
  }
}
