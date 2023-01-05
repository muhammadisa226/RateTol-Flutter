// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, file_names, prefer_interpolation_to_compose_strings, unused_import, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:ratetol/model/images_model.dart';
import 'package:ratetol/module/images/image_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class History2 extends StatefulWidget {
  const History2({super.key});

  @override
  _History2State createState() => _History2State();
}

class _History2State extends State<History2> {
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
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columnSpacing: 10,
          columns: [
            DataColumn(label: Text('Name')),
            DataColumn(label: Text('Created_at')),
          ],
          rows: List.generate(listImage.length, (index) {
            return DataRow(cells: [
              DataCell(Container(child: Text(listImage[index].name))),
              DataCell(Container(child: Text(listImage[index].created_at)))
            ]);
          }),
        ),
      ),
    );
  }
}
