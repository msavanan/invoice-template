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
        String txt = templateBlocNotifier.state.templateType
            .getValue(templateKey, type: type);

        if (templateKey == LayoutKeys.amountTotal) {
          print(
              'templateBlocNotifier.state.templateType.currency: ${templateBlocNotifier.state.templateType.currency}');
          txt = (templateBlocNotifier.state.templateType.currency ?? '') +
              ' ' +
              txt;
        }

        return MouseRegion(
          onHover: (pointerHoverEvent) {
            templateBlocNotifier.add(Hover(key: templateKey));
          },
          onExit: (pointerExitEvent) {
            templateBlocNotifier.add(Exit(key: templateKey));
          },
          child: hovered && isEditable
              ? EditableTextFormField(
                  isHovered: hovered,
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
          //child: true //hovered && isEditable == true ?
          child: (templateKey == LayoutKeys.itemLineTotal ||
                  templateKey == TableKeys.itemRowNumber)
              ? templateKey == TableKeys.itemRowNumber
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                          addRemoveIcon,
                          Container(color: Colors.red, width: hovered ? 5 : 0),
                          Text(
                            txt,
                            textAlign: TextAlign.center,
                            softWrap: true,
                          ),
                        ])
                  : Text(
                      txt,
                      textAlign: TextAlign.right,
                      softWrap: true,
                    )
              : EditableTextFormField(
                  isHovered: hovered,
                  readOnly: !(hovered && isEditable),
                  txt: txt,
                  width: 250,
                  textAlign: textAlign,
                  onChanged: (String? value) {
                    templateBlocNotifier.add(UpdateItem(
                        key: templateKey, value: value ?? '', rowNum: rowNum));
                    context.read<TemplateBloc>().add(const Success());
                  },
                ),
          // : WrapSizing(
          //     isTxtEmpty: txt.isEmpty,
          //     child: Row(
          //         //crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           addRemoveIcon,
          //           Container(color: Colors.red, width: hovered ? 5 : 0),
          //           Sizing(
          //             isTxtEmpty: txt.isEmpty,
          //             child: Text(
          //               txt,
          //               textAlign: textAlign,
          //               softWrap: true,
          //             ),
          //           )
          //           //textAlign: TextAlign.start
          //         ]),
          //   )
        );
      },
    );
  }
}

class EditableTextFormField extends StatefulWidget {
  const EditableTextFormField({
    super.key,
    required this.txt,
    this.width = 150,
    this.onChanged,
    this.textAlign = TextAlign.start,
    this.readOnly = false,
    this.isHovered = false,
  });
  final void Function(String)? onChanged;
  final String txt;
  final double width;
  final TextAlign textAlign;
  final bool readOnly;
  final bool isHovered;

  @override
  State<EditableTextFormField> createState() => _EditableTextFormFieldState();
}

class _EditableTextFormFieldState extends State<EditableTextFormField> {
  var focusNode = FocusNode();
  @override
  void initState() {
    focusNode.addListener(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WrapSizing(
      isTxtEmpty: widget.isHovered || widget.txt.trim().isEmpty,
      child: TextFormField(
        autofocus: widget.isHovered,
        //focusNode: widget.isHovered,//focusNode,
        readOnly: widget.readOnly,
        initialValue: widget.txt,
        textAlign: widget.textAlign,
        scrollPadding: const EdgeInsets.all(0),
        // inputFormatters: [
        //   LengthLimitingTextInputFormatter(40),
        // ],
        maxLines: null, enableInteractiveSelection: true,
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
                //|| (widget.txt.trim().isNotEmpty && !focusNode.hasFocus)
                borderSide: widget.readOnly && widget.txt.trim().isNotEmpty
                    ? BorderSide(color: Colors.white)
                    : const BorderSide(),
                borderRadius: BorderRadius.all(Radius.circular(0.0))),
            enabledBorder: OutlineInputBorder(
                //|| (widget.txt.trim().isNotEmpty && !focusNode.hasFocus)
                borderSide: widget.readOnly && widget.txt.trim().isNotEmpty
                    ? BorderSide(color: Colors.white)
                    : const BorderSide(),
                borderRadius: BorderRadius.all(Radius.circular(0.0))),
            contentPadding: EdgeInsets.all(2),
            isDense: true),
        onChanged: widget.onChanged,
      ),
    );
  }
}

class Sizing extends StatelessWidget {
  const Sizing({super.key, required this.isTxtEmpty, required this.child});

  final bool isTxtEmpty;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return isTxtEmpty ? Expanded(child: child) : Flexible(child: child);
  }
}

class WrapSizing extends StatelessWidget {
  const WrapSizing({super.key, required this.isTxtEmpty, required this.child});

  final bool isTxtEmpty;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return isTxtEmpty ? child : IntrinsicWidth(child: child);
  }
}
