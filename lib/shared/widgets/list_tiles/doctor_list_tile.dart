import 'package:doctor_booking_app/screens/doctor_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:models/models.dart';

class DoctorListTile extends StatelessWidget {
  const DoctorListTile({
    super.key,
    required this.doctor,
  });

  final Doctor doctor;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DoctorDetailsScreen(doctorId: doctor.id),
            ),
          );
        },
        contentPadding: EdgeInsets.zero,
        leading: CircleAvatar(
          radius: 30.0,
          backgroundColor: colorScheme.background,
          backgroundImage: NetworkImage(doctor.profileImageUrl),
        ),
        title: Text(
          doctor.name,
          style: textTheme.bodyLarge!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 8,
            ),
            Text(
              doctor.category.name,
              style:
                  textTheme.bodyMedium!.copyWith(color: colorScheme.secondary),
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Icon(Icons.star, color: Colors.orange[200], size: 16),
                const SizedBox(
                  width: 4,
                ),
                Text(
                  doctor.rating.toString(),
                  style: textTheme.bodySmall!.copyWith(
                      color: colorScheme.onBackground.withOpacity(0.5),
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  width: 16,
                ),
                Icon(
                  Icons.work,
                  color: colorScheme.tertiary,
                  size: 16,
                ),
                const SizedBox(
                  width: 4,
                ),
                Text(
                  '3 years',
                  style: textTheme.bodySmall!.copyWith(
                      color: colorScheme.onBackground.withOpacity(0.5),
                      fontWeight: FontWeight.bold),
                ),
              ],
            )
          ],
        ),
        trailing: FilledButton(
            onPressed: () {},
            child: Text(
              'Book now',
              style: textTheme.bodySmall!.copyWith(
                color: colorScheme.background,
              ),
            )));
  }
}
