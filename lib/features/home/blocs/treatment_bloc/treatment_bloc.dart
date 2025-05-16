import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:health_cure/features/home/services/treatment_service.dart';

part 'treatment_event.dart';
part 'treatment_state.dart';

class TreatmentBloc extends Bloc<TreatmentEvent, TreatmentState> {
  final TreatmentService _treatmentService = TreatmentService();
  TreatmentBloc() : super(TreatmentInitial()) {
    on<GetTreatmentsEvent>((event, emit) async {
      emit(TreatmentLoading());
      final treatments = await _treatmentService.getTreatments();
      emit(TreatmentLoaded(treatments: treatments));
    });
  }
}
