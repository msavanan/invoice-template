import 'package:bloc/bloc.dart';
import 'package:invoice/bloc/template/template_event.dart';
import 'package:invoice/bloc/template/template_state.dart';

class TemplateBloc extends Bloc<TemplateEvent, TemplateState> {
  TemplateBloc(super.initialState) {
    on<Read>(_readTemplate);
    on<Update>(_updateTemplate);
    on<UpdateItem>(_updateItemTemplate);
    on<Hover>(_hover);
    on<Exit>(_exit);
    on<HoverItem>(_hoverItem);
    on<ExitItem>(_exitItem);
  }

  _readTemplate(event, emit) {}

  _updateTemplate(event, emit) {
    //state.templateType.layout[event.key] = event.value;
    state.templateType
        .update(key: event.key, value: event.value, type: event.type);
    emit(UpdateItemTemplateState(state.templateType));
  }

  _updateItemTemplate(event, emit) {
    // state.templateType.layout[LayoutKeys.items][event.rowNum - 1][event.key] =
    //     event.value;
    state.templateType
        .updateItem(key: event.key, value: event.value, rowNum: event.rowNum);

    //print(state.templateType.layout);
    emit(UpdateTemplateState(state.templateType));
  }

  _hover(Hover event, emit) {
    //state.templateType.hovered.putIfAbsent(event.key, () => true);
    state.templateType.updateHovered(key: event.key, isHovered: true);
    //.update(event.key, (value) => true, ifAbsent: () => true);
    emit(HoverState(state.templateType));
  }

  _exit(event, emit) {
    state.templateType.updateHovered(key: event.key, isHovered: false);
    //.update(event.key, (value) => false, ifAbsent: () => false);
    emit(ExitState(state.templateType));
  }

  _hoverItem(HoverItem event, emit) {
    //state.templateType.hovered.putIfAbsent(event.key, () => true);
    // state.templateType.hovered["items"][event.rowNum - 1]
    //     .update(event.key, (value) => true, ifAbsent: () => true);
    state.templateType.updateHoveredItem(
        isHovered: true, key: event.key, rowNum: event.rowNum);
    emit(HoverState(state.templateType));
  }

  _exitItem(event, emit) {
    // state.templateType.hovered["items"][event.rowNum - 1]
    //     .update(event.key, (value) => false, ifAbsent: () => false);
    state.templateType.updateHoveredItem(
        isHovered: false, key: event.key, rowNum: event.rowNum);
    emit(ExitState(state.templateType));
  }
}
