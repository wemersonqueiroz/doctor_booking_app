import 'package:bloc/bloc.dart';
import 'package:doctor_booking_app/repositories/doctor_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:models/models.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  //What happen everytime an event is triggered, how we fetch the data, modify the bloc and emit the new state.
  final DoctorRepository _doctorRepository;
  HomeBloc({
    required DoctorRepository doctorRepository,
  })  : _doctorRepository = doctorRepository,
        super(const HomeState()) {
    on<LoadHomeEvent>(_onLoadHome);
  }

  /// Handles the event to load the home screen data.
  ///
  /// This method is responsible for fetching doctor categories and nearby doctors
  /// from the doctor repository and updating the state with the fetched data.
  /// It emits a [HomeState] with the loading status before making the API calls,
  /// and then updates the state with the loaded data if the API calls are successful.
  /// If an error occurs during the API calls, it emits a [HomeState] with the error status.
  ///
  /// Parameters:
  /// - [event]: The [LoadHomeEvent] that triggered the method call.
  /// - [emit]: The [Emitter] used to emit the updated [HomeState].
  ///
  /// Returns: A [Future] that completes when the method execution is finished.

  Future<void> _onLoadHome(
    LoadHomeEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(
      state.copyWith(status: HomeStatus.loading),
    );
    try {
      // Fetch doctor categories and nearby doctors
      final categoriesFuture = _doctorRepository.fetchDoctorCategories();
      final doctorsFuture = _doctorRepository.fetchDoctors();
      // Wait for both futures to complete
      final response = await Future.wait(
        [categoriesFuture, doctorsFuture],
      );
      // Extract the categories and doctors from the response
      // and update the state with the fetched data

      final categories = response[0] as List<DoctorCategory>;
      final doctors = response[1] as List<Doctor>;
      // Update the state with the fetched data and the loaded status
      emit(state.copyWith(
        status: HomeStatus.loaded,
        doctorCategories: categories,
        nearbyDoctors: doctors,
      ));
    } catch (e) {
      emit(state.copyWith(status: HomeStatus.error));
    }
  }
}
