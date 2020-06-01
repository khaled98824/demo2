import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class Student {
  String _uid ;
  String _id ;
  String _name ;
  String _age;
  String _phone ;

  Student(this._uid, this._id, this._name, this._age, this._phone);

  Student.map(dynamic obj){
    this._uid = obj['uid'];
    this._id = obj['id'];
    this._name = obj['name'];
    this._age = obj['age'];
    this._phone = obj['phone'];

  }

  String get uid => _uid;
  String get id => _id;
  String get name => _name;
  String get age => _age;
  String get phone => _phone;

  Student.FromSnapShot(DataSnapshot snapshot){
    _uid = snapshot.key;
    _id = snapshot.value['id'];
    _name = snapshot.value['name'];
    _age = snapshot.value['age'];
    _phone = snapshot.value['phone'];

  }

  toSnapShot(){
    var value = {
      'id': _id,
      'name': _name,
      'age': _age,
      'phone': _phone
    };
    return value;
  }

}