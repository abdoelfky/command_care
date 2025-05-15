import 'package:command_care/core/constants/app_images.dart';
import 'package:command_care/features/admin/admin_appointments/data/appointment_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'appointment_model.dart';

final appointmentProvider = Provider<List<Appointment>>((ref) {
  return [
    Appointment(
      id: '#781',
      doctorName: 'DrRafael Boucinha',
      specialization: 'Criolipólise',
      date: '25-12-2024',
      time: '10:00 AM - 10:30 AM',
      status: 'Pending',
      image: AppImages.bannerImg1,
    ),
    Appointment(
      id: '#784',
      doctorName: 'DrAmanda Ramirez',
      specialization: 'Cornea Transplant',
      date: '21-12-2024',
      time: '08:00 AM - 08:45 AM',
      status: 'Pending',
      image: AppImages.bannerImg2,
    ),
    Appointment(
      id: '#782',
      doctorName: 'DrChristiana Johnson',
      specialization: 'Bucal',
      date: '18-12-2024',
      time: '02:10 PM - 02:45 PM',
      status: 'Pending',
      image: AppImages.bannerImg3,
    ),
  ];
});
