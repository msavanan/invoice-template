import 'package:equatable/equatable.dart';
import 'package:invoice/constant.dart';
import 'package:invoice/template_type.dart';

sealed class TemplateState extends Equatable {
  final TemplateType templateType;
  const TemplateState(this.templateType);
  @override
  List<Object> get props => [templateType];
}

class InitialTemplate extends TemplateState {
  const InitialTemplate(super.templateType);
}

class UpdateTemplateState extends TemplateState {
  const UpdateTemplateState(super.templateType);
}

class UpdateItemTemplateState extends TemplateState {
  final String type;
  const UpdateItemTemplateState(super.templateType,
      {this.type = Types.defaults});
}

class HoverState extends TemplateState {
  const HoverState(super.templateType);
}

class ExitState extends TemplateState {
  const ExitState(super.templateType);
}
