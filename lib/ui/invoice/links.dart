import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoice/bloc/template/template_bloc.dart';
import 'package:invoice/bloc/template/template_event.dart';

class Links extends StatelessWidget {
  const Links({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        AddRowBtn(),
        SizedBox(width: 30),
        Link(txt: "Configure Column"),
      ],
    );
  }
}

class Link extends StatelessWidget {
  const Link({super.key, required this.txt});
  final String txt;

  @override
  Widget build(BuildContext context) {
    return Text(txt,
        style: const TextStyle(decoration: TextDecoration.underline));
  }
}

class AddRowBtn extends StatelessWidget {
  const AddRowBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () {
            context.read<TemplateBloc>().add(const Loading());
            context.read<TemplateBloc>().add(const AddRow());
            context.read<TemplateBloc>().add(const Success());
          },
          child: const Row(children: [
            Icon(Icons.add_circle_outline_outlined),
            Link(txt: "Add row")
          ]),
        ));
  }
}
