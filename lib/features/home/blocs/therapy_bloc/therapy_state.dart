part of 'therapy_bloc.dart';

 class TherapyState extends Equatable {
  const TherapyState();
  
  @override
  List<Object> get props => [];
}

 class TherapyInitial extends TherapyState {}

class TherapyLoaded extends TherapyState {
  final List<Map<String, dynamic>> therapies;
  final List<Map<String, dynamic>> fastingTherapies;
  const TherapyLoaded({required this.therapies,required this.fastingTherapies});

  @override
  List<Object> get props => [therapies,fastingTherapies];
}

class TherapyLoading extends TherapyState {}

class TherapyError extends TherapyState {
  final String message;
  const TherapyError({required this.message});
}