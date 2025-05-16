import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:health_cure/features/home/services/therapies_service.dart';
part 'therapy_event.dart';
part 'therapy_state.dart';

class TherapyBloc extends Bloc<TherapyEvent, TherapyState> {
  final TherapiesService _therapiesService = TherapiesService();
  TherapyBloc() : super(TherapyInitial()) {
    on<GetTherapiesEvent>((event, emit) async { 
      emit(TherapyLoading());
      try {
        final normalTherapies = await _therapiesService.getTherapies();
        final fastingTherapies = await _therapiesService.getFastingTherapies();
        emit(TherapyLoaded(therapies: normalTherapies,fastingTherapies: fastingTherapies));
      } catch (e) {
        emit(TherapyError(message: e.toString()));
      }
    });
    
    on<GetFastingTherapiesEvent>((event, emit) async {
      emit(TherapyLoading());
      try {
        final fastingTherapies = await _therapiesService.getFastingTherapies();
        emit(TherapyLoaded(therapies: [],fastingTherapies: fastingTherapies));
      } catch (e) {
        emit(TherapyError(message: e.toString()));
      }
    }); 
  }
}
