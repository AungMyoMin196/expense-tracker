import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AmountIndicator extends StatelessWidget {
  const AmountIndicator(
      {Key? key,
      required this.amount,
      required this.type,
      this.isMinus = false})
      : super(key: key);

  final num amount;
  final String type;
  final bool isMinus;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        CircleAvatar(
          backgroundColor: Colors.white,
          radius: 20.0,
          child: Icon(
            type.toLowerCase() == 'income'
                ? CupertinoIcons.arrow_up
                : CupertinoIcons.arrow_down,
            color: type.toLowerCase() == 'income' ? Colors.green : Colors.red,
            size: 20.0,
          ),
        ),
        const SizedBox(
          width: 10.0,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              type,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w300,
              ),
            ),
            Text(
              (isMinus ? '-' : '') + '¥ ${amount.toStringAsFixed(0)}',
              style: TextStyle(
                color: isMinus ? Colors.red : Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
