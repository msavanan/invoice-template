import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoice/bloc/template/template_bloc.dart';
import 'package:invoice/bloc/template/template_event.dart';
import 'package:invoice/bloc/template/template_state.dart';

class CustomDatePicker extends StatelessWidget {
  const CustomDatePicker({super.key, required this.templateKey});
  final String templateKey;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TemplateBloc, TemplateState>(builder: (context, state) {
      return InkWell(
        child: Text(state.templateType.getValue(templateKey)),
        onTap: () {
          _selectDate(context);
        },
      );
    });
  }

  dateFormatter(DateTime date) {
    return date.toString().split(" ")[0];
  }

  Future<void> _selectDate(BuildContext context) async {
    final templateBloc = context.read<TemplateBloc>();
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));

    if (picked != null) {
      templateBloc.add(SetDate(key: templateKey, value: dateFormatter(picked)));
      templateBloc.add(const Success());
    }
  }
}
