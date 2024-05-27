part of 'home_bloc.dart';

enum HomeStatus { initial, loading, loaded, error }

class HomeState extends Equatable {
  //this is an enum to tell the status of the home screen
  final HomeStatus status;
  final List<DoctorCategory> doctorCategories;
  final List<Doctor> nearbyDoctors;
  final List myAppointments;
  const HomeState({
    this.status = HomeStatus.initial,
    this.doctorCategories = const <DoctorCategory>[],
    this.nearbyDoctors = const <Doctor>[],
    this.myAppointments = const [],
  });

//the copyWith is a method that is used to get the initial instance of the HomeState and update the values of the properties that we want to update, this is used to avoid the mutation of the object, since the object is immutable

  HomeState copyWith({
    HomeStatus? status,
    List<DoctorCategory>? doctorCategories,
    List<Doctor>? nearbyDoctors,
    List? myAppointments,
  }) {
    return HomeState(
      status: status ?? this.status,
      doctorCategories: doctorCategories ?? this.doctorCategories,
      nearbyDoctors: nearbyDoctors ?? this.nearbyDoctors,
      myAppointments: myAppointments ?? this.myAppointments,
    );
  }

// we will use equatable to compare the objects of the HomeState, this is used to compare the objects and see if they are the same, this is used to avoid unnecessary rebuilds of the widgets.
  @override
  List<Object> get props => [
        status,
        doctorCategories,
        nearbyDoctors,
        myAppointments,
      ];
}
