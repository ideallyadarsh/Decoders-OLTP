import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:oltp/models/AnswerModel.dart';
import 'package:oltp/models/StudentResultModel.dart';
import 'package:oltp/screens/widgets/AdminAddQuestions.dart';
import 'package:oltp/screens/widgets/AdminHome.dart';
import 'package:oltp/screens/widgets/AdminResults.dart';

class AdminPanel extends StatefulWidget {
  @override
  _AdminPanelState createState() => _AdminPanelState();
}

class DrawerItem {
  String title;
  IconData icon;
  DrawerItem(this.title, this.icon);
}

class _AdminPanelState extends State<AdminPanel> {

  int _selectedDrawerIndex = 0;

  final drawerItems = [
    new DrawerItem("Home", Icons.home),
    new DrawerItem("Results", Icons.schedule),
    new DrawerItem("Add Questions",Icons.question_answer)
  ];

  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return new AdminHome();
      case 1:
        return new AdminResults();
      case 2:
        return new AdminAddQuestion();
      case 3:
        return new Text("Error");
      default:
        return new Text("Error");
    }
  }


  _onSelectItem(int index) {
    setState(() => _selectedDrawerIndex = index);
    Navigator.of(context).pop(); // close the drawer
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff36393f),
      appBar: AppBar(
          backgroundColor: Color(0xff2f3136),
          automaticallyImplyLeading: true, // hides leading widget
      ),
        drawer : SizedBox(
          width: MediaQuery.of(context).size.width * 0.2,
          child: Drawer(
            // column holds all the widgets in the drawer
            child: Column(
              children: <Widget>[
                Container(
                  height : MediaQuery.of(context).size.height*0.3,
                  color: const Color(0xff2f3136),
                ),
                Container(
                    height : MediaQuery.of(context).size.height*0.7,
                    color: const Color(0xff2f3136),
                    child:
                    ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: drawerItems.length,
                        itemBuilder: (BuildContext contxt, int Index) {
                          return new
                          Container(
                            height: MediaQuery.of(context).size.height*0.1,
                            decoration: BoxDecoration(
                              color: _selectedDrawerIndex == Index? Color(0xff36393f) : Color(0xff2f3136),
                            ),
                            child: Center(
                              child: ListTile(
                                title: new Text(drawerItems[Index].title,style: TextStyle(color: Colors.white70,fontSize: 20),),
                                leading: new Icon(drawerItems[Index].icon,color: Colors.white70,size: MediaQuery.of(context).size.height*0.05,),
                                selected: Index == _selectedDrawerIndex,
                                onTap: () => _onSelectItem(Index),
                              ),
                            ),
                          );
                        }
                    )

                ),
                // This container holds the align
              ],
            ),
          ),
        ),
      body: _getDrawerItemWidget(_selectedDrawerIndex),
    );
  }
}
