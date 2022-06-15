import 'package:flutter/material.dart';
import 'package:testonenewdevce/Data/Data.dart';

class Individual extends StatelessWidget {
  final Details data;
  const Individual(this.data, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.network(
              data.avatar,
              fit: BoxFit.cover,
              loadingBuilder: (BuildContext context,Widget child, ImageChunkEvent? loading){
              if(loading == null){
                return child;
              }
              return const Center(child: CircularProgressIndicator());
            },),
            ListTile(title: Text(data.name)),
            ListTile(title: Text(data.email))
          ],
        ),
      ),
    ));
  }
}
