// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, file_names, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:ratetol/model/images_model.dart';
import 'package:ratetol/module/images/image_repository.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  List<Images> listImage = [];
  ImageRepository repository = ImageRepository();

  getData() async {
    listImage = await repository.getData();
    setState(() {});
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      backgroundColor: Colors.white,
      body: ListView.separated(
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Text(
                    'Name : ${listImage[index].name}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Created_at : ${listImage[index].created_at}',
                    style: TextStyle(fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            );
          },
          separatorBuilder: ((context, index) {
            return Divider();
          }),
          itemCount: listImage.length),
    );
  }
}
