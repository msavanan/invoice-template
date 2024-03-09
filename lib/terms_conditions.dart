import 'package:flutter/material.dart';
import 'package:invoice/ui/editable_text.dart';

class TermCondt extends StatelessWidget {
  const TermCondt({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        EditText(templateKey: "terms_label"),
        EditText(templateKey: "terms"),
      ],
    );
  }
}
