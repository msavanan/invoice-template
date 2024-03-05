import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoice/bloc/pdf/pdf_bloc.dart';
import 'package:invoice/bloc/pdf/pdf_state.dart';
import 'package:invoice/bloc/template/template_bloc.dart';
import 'package:invoice/bloc/template/template_state.dart';
import 'package:invoice/constant.dart';
import 'package:invoice/template_one.dart';
import 'package:invoice/template_type.dart';
import 'package:invoice/ui/invoice/add_row.dart';
import 'package:invoice/ui/invoice/billing.dart';
import 'package:invoice/ui/invoice/header.dart';
import 'package:invoice/ui/invoice/invoice_table.dart';
import 'package:invoice/terms_conditions.dart';
import 'package:invoice/total.dart';
import 'package:invoice/ui/editable_text.dart';

void main() {
  runApp(const Invoice());
}

class Invoice extends StatelessWidget {
  const Invoice({super.key});
  @override
  Widget build(BuildContext context) {
    const url =
        "https://upload.wikimedia.org/wikipedia/commons/thumb/3/36/Hopetoun_falls.jpg/220px-Hopetoun_falls.jpg";
    return MultiBlocProvider(
      providers: [
        BlocProvider<PdfBloc>(
            create: (BuildContext context) => PdfBloc(PdfInitialState())),
        BlocProvider<TemplateBloc>(create: (BuildContext context) {
          final Map<String, dynamic> hovered = {};

          for (var key in layoutOne.keys) {
            final type = layoutOne[key]!.runtimeType;

            // else if (type == List<Map<String, dynamic>>) {
            if (key == LayoutKeys.itemsColumns) {
              hovered[key] = {};
              for (String m in layoutOne[key]!.keys) {
                hovered[key].putIfAbsent(m, () => false);
              }
            } else if ((key == LayoutKeys.items) || (key == LayoutKeys.taxes)) {
              hovered[key] = [];
              for (Map<String, dynamic> m in layoutOne[key]!) {
                Map<String, bool> t = {};
                for (String k in m.keys) {
                  t.putIfAbsent(k, () => false);
                }
                hovered[key].add(t);
              }
            } else if (type == String) {
              hovered[key] = false;
            }
          }
          return TemplateBloc(InitialTemplate(
              TemplateType(layout: layoutOne, hovered: hovered)));
        }),
      ],
      child: MaterialApp(
          home: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(50.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Header(url: url),
                Container(
                    margin: const EdgeInsets.only(top: 20),
                    height: 1,
                    color: Colors.black),
                const Billing(),
                const SizedBox(height: 50),
                const Align(
                    alignment: Alignment.topLeft,
                    child: EditText(
                        templateKey: "invoice_title", value: "INVOICE")),
                const SizedBox(height: 10),
                const InvoiceTable(),
                const Padding(
                    padding: EdgeInsets.only(top: 20, bottom: 20),
                    child: AddRow()),
                const TotalWidget(),
                const TermCondt()
              ],
            ),
          ),
        ),
      )),
    );
  }
}
