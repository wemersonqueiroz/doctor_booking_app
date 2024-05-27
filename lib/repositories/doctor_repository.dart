//this is the class that allow us to fetch the data

import 'package:models/models.dart';

//All methods are type Future, because we are fetching data from the API, and this is an async operation.

class DoctorRepository {
  //This is the class that allow us to fetch the data
  const DoctorRepository(
      //TODO: inject the required dependencies
      //e.g class to connect with the API
      );

//This is the method that will be used to fetch the doctor categories from the API
  Future<List<DoctorCategory>> fetchDoctorCategories() async {
    //This is a mock implementation, simulating a delay of 2 seconds.
    await Future.delayed(const Duration(milliseconds: 1000));
    return DoctorCategory.values;
  }

  //This is the method that will be used to fetch the doctors from the API
  Future<List<Doctor>> fetchDoctors() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    return Doctor.sampleDoctors;
  }

  //This is the method that will be used to fetch the doctors by category from the API
  Future<List<Doctor>> fetchDoctorsByCategory(String categoryId) async {
    throw UnimplementedError();
  }

  //This is the method that will be used to fetch the doctor by id from the API
  Future<Doctor?> fetchDoctorById(String doctorId) async {
    await Future.delayed(const Duration(milliseconds: 1000));
    return Doctor.sampleDoctors.firstWhere((doctor) => doctor.id == doctorId);
  }
}
