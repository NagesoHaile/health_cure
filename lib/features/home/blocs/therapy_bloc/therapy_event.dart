part of 'therapy_bloc.dart';

 class TherapyEvent extends Equatable {
  const TherapyEvent();

  @override
  List<Object> get props => [];
}

class GetTherapiesEvent extends TherapyEvent {}

class GetFastingTherapiesEvent extends TherapyEvent {}