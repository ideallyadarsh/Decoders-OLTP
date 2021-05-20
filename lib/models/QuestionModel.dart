class Question {
  String id;
  String link;
  String question;
  String type;
  String code;
  String opt1;
  String opt2;
  String opt3;
  String opt4;


  Question({this.id, this.question,this.link, this.type, this.code, this.opt1, this.opt2,
      this.opt3, this.opt4});

  factory Question.fromJson(Map<String, dynamic> parsedJson)
  {
    return new Question(
        id: parsedJson['id'],
        question: parsedJson['ques'],
        link: parsedJson['link'],
        type: parsedJson['type'],
        code: parsedJson['code'],
        opt1: parsedJson['opt1'],
        opt2: parsedJson['opt2'],
        opt3: parsedJson['opt3'],
        opt4: parsedJson['opt4']
    );
  }



}

