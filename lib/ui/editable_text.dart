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
      this.type = Types.defaults,
      this.isEditable = true});
  final String templateKey;
  final String type;
  final bool isEditable;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TemplateBloc, TemplateState>(
      builder: (context, state) {
        final hovered = state.templateType.hovered[templateKey] ?? false;
        final templateBlocNotifier = context.read<TemplateBloc>();
        final txt = templateBlocNotifier.state.templateType
            .getValue(templateKey, type: type);

        return MouseRegion(
          onHover: (pointerHoverEvent) {
            templateBlocNotifier.add(Hover(key: templateKey));
          },
          onExit: (pointerExitEvent) {
            templateBlocNotifier.add(Exit(key: templateKey));
          },
          child: hovered && isEditable
              ? EditableTextFormField(
                  txt: txt,
                  width: 250,
                  onChanged: (String? value) {
                    templateBlocNotifier.add(Update(
                        key: templateKey, value: value ?? '', type: type));
                  },
                )
              : IntrinsicWidth(
                  child: Text(
                  txt,
                  softWrap: true,
                )),
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
      required this.rowNum,
      this.textAlign = TextAlign.center,
      this.isEditable = true});
  final String templateKey;
  final String value;
  final int rowNum;
  final bool isEditable;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TemplateBloc, TemplateState>(
      builder: (context, state) {
        final hovered = state.templateType
            .getHoveredItemValue(key: templateKey, rowNum: rowNum);
        final templateBlocNotifier = context.read<TemplateBloc>();
        final txt = templateBlocNotifier.state.templateType
            .getItemValue(key: templateKey, rowNum: rowNum);

        final addRemoveIcon = hovered
            ? InkWell(
                onTap: () {
                  context.read<TemplateBloc>().add(DeleteRow(rowNum));
                  context.read<TemplateBloc>().add(const Success());
                },
                child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Icon(Icons.remove_circle_outline_outlined)),
              )
            : const SizedBox.shrink();

        return MouseRegion(
          onHover: (pointerHoverEvent) {
            templateBlocNotifier
                .add(HoverItem(key: templateKey, rowNum: rowNum));
          },
          onExit: (pointerExitEvent) {
            templateBlocNotifier
                .add(ExitItem(key: templateKey, rowNum: rowNum));
          },
          child: hovered && isEditable == true
              ? EditableTextFormField(
                  readOnly: !(hovered && isEditable),
                  txt: txt,
                  width: 250,
                  onChanged: (String? value) {
                    templateBlocNotifier.add(UpdateItem(
                        key: templateKey, value: value ?? '', rowNum: rowNum));
                  },
                )
              : IntrinsicWidth(
                  child: Row(
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        addRemoveIcon,
                        Container(color: Colors.red, width: hovered ? 5 : 0),
                        Flexible(
                            child: Text(
                          txt,
                          textAlign: textAlign,
                          softWrap: true,
                        ))
                        //textAlign: TextAlign.start
                      ]),
                ),
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
    this.textAlign = TextAlign.start,
    this.readOnly = false,
  });
  final Function(String)? onChanged;
  final String txt;
  final double width;
  final TextAlign textAlign;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
        child: TextFormField(
      readOnly: readOnly,
      initialValue: txt,
      textAlign: textAlign,
      scrollPadding: const EdgeInsets.all(0),
      // inputFormatters: [
      //   LengthLimitingTextInputFormatter(40),
      // ],
      maxLines: null, enableInteractiveSelection: true,
      keyboardType: TextInputType.multiline,
      decoration: const InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(0.0))),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(0.0))),
          contentPadding: EdgeInsets.all(2),
          isDense: true),
      onChanged: onChanged,
    ));
  }
}
