import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class home extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Align(child: AutoSizeText('JUST DO IT'), alignment: Alignment.topLeft,),
          Container(height: 10,),
          Container(color: Colors.blue,)

        ],
      ),
    );
  }

}