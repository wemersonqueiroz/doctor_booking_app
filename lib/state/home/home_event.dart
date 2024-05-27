part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

// This is the event that will be triggered when the home screen is loaded
// This event will be used to fetch the data from the API and update the state of the home screen
class LoadHomeEvent extends HomeEvent {}
