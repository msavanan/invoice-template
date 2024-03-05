import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoice/bloc/template/template_bloc.dart';
import 'package:invoice/bloc/template/template_event.dart';
import 'package:invoice/bloc/template/template_state.dart';
import 'package:invoice/constant.dart';

class EditText extends StatelessWidget {
  const EditText(
      {super.key,
      required this.templateKey,
      required this.value,
      this.type = Types.defaults});
  final String templateKey;
  final String value;
  final String type;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TemplateBloc, TemplateState>(
      builder: (context, state) {
        final hovered = state.templateType.hovered[templateKey] ?? false;
        final templateBlocNotifier = context.read<TemplateBloc>();
        final txt = templateBlocNotifier.state.templateType
            .getValue(templateKey, type: type);
        //layout[templateKey] ?? '';

        return MouseRegion(
          onHover: (pointerHoverEvent) {
            templateBlocNotifier.add(Hover(key: templateKey));
          },
          onExit: (pointerExitEvent) {
            templateBlocNotifier.add(Exit(key: templateKey));
          },
          child: hovered
              ? EditableTextFormField(
                  txt: txt,
                  width: 250,
                  onChanged: (String? value) {
                    templateBlocNotifier.add(Update(
                        key: templateKey, value: value ?? '', type: type));
                  },
                )
              //: Text(value),
              : Text(txt),
        );
      },
    );
  }
}

class EditItemsText extends StatelessWidget {
  const EditItemsText(
      {super.key,
      required this.templateKey,
      required this.value,
      required this.rowNum});
  final String templateKey;
  final String value;
  final int rowNum;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TemplateBloc, TemplateState>(
      builder: (context, state) {
        final hovered = state.templateType
            .getHoveredItemValue(key: templateKey, rowNum: rowNum);
        final templateBlocNotifier = context.read<TemplateBloc>();
        final txt = templateBlocNotifier.state.templateType
            .getItemValue(key: templateKey, rowNum: rowNum);
        //layout[templateKey] ?? '';

        return MouseRegion(
          onHover: (pointerHoverEvent) {
            templateBlocNotifier
                .add(HoverItem(key: templateKey, rowNum: rowNum));
          },
          onExit: (pointerExitEvent) {
            templateBlocNotifier
                .add(ExitItem(key: templateKey, rowNum: rowNum));
          },
          child: hovered
              ? EditableTextFormField(
                  txt: txt,
                  width: 250,
                  onChanged: (String? value) {
                    templateBlocNotifier.add(UpdateItem(
                        key: templateKey, value: value ?? '', rowNum: rowNum));
                  },
                )
              : Text(txt),
        );
      },
    );
  }
}

class EditableTextFormField extends StatelessWidget {
  const EditableTextFormField({
    super.key,
    required this.txt,
    this.width = 150,
    this.onChanged,
  });
  final Function(String)? onChanged;
  final String txt;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: width,
        child: TextFormField(
          initialValue: txt,
          textAlign: TextAlign.start,
          scrollPadding: const EdgeInsets.all(0),
          decoration: const InputDecoration(
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(0.0))),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(0.0))),
              contentPadding: EdgeInsets.all(5),
              isDense: true),
          onChanged: onChanged,
        ));
  }
}
