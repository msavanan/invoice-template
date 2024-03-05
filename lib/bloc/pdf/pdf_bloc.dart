import 'package:bloc/bloc.dart';
import 'package:invoice/bloc/pdf/pdf_event.dart';
import 'package:invoice/bloc/pdf/pdf_state.dart';

class PdfBloc extends Bloc<PdfEvents, PdfState> {
  PdfBloc(super.initialState);
}
