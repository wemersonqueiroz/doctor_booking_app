import 'package:doctor_booking_app/shared/widgets/avatars/circle_avatar_with_text_label.dart';
import 'package:doctor_booking_app/shared/widgets/bottom_nav_bar/main_nav_bar.dart';
import 'package:doctor_booking_app/shared/widgets/cards/appointment_preview_card.dart';
import 'package:doctor_booking_app/shared/widgets/list_tiles/doctor_list_tile.dart';
import 'package:doctor_booking_app/shared/widgets/titles/section_title.dart';
import 'package:doctor_booking_app/state/home/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:models/models.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomeView();
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome',
              style: textTheme.bodyMedium,
            ),
            const SizedBox(height: 4),
            Text(
              'Wemerson Q',
              style: textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: colorScheme.secondary,
                ),
                const SizedBox(width: 4),
                Text(
                  'Basingstoke UK',
                  style: textTheme.bodySmall,
                ),
                const SizedBox(width: 4),
                Icon(
                  Icons.expand_more,
                  color: colorScheme.secondary,
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_outlined),
          ),
          const SizedBox(width: 8),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(64),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: TextFormField(
              decoration: InputDecoration(
                hintText: 'Search for doctors...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: Container(
                  margin: const EdgeInsets.all(4),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: colorScheme.onSurfaceVariant,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.filter_alt_outlined,
                    color: colorScheme.surfaceVariant,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      //BlocBuilder is a Flutter widget that requires a Bloc and a builder function.
      //HomeBloc is the Bloc that we are using to manage the state of the HomeScreen
      //HomeState is the state of the HomeBloc
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state.status == HomeStatus.loading ||
              state.status == HomeStatus.initial) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state.status == HomeStatus.loaded) {
            return const SingleChildScrollView(
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  _DoctorCategories(),
                  SizedBox(height: 24),
                  _MyScheduledAppointments(),
                  SizedBox(height: 16),
                  _NearbyDoctors(),
                ],
              ),
            );
          } else {
            return const Center(
              child: Text('Failed to load data'),
            );
          }
          //SingleChildScrollView is used to avoid overflow when the keyboard is open and the user scrolls the screen up or down
        },
      ),
      bottomNavigationBar: const MainNavBar(),
    );
  }
}

class _NearbyDoctors extends StatelessWidget {
  const _NearbyDoctors({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Column(
          children: [
            SectionTitle(
              title: "Nerby Doctors",
              action: "See all",
              onPressed: () {},
            ),
            const SizedBox(
              height: 8,
            ),
            ListView.separated(
              //NeverScrollableScrollPhysics is used to avoid scrolling inside a ListView, for UX best practice
              //we should not nest a scrollable widget inside another scrollable widget
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              separatorBuilder: (context, index) {
                return Divider(
                  height: 24,
                  color: colorScheme.surfaceVariant,
                );
              },
              itemCount: state.nearbyDoctors.length,
              itemBuilder: (context, index) {
                final doctor = state.nearbyDoctors[index];
                return DoctorListTile(
                  doctor: doctor,
                );
              },
            ),
          ],
        );
      },
    );
  }
}

class _MyScheduledAppointments extends StatelessWidget {
  const _MyScheduledAppointments({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Column(
          children: [
            SectionTitle(
              title: "My Schedule",
              action: "See all",
              onPressed: () {},
            ),
            AppointmentPreviewCard(
                appointment: state.myAppointments.firstOrNull),
          ],
        );
      },
    );
  }
}

class _DoctorCategories extends StatelessWidget {
  const _DoctorCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionTitle(
              title: "Categories",
              action: "See all",
              onPressed: () {},
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: state.doctorCategories
                  .take(5)
                  .map(
                    (category) => Expanded(
                      child: CircleAvatarWithTextLabel(
                          icon: category.icon, label: category.name),
                    ),
                  )
                  .toList(),
            )
          ],
        );
      },
    );
  }
}
