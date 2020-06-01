import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:demo2/student.dart';
import 'package:demo2/showAll.dart';


class FireBaseDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _FireBaseDemo();
  }

}

class _FireBaseDemo extends State<FireBaseDemo> {
  TextEditingController idController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Demo'),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 30,right: 30),

        child: Container(
          child: Column(
            children: <Widget>[
              TextField(
                controller:idController ,
                decoration: InputDecoration(
                  labelText: 'ID'
                ),
              ),
              TextField(
                controller:nameController ,
                decoration: InputDecoration(
                    labelText: 'NAME'
                ),
              ),
              TextField(
                controller:ageController ,
                decoration: InputDecoration(
                    labelText: 'AGE'
                ),
              ),
              TextField(
                controller: phoneController,
                decoration: InputDecoration(
                    labelText: 'PHONE'
                ),
              ),
              Padding(padding: EdgeInsets.all(6)),
              RaisedButton(
                child: Text('Insert',style: TextStyle(fontSize: 16)),
                  onPressed: (){
                  if(!idController.text.isEmpty && !nameController.text.isEmpty && !ageController.text.isEmpty && !phoneController.text.isEmpty){
                    addStudent(Student('0', idController.text, nameController.text,
                        ageController.text, phoneController.text));
                  }

                  }
                  ),
              RaisedButton(
                  child: Text('Update',style: TextStyle(fontSize: 16),),
                  onPressed: (){
                    if(!idController.text.isEmpty && !nameController.text.isEmpty && !ageController.text.isEmpty && !phoneController.text.isEmpty){
                      updateStudent (Student('-M6HV6kA99TOUXbyk5U-',idController.text,nameController.text,
                          ageController.text, phoneController.text));
                    }

                  }
              ),
              RaisedButton(
                  child: Text('Show',style: TextStyle(fontSize: 16)),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return showAll();
                    }));
                  }
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

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

  void updateStudent (Student student){
    stdReference= getStudentReference();
    stdReference.child('Student').child(student.uid).update({
      'id': student.id,
      'name': student.name,
      'age': student.age,
      'phone': student.phone
    });

  }

}