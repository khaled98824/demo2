import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:demo2/student.dart';


class showAll extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _FireBaseDemo();
  }

}

class _FireBaseDemo extends State<showAll> {
//  TextEditingController idController = TextEditingController();
//  TextEditingController nameController = TextEditingController();
//  TextEditingController ageController = TextEditingController();
//  TextEditingController phoneController = TextEditingController();
TextEditingController searchController =TextEditingController();
StreamSubscription<Event> _streamSubscription ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _streamSubscription =
        stdReference.child('Student').onChildAdded.listen(_onChildAdd);
  }
List<Student> allList = List();

void _onChildAdd(Event event){
  Student student = Student.FromSnapShot(event.snapshot);
  setState(() {
    allList.add(student);
  });
}


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Demo'),
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Container(
          child:Column(
            children: <Widget>[
              TextField(
                controller: searchController,
                decoration: InputDecoration(
                  labelText: 'Search'
                ),
                onSubmitted: (searchStatment){
                  searchStudent(searchStatment);
                },
                onChanged: (a){
                  if(searchController.text.length >0){
                    searchStudent(a);
                  }

                },
              ),
              Expanded(
                child: Container(
                  child: ListView.builder(
                      itemCount: allList.length,
                      itemBuilder:(BuildContext context, position){
                        Divider(height: 2,thickness: 3,);
                        return Card(
                          child: ListTile(
                            title: Text(allList[position].name),
                            subtitle:Text(allList[position].age) ,
                            leading: CircleAvatar(
                              child: Text(allList[position].id),
                            ),
                            trailing:IconButton(icon:Icon(Icons.delete),
                                onPressed:(){
                                  deleteStudent(allList[position].uid);
                                  allList.removeAt(position);
                                  setState(() {
                                    allList = allList;
                                  });
                                }) ,
                            onTap:(){
                              print(allList.length);
                            },
                          )
                          ,
                        );

                      }
                  ) ,
                ),
              )
            ],
          )

  ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _streamSubscription.cancel();
  }

  var stdReference = FirebaseDatabase.instance.reference();
  DatabaseReference getStudentReference (){
    stdReference = stdReference.root();
    return stdReference;
  }

  void addStudent (Student student){
    stdReference= getStudentReference();
    stdReference.child('Student').push().set(student.toSnapShot());

  }

  void deleteStudent (String uid){
    stdReference= getStudentReference();
    stdReference.child('Student').child(uid).remove();
  }

  List<Student> searchStudents = List();
  void searchStudent (String searchStatment){
    searchStudents.clear();
    setState(() {
      allList = searchStudents;
    });
    Query query = stdReference
        .child("Student").orderByChild("name").
    equalTo(searchStatment.trim());

    query.once().then((snapshot){
      String id,name1,age,phone;
      snapshot.value.forEach((key ,value){
       id = value['id'].toString().trim();
       name1 = value['name'].toString().trim();
       age = value['age'].toString().trim();
       phone = value['phone'].toString().trim();
        searchStudents.add(Student(key, id, name1, age, phone));

      });
    });
  }
}