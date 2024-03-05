import 'package:flutter/material.dart';
import 'package:invoice/constant.dart';
import 'package:invoice/ui/editable_text.dart';

class TotalWidget extends StatelessWidget {
  const TotalWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        TotalTable(
            childOne: EditText(
                templateKey: "amount_subtotal_label", value: "Subtotal:"),
            childTwo: EditText(templateKey: "amount_subtotal", value: "300")),
        SizedBox(height: 25),
        TotalTable(
            childOne: EditText(
                templateKey: "tax_name", value: "Tax 19%:", type: Types.taxes),
            childTwo: EditText(
                templateKey: "tax_value", value: "19", type: Types.taxes)),
        DividerWidget(),
        TotalTable(
            childOne:
                EditText(templateKey: "amount_total_label", value: "Total:"),
            childTwo: EditText(templateKey: "amount_total", value: "119")),

        // TotalTable(
        //     childOne:
        //         EditText(templateKey: "amount_paid_label", value: "Paid:"),
        //     childTwo: EditText(templateKey: "amount_paid", value: "0")),
        // TotalTable(
        //     childOne:
        //         EditText(templateKey: "amount_due_label", value: "Amount Due:"),
        //     childTwo: EditText(templateKey: "amount_due", value: "119"))
      ],
    );
  }
}

class DividerWidget extends StatelessWidget {
  const DividerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      width: MediaQuery.of(context).size.width * 0.2,
      height: 1,
      color: Colors.black,
      margin: const EdgeInsets.only(top: 20, bottom: 20),
    );
  }
}

class TotalTable extends StatelessWidget {
  const TotalTable({super.key, required this.childOne, required this.childTwo});
  final Widget childOne;
  final Widget childTwo;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.end, children: [
      SizedBox(
          width: MediaQuery.of(context).size.width * 0.1,
          child: Align(alignment: Alignment.centerLeft, child: childOne)),
      SizedBox(
          width: MediaQuery.of(context).size.width * 0.05,
          child: Align(alignment: Alignment.centerRight, child: childTwo))
    ]);
  }
}
