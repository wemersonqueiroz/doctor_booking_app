import 'package:doctor_booking_app/repositories/doctor_repository.dart';
import 'package:doctor_booking_app/screens/home_screen.dart';
import 'package:doctor_booking_app/shared/theme/app_theme.dart';
import 'package:doctor_booking_app/state/home/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  const doctorRepository = DoctorRepository();
  runApp(AppScreen(doctorRepository: doctorRepository));
}

class AppScreen extends StatelessWidget {
  AppScreen({
    super.key,
    required this.doctorRepository,
  });

  final DoctorRepository doctorRepository;

  @override
  Widget build(BuildContext context) {
    // MultiRepositoryProvider is a provider that allows multiple repositories to be provided to the widget tree.
    return MultiRepositoryProvider(
      providers: [
        // RepositoryProvider is a provider that allows a repository to be provided to the widget tree.
        RepositoryProvider.value(value: doctorRepository),
      ],
      // MultiBlocProvider is a provider that allows multiple blocs to be provided to the widget tree.
      child: MultiBlocProvider(
        providers: [
          // BlocProvider is a provider that allows a bloc to be provided to the widget tree.
          BlocProvider(
            // The bloc instance to provide.
            create: (context) => HomeBloc(doctorRepository: doctorRepository)
              // The event to trigger when the bloc is created.
              ..add(LoadHomeEvent()),
          ),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: const AppTheme().themeData,
          home: const HomeScreen(),
        ),
      ),
    );
  }
}
