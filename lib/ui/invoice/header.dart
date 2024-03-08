import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:invoice/bloc/template/template_bloc.dart';
import 'package:invoice/bloc/template/template_event.dart';
import 'package:invoice/bloc/template/template_state.dart';
import 'package:invoice/constant.dart';
import 'package:invoice/ui/editable_text.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    final String img = context
        .watch<TemplateBloc>()
        .state
        .templateType
        .getValue(LayoutKeys.companyLogo);
    return Row(
      children: [
        MouseRegion(
          onHover: (PointerHoverEvent pointerHoverEvent) {
            context
                .read<TemplateBloc>()
                .add(const Hover(key: LayoutKeys.companyLogo));
          },
          onExit: (PointerExitEvent event) {
            context
                .read<TemplateBloc>()
                .add(const Exit(key: LayoutKeys.companyLogo));
          },
          child: Stack(children: [
            img.isNotEmpty
                ? Image(
                    image: Image.file(File(img)).image,
                    width: 100,
                    height: 100,
                    fit: BoxFit.fill,
                  )
                : InkWell(
                    onTap: () async {
                      final picker = ImagePicker();
                      final templateBloc = context.read<TemplateBloc>();
                      try {
                        final XFile? image =
                            await picker.pickImage(source: ImageSource.gallery);
                        templateBloc.add(Update(
                            key: LayoutKeys.companyLogo,
                            value: image?.path ?? ''));
                      } catch (e) {
                        print(e);
                      }
                    },
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                          border: Border.all(style: BorderStyle.solid)),
                      child: const Icon(Icons.add_circle_outline_outlined),
                    ),
                  ),
            BlocBuilder<TemplateBloc, TemplateState>(
              builder: (context, state) {
                return state.templateType
                            .getHoveredValue(key: LayoutKeys.companyLogo) &&
                        img.isNotEmpty
                    ? Container(
                        width: 100,
                        height: 100,
                        decoration: const BoxDecoration(
                          color: Colors.white24,
                          // gradient: LinearGradient(
                          //     begin: Alignment.topLeft,
                          //     end: Alignment.bottomRight,
                          //     stops: [0.3, 0.5],
                          //     colors: [Colors.white, Colors.white]),
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Container(
                            color: Colors.transparent,
                            child: IconButton(
                              icon: const Icon(
                                Icons.delete_forever_sharp,
                                color: Colors.red,
                                size: 45.0,
                              ),
                              onPressed: () {
                                context.read<TemplateBloc>().add(const Update(
                                    key: LayoutKeys.companyLogo, value: ""));
                              },
                            ),
                          ),
                        ),
                      )
                    : const SizedBox.shrink();
              },
            )
          ]),
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
