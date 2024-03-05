import 'package:flutter/material.dart';
import 'package:invoice/ui/editable_text.dart';

class Header extends StatelessWidget {
  const Header({super.key, required this.url});
  final String? url;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        url != null && url!.isNotEmpty
            ? Image(
                image: NetworkImage(url ?? ''),
                width: 100,
                height: 100,
                fit: BoxFit.fill,
              )
            : Container(
                width: 100,
                height: 100,
                decoration:
                    BoxDecoration(border: Border.all(style: BorderStyle.solid)),
              ),
        const SizedBox(width: 10),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            EditText(templateKey: "company_name", value: "Dino Store"),
            EditText(
                templateKey: "company_info1", value: "227 Cobblestone Road"),
            EditText(
                templateKey: "company_info2",
                value: "30000 Bedrock, Cobblestone County"),
            EditText(templateKey: "company_info3", value: "+555 7 789-1234"),
            EditText(
                templateKey: "company_info4",
                value: "https://dinostore.bed | hello@dinostore.bed")
          ],
        ),
        const Spacer(),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            EditText(templateKey: "company_info5", value: "Payment details:"),
            EditText(templateKey: "company_info6", value: "ACC:123006705"),
            EditText(
                templateKey: "company_info7", value: "IBAN:US100000060345"),
            EditText(templateKey: "company_info8", value: "SWIFT:BOA447"),
            EditText(templateKey: "company_info9", value: "")
          ],
        ),
      ],
    );
  }
}
