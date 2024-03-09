import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoice/bloc/template/template_bloc.dart';
import 'package:invoice/bloc/template/template_state.dart';
import 'package:invoice/constant.dart';
import 'package:invoice/ui/editable_text.dart';

class InvoiceTable extends StatelessWidget {
  const InvoiceTable({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TemplateBloc, TemplateState>(builder: (context, state) {
      final List<Map<String, dynamic>> items =
          state.templateType.layout[LayoutKeys.items];

      final Map<String, dynamic> itemsColumns =
          state.templateType.layout[LayoutKeys.itemsColumns];

      final List<Widget> itemColumnWidget = itemsColumns.keys
          .map((key) => EditText(
                templateKey: key,
                type: Types.itemColumns,
              ))
          .toList();

      return Column(
        children: [
          CreateRow(children: itemColumnWidget),
          const SizedBox(height: 5),
          Container(height: 1, color: Colors.black),
          ...items.map((e) => CreateRow(
              children: e.keys
                  .map((key) => Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                        child: EditItemsText(
                          templateKey: key,
                          value: e[key].toString(),
                          rowNum: e[e.keys.first] as int,
                          isEditable: (key == TableKeys.itemRowNumber) ? false : ( key == TableKeys.itemLineTotal) ? false : true
                        ),
                      ))
                  .toList()))
        ],
      );
    });
  }
}

class CreateRow extends StatelessWidget {
  const CreateRow({super.key, required this.children});
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Row(
      children: [
        SizedBox(width: width * 0.05, child: children[0]),
        SizedBox(width: width * 0.35, child: children[1]),
        SizedBox(width: width * 0.05, child: children[2]),
        SizedBox(width: width * 0.1, child: children[3]),
        SizedBox(width: width * 0.1, child: children[4]),
        SizedBox(width: width * 0.1, child: children[5]),
        SizedBox(width: width * 0.1, child: children[6]),
      ],
    );
  }
}
