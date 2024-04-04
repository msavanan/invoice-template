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
              rowNum: e[TableKeys.itemRowNumber],
              children: e.keys.map((key) {
                TextAlign textAlign = TextAlign.center;
                if (key == TableKeys.itemDescription) {
                  textAlign = TextAlign.start;
                } else if (key == TableKeys.itemLineTotal) {
                  textAlign = TextAlign.end;
                }

                return Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: EditItemsText(
                    textAlign: textAlign,
                    templateKey: key,
                    value: e[key].toString(),
                    rowNum: e[e.keys.first] as int,
                    isEditable: (key == TableKeys.itemRowNumber)
                        ? false
                        : (key == TableKeys.itemLineTotal)
                            ? false
                            : true,
                  ),
                );
              }).toList()))
        ],
      );
    });
  }
}

class CreateRow extends StatelessWidget {
  const CreateRow({super.key, required this.children, this.rowNum});
  final List<Widget> children;
  final int? rowNum;

  @override
  Widget build(BuildContext context) {
    const width = Paper.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(width: width * 0.1, child: SetAlignment(child: children[0])),
        SizedBox(
            width: width * 0.25,
            child: SetAlignment(
                alignment: Alignment.centerLeft, child: children[1])),
        SizedBox(width: width * 0.1, child: SetAlignment(child: children[2])),
        SizedBox(width: width * 0.1, child: SetAlignment(child: children[3])),
        SizedBox(width: width * 0.1, child: SetAlignment(child: children[4])),
        SizedBox(width: width * 0.1, child: SetAlignment(child: children[5])),
        SizedBox(
            width: width * 0.1,
            child: SetAlignment(
                alignment: Alignment.centerRight, child: children[6])),
      ],
    );
  }
}

class SetAlignment extends StatelessWidget {
  const SetAlignment(
      {super.key, required this.child, this.alignment = Alignment.center});
  final Widget child;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return Align(alignment: alignment, child: child);
  }
}
