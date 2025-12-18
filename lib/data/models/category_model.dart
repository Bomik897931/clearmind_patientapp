// class CategoryModel {
//   final String id;
//   final String name;
//   final String icon;
//   final bool isSelected;
//
//   CategoryModel({
//     required this.id,
//     required this.name,
//     required this.icon,
//     this.isSelected = false,
//   });
//
//   factory CategoryModel.fromJson(Map<String, dynamic> json) {
//     return CategoryModel(
//       id: json['id'] ?? '',
//       name: json['name'] ?? '',
//       icon: json['icon'] ?? '',
//       isSelected: json['isSelected'] ?? false,
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {'id': id, 'name': name, 'icon': icon, 'isSelected': isSelected};
//   }
//
//   CategoryModel copyWith({
//     String? id,
//     String? name,
//     String? icon,
//     bool? isSelected,
//   }) {
//     return CategoryModel(
//       id: id ?? this.id,
//       name: name ?? this.name,
//       icon: icon ?? this.icon,
//       isSelected: isSelected ?? this.isSelected,
//     );
//   }
// }

// lib/models/specialization.dart
import 'package:flutter/material.dart';

class Specialization {
  final int specializationId;
  final String specializationName;

  Specialization({
    required this.specializationId,
    required this.specializationName,
  });

  factory Specialization.fromJson(Map<String, dynamic> json) {
    return Specialization(
      specializationId: json['specializationId'],
      specializationName: json['specializationName'],
    );
  }

  // Get icon based on specialization name
  IconData get icon {
    switch (specializationName.toLowerCase()) {
      case 'psychologist':
        return Icons.psychology;
      case 'psychiatrist':
        return Icons.medical_services;
      case 'therapist':
        return Icons.healing;
      default:
        return Icons.local_hospital;
    }
  }

  // Get short name for API (first 2-3 characters)
  String get shortName {
    return specializationName.substring(0, 2).toLowerCase();
  }
}
