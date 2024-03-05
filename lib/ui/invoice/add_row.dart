import 'package:flutter/material.dart';

class AddRow extends StatelessWidget {
  const AddRow({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Link(txt: "Add row"),
        SizedBox(width: 30),
        Link(txt: "Configure Column"),
      ],
    );
  }
}

class Link extends StatelessWidget {
  const Link({super.key, required this.txt});
  final String txt;

  @override
  Widget build(BuildContext context) {
    return Text(txt,
        style: const TextStyle(decoration: TextDecoration.underline));
  }
}
