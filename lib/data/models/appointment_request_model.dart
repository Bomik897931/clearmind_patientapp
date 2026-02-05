class BookAppointmentRequest {
  int? doctorUserId;
  int? patientUserId;
  List<int>? slotIds;
  int? slotsDuration;
  String? reason;
  String? notes;
  PatientProfile? patientProfile;

  BookAppointmentRequest({
    this.doctorUserId,
    this.patientUserId,
    this.slotIds,
    this.slotsDuration,
    this.reason,
    this.notes,
    this.patientProfile,
  });

  Map<String, dynamic> toJson() => {
    "doctorUserId": doctorUserId,
    "patientUserId": patientUserId,
    "slotIds": slotIds,
    "slotsDuration": slotsDuration,
    "reason": reason,
    "notes": notes,
    "patientProfile": patientProfile?.toJson(),
  };
}


class PatientProfile {
  String? firstName;
  String? lastName;
  String? dob;
  String? gender;
  List<IdentityDoc>? identityDocs;

  PatientProfile({
    this.firstName,
    this.lastName,
    this.dob,
    this.gender,
    this.identityDocs,
  });

  Map<String, dynamic> toJson() => {
    "firstName": firstName,
    "lastName": lastName,
    "dob": dob,
    "gender": gender,
    "identityDocs": identityDocs?.map((e) => e.toJson()).toList(),
  };
}


class IdentityDoc {
  int? documentType;
  String? documentNumber;
  bool? isVerified;

  IdentityDoc({
    this.documentType,
    this.documentNumber,
    this.isVerified,
  });

  Map<String, dynamic> toJson() => {
    "documentType": documentType,
    "documentNumber": documentNumber,
    "isVerified": isVerified,
  };
}
