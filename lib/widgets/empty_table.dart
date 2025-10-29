import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmptyTable extends StatefulWidget {
  const EmptyTable({super.key});

  @override
  State<EmptyTable> createState() => _EmptyTableState();
}

class _EmptyTableState extends State<EmptyTable> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return  Center(child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height:height * 0.1,),
        Icon(Icons.dataset_outlined, size: 80, color:Colors.grey.withOpacity(0.3),),
        SizedBox(height: 10,),
        Text('No Dataset',style: TextStyle(
          color: Colors.black,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),),
      ],
    ),);
  }
}
