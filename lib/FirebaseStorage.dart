import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:async/async.dart';

class firebaseStorage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _firebaseStorage();
  }
}

class _firebaseStorage extends State<firebaseStorage> {
  String urlDownload ;
  NetworkImage image;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Storage Image"),
      ),
      body: Container(
        margin: EdgeInsets.all(50),
        child: Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.only(top: 13,right: 50)),
            IconButton(icon: Icon(Icons.camera),
                onPressed: () async {
                  var sampleImage =
                  await ImagePicker.pickImage(source: ImageSource.camera);
                  StorageReference fileRef =
                  FirebaseStorage.instance.ref().child("MyFirstImage");
                  StorageUploadTask task = fileRef.putFile(sampleImage);
                  (await task.onComplete).ref.getDownloadURL().then((url){
                    this.urlDownload = url;
                    print(url);
                  });
                  print('url');

                }
            ),
            RaisedButton(
              child: Text('Upload'),

                onPressed: () async {
                var sampleImage =
                await ImagePicker.pickImage(source: ImageSource.camera);
                StorageReference fileRef =
                FirebaseStorage.instance.ref().child("MyFirstImage");
                StorageUploadTask task = fileRef.putFile(sampleImage);
                (await task.onComplete).ref.getDownloadURL().then((url){
                  this.urlDownload = url;
                });
                }
            ),
            RaisedButton(
                child: Text("Download"),
                onPressed:(){
                image = NetworkImage(urlDownload);
                setState(() {
                  image = image ;
                });
                },
            ),
            image!=null ? Image(image: image,): Container()

          ],
        ),
      ),
    );
  }
}