// lib/models/appointment.dart
class Appointment {
  final int appointmentId;
  final String doctorName;
  final String patientName;
  final String gender;
  final String appointmentDate;
  final String time;
  final String status;
  final String city;
  final String diagnosis;
  final String? previousAppointment;
  final String reason;
  final String notes;
  final int? slotsId;
  final int? userId;
  final int? doctorUserId;
  final int? patientUserId;
  final String? phoneNumber;

  Appointment({
    required this.appointmentId,
    required this.doctorName,
    required this.patientName,
    required this.gender,
    required this.appointmentDate,
    required this.time,
    required this.status,
    required this.city,
    required this.diagnosis,
    this.previousAppointment,
    required this.reason,
    required this.notes,
    this.slotsId,
    this.userId,
    this.doctorUserId,
    this.patientUserId,
    this.phoneNumber,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      appointmentId: json['appointmentId'],
      doctorName: json['doctorName'],
      patientName: json['patientName'],
      gender: json['gender'],
      appointmentDate: json['appointmentDate'],
      time: json['time'],
      status: json['status'],
      city: json['city'],
      diagnosis: json['diagnosis'],
      previousAppointment: json['previousAppointment'],
      reason: json['reason'],
      notes: json['notes'],
      slotsId: json['slotsId'],
      userId: json['userId'],
      doctorUserId: json['doctorUserId'],
      patientUserId: json['patientUserId'],
      phoneNumber: json['phoneNumber'],
    );
  }
}