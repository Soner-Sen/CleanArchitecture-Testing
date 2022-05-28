import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class AdviceField extends StatelessWidget {
  final String advice;
  const AdviceField({Key? key, required this.advice}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 20,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.pinkAccent.shade200,
        ),
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Text(
              ''' " $advice " ''',
              textAlign: TextAlign.center,
            )),
      ),
    );
  }
}
