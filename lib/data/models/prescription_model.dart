// Prescription List Response Model
class PrescriptionListResponse {
  final List<PrescriptionModel> items;
  final int totalCount;
  final int pageNumber;
  final int pageSize;
  final int totalPages;
  final bool hasPrevious;
  final bool hasNext;

  PrescriptionListResponse({
    required this.items,
    required this.totalCount,
    required this.pageNumber,
    required this.pageSize,
    required this.totalPages,
    required this.hasPrevious,
    required this.hasNext,
  });

  factory PrescriptionListResponse.fromJson(Map<String, dynamic> json) {
    return PrescriptionListResponse(
      items: (json['items'] as List)
          .map((item) => PrescriptionModel.fromJson(item))
          .toList(),
      totalCount: json['totalCount'] as int,
      pageNumber: json['pageNumber'] as int,
      pageSize: json['pageSize'] as int,
      totalPages: json['totalPages'] as int,
      hasPrevious: json['hasPrevious'] as bool,
      hasNext: json['hasNext'] as bool,
    );
  }
}

// Prescription Model
class PrescriptionModel {
  final int prescriptionId;
  final int doctorId;
  final String doctorName;
  final DateTime prescribedOn;
  final List<PrescriptionItemModel> items;

  PrescriptionModel({
    required this.prescriptionId,
    required this.doctorId,
    required this.doctorName,
    required this.prescribedOn,
    required this.items,
  });

  factory PrescriptionModel.fromJson(Map<String, dynamic> json) {
    return PrescriptionModel(
      prescriptionId: json['prescriptionId'] as int,
      doctorId: json['doctorId'] as int,
      doctorName: json['doctorName'] as String,
      prescribedOn: DateTime.parse(json['prescribedOn'] as String),
      items: (json['items'] as List)
          .map((item) => PrescriptionItemModel.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'prescriptionId': prescriptionId,
      'doctorId': doctorId,
      'doctorName': doctorName,
      'prescribedOn': prescribedOn.toIso8601String(),
      'items': items.map((item) => item.toJson()).toList(),
    };
  }
}

// Prescription Item Model
class PrescriptionItemModel {
  final int prescriptionItemId;
  final int drugId;
  final String drugName;
  final String dosage;
  final String frequency;
  final String duration;
  final String timeOfDay;
  final String instructions;
  final String notes;
  final int? strengthId;
  final String? brand;
  final int categoryId;
  final String? category;
  final String? strength;
  final bool isActive;
  final dynamic companys;
  final dynamic selectedDrugId;

  PrescriptionItemModel({
    required this.prescriptionItemId,
    required this.drugId,
    required this.drugName,
    required this.dosage,
    required this.frequency,
    required this.duration,
    required this.timeOfDay,
    required this.instructions,
    required this.notes,
    this.strengthId,
    this.brand,
    required this.categoryId,
    this.category,
    this.strength,
    required this.isActive,
    this.companys,
    this.selectedDrugId,
  });

  factory PrescriptionItemModel.fromJson(Map<String, dynamic> json) {
    return PrescriptionItemModel(
      prescriptionItemId: json['prescriptionItemId'] as int,
      drugId: json['drugId'] as int,
      drugName: json['drugName'] as String,
      dosage: json['dosage'] as String,
      frequency: json['frequency'] as String,
      duration: json['duration'] as String,
      timeOfDay: json['timeOfDay'] as String,
      instructions: json['instructions'] as String,
      notes: json['notes'] as String,
      strengthId: json['strengthId'] as int?,
      brand: json['brand'] as String?,
      categoryId: json['categoryId'] as int? ?? 0,
      category: json['category'] as String?,
      strength: json['strength'] as String?,
      isActive: json['isActive'] as bool? ?? false,
      companys: json['companys'],
      selectedDrugId: json['selectedDrugId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'prescriptionItemId': prescriptionItemId,
      'drugId': drugId,
      'drugName': drugName,
      'dosage': dosage,
      'frequency': frequency,
      'duration': duration,
      'timeOfDay': timeOfDay,
      'instructions': instructions,
      'notes': notes,
      'strengthId': strengthId,
      'brand': brand,
      'categoryId': categoryId,
      'category': category,
      'strength': strength,
      'isActive': isActive,
      'companys': companys,
      'selectedDrugId': selectedDrugId,
    };
  }
}