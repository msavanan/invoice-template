import 'package:bloc/bloc.dart';
import 'package:invoice/bloc/header/header_events.dart';
import 'package:invoice/bloc/header/header_state.dart';

class HeaderBloc extends Bloc<HeaderEvents, HeaderState> {
  HeaderBloc(super.initialState);
}
