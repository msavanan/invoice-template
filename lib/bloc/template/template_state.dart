import 'package:equatable/equatable.dart';
import 'package:invoice/constant.dart';
import 'package:invoice/template_type.dart';

sealed class TemplateState extends Equatable {
  final TemplateType templateType;
  const TemplateState(this.templateType);
}

class InitialTemplate extends TemplateState {
  const InitialTemplate(super.templateType);

  @override
  List<Object> get props => [templateType];
}

class UpdateTemplateState extends TemplateState {
  const UpdateTemplateState(super.templateType);

  @override
  List<Object> get props => [templateType];
}

class UpdateItemTemplateState extends TemplateState {
  final String type;
  const UpdateItemTemplateState(super.templateType,
      {this.type = Types.defaults});

  @override
  List<Object> get props => [templateType, type];
}

class HoverState extends TemplateState {
  const HoverState(super.templateType);

  @override
  List<Object> get props => [templateType];
}

class ExitState extends TemplateState {
  const ExitState(super.templateType);

  @override
  List<Object> get props => [templateType];
}

class AddRowState extends TemplateState {
  const AddRowState(super.templateType);

  @override
  List<Object> get props => [templateType];
}

class SuccessState extends TemplateState {
  const SuccessState(super.templateType);

  @override
  List<Object> get props => [templateType];
}

class LoadingState extends TemplateState {
  const LoadingState(super.templateType);

  @override
  List<Object> get props => [templateType];
}

class DeleteRowState extends TemplateState {
  const DeleteRowState(super.templateType);

  @override
  List<Object> get props => [templateType];
}

class SetDateState extends TemplateState {
  const SetDateState(super.templateType);

  @override
  List<Object> get props => [templateType];
}

class UpdateCurrencyState extends TemplateState {
  const UpdateCurrencyState(super.templateType);

  @override
  List<Object> get props => [templateType];
}
