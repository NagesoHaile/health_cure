part of 'treatment_bloc.dart';

sealed class TreatmentState extends Equatable {
  const TreatmentState();
  
  @override
  List<Object> get props => [];
}

 class TreatmentInitial extends TreatmentState {}

 class TreatmentLoading extends TreatmentState {}

 class TreatmentLoaded extends TreatmentState {
  final List<Map<String, dynamic>> treatments;
  const TreatmentLoaded({required this.treatments});

  @override
  List<Object> get props => [treatments,];
 }

 class TreatmentError extends TreatmentState {
  final String message;

  const TreatmentError({required this.message});
 }
