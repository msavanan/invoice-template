import 'package:flutter/material.dart';
import 'package:invoice/ui/editable_text.dart';

class Billing extends StatelessWidget {
  const Billing({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            EditText(templateKey: "bill_to_label", value: "Bill to:"),
            EditText(
                templateKey: "bill_to_info1",
                value: "Slate Rock and Gravel Company"),
            EditText(templateKey: "bill_to_info2", value: "222 Rocky Way"),
            EditText(
                templateKey: "bill_to_info3",
                value: "30000 Bedrock, Cobblestone County"),
            EditText(templateKey: "bill_to_info4", value: "+555 7 123-5555"),
            EditText(
                templateKey: "bill_to_info5",
                value: "fred@slaterockgravel.bed"),
          ],
        ),
        Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            BillTable(
                childOne: EditText(
                    templateKey: "invoice_number_label", value: "Invoice No."),
                childTwo: EditText(templateKey: "invoice_number", value: "1")),
            BillTable(
                childOne: EditText(
                    templateKey: "invoice_date_label", value: "Invoice Date:"),
                childTwo:
                    EditText(templateKey: "invoice_date", value: "02-03-2024")),
            BillTable(
                childOne: EditText(
                    templateKey: "issue_date_label", value: "Issue Date:"),
                childTwo:
                    EditText(templateKey: "issue_date", value: "02-03-2024")),
            BillTable(
                childOne:
                    EditText(templateKey: "due_date_label", value: "Due Date:"),
                childTwo:
                    EditText(templateKey: "due_date", value: "02-03-2024"))
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
