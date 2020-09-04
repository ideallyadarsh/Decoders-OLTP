class Answer {
  String quesID;
  String opt;


  Answer({this.quesID,this.opt});

  factory Answer.fromJson(Map<String, dynamic> parsedJson)
  {
    return new Answer(
        quesID: parsedJson['id'],
        opt: parsedJson['opt']
    );
  }

}

