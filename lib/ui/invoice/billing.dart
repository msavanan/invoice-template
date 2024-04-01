import 'package:flutter/material.dart';

import 'package:invoice/ui/editable_text.dart';
import 'package:invoice/ui/date_picker.dart';
import 'package:invoice/constant.dart';

class Billing extends StatelessWidget {
  const Billing({super.key});

  @override
  Widget build(BuildContext context) {
    // SizedBox(
    //   width: Paper.width,
    //   child: Wrap(
    //   direction: Axis.horizontal,
    //     alignment: WrapAlignment.spaceBetween,
    //   runAlignment: WrapAlignment.spaceBetween,
    //   crossAxisAlignment: WrapCrossAlignment.start,

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: Paper.width * 0.4,
          child: Column(
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
        ),
        SizedBox(width: 10),
        //Spacer(),
        SizedBox(
          width: Paper.width * 0.4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BillTable(
                  childOne: EditText(templateKey: "invoice_number_label"),
                  childTwo: EditText(templateKey: "invoice_number")),
              BillTable(
                  childOne: EditText(templateKey: "invoice_date_label"),
                  childTwo: CustomDatePicker(templateKey: 'invoice_date')),
              BillTable(
                  childOne: EditText(templateKey: "issue_date_label"),
                  childTwo: CustomDatePicker(templateKey: 'issue_date')),
              BillTable(
                  childOne: EditText(templateKey: "due_date_label"),
                  childTwo: CustomDatePicker(templateKey: 'due_date')),
            ],
          ),
        ),
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
    return SizedBox(
      width: Paper.width * 0.4,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
              width: Paper.width * 0.25,
              child: Align(alignment: Alignment.centerRight, child: childOne),
            ),
            IntrinsicWidth(
                child: Align(alignment: Alignment.centerRight, child: childTwo))
          ]),
    );
  }
}
