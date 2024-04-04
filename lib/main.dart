import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoice/bloc/template/template_bloc.dart';
import 'package:invoice/bloc/template/template_state.dart';
import 'package:invoice/constant.dart';
import 'package:invoice/generate_pdf.dart';
import 'package:invoice/pdf/read_template_type.dart';
import 'package:invoice/template_one.dart';
import 'package:invoice/template_type.dart';
import 'package:invoice/ui/invoice/links.dart';
import 'package:invoice/ui/invoice/billing.dart';
import 'package:invoice/ui/invoice/header.dart';
import 'package:invoice/ui/invoice/invoice_table.dart';
import 'package:invoice/terms_conditions.dart';
import 'package:invoice/total.dart';
import 'package:invoice/ui/editable_text.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TemplateBloc>(create: (BuildContext context) {
          final Map<String, dynamic> hovered = {};

          for (var key in layoutOne.keys) {
            final type = layoutOne[key]!.runtimeType;

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
      child: const MaterialApp(home: Invoice()),
    );
  }
}

class Invoice extends StatelessWidget {
  const Invoice({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
          width: Paper.width,
          height: 60,
          child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              onPressed: () {
                ReadTemplate(context.read<TemplateBloc>().state.templateType);
                generatePdf();
              },
              child: Row(children: [
                Icon(Icons.print_rounded),
                SizedBox(width: 8),
                const Text("Print"),
              ]),
            ),
          ])),
      Flexible(
        child: Scaffold(
            body: SingleChildScrollView(
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(40.0),
              margin: const EdgeInsets.only(top: 40.0),
              width: Paper.width,
              //height: Paper.height,
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(2, 2),
                    blurRadius: 12,
                    color: Color.fromRGBO(0, 0, 0, 0.16),
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Header(),
                  Container(
                      margin: const EdgeInsets.only(top: 20),
                      height: 1,
                      color: Colors.black),
                  const Billing(),
                  const SizedBox(height: 50),
                  const Align(
                      alignment: Alignment.topLeft,
                      child: EditText(templateKey: "invoice_title")),
                  const SizedBox(height: 10),
                  const InvoiceTable(),
                  const Padding(
                      padding: EdgeInsets.only(top: 20, bottom: 20),
                      child: Links()),
                  const TotalWidget(),
                  const TermCondt()
                ],
              ),
            ),
          ),
        )),
      )
    ]);
  }
}
