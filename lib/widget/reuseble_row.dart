import 'package:flutter/material.dart';

class ReUsebleRow extends StatelessWidget {
  final String? title, value;
  ReUsebleRow({Key? key, this.title, this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(title!), Text(value!)],
          ),
        ),
      const SizedBox(height: 5,),
      Divider()
      ],
    );
  }
}
