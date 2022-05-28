import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class CustomButton extends StatelessWidget {
  final Function onPressed;
  const CustomButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: () => onPressed(),
      child: Material(
        elevation: 20,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.pink,
          ),
          child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: Text('Get Advice')),
        ),
      ),
    );
  }
}
