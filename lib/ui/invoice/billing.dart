import 'package:flutter/material.dart';
import 'package:invoice/ui/editable_text.dart';
import 'package:invoice/ui/date_picker.dart';

class Billing extends StatelessWidget {
  const Billing({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            EditText(templateKey: "bill_to_label"),
            EditText(templateKey: "bill_to_info1"),
            EditText(templateKey: "bill_to_info2"),
            EditText(templateKey: "bill_to_info3"),
            EditText(templateKey: "bill_to_info4"),
            EditText(templateKey: "bill_to_info5"),
          ],
        ),
        Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            BillTable(
                childOne: EditText(templateKey: "invoice_number_label"),
                childTwo: EditText(templateKey: "invoice_number")),
            BillTable(
                childOne: EditText(templateKey: "invoice_date_label"),
                //childTwo: EditText(templateKey: "invoice_date")),
                childTwo: CustomDatePicker(templateKey: 'invoice_date')),
            BillTable(
                childOne: EditText(templateKey: "issue_date_label"),
                //childTwo: EditText(templateKey: "issue_date")),
                childTwo: CustomDatePicker(templateKey: 'issue_date')),
            BillTable(
                childOne: EditText(templateKey: "due_date_label"),
                //childTwo: EditText(templateKey: "due_date"))
                childTwo: CustomDatePicker(templateKey: 'due_date')),
          ],
        )
      ],
    );
  }
}

class BillTable extends StatelessWidget {
  const BillTable({super.key, required this.childOne, required this.childTwo});
  final Widget childOne;
  final Widget childTwo;

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [childOne, childTwo]);
  }
}
