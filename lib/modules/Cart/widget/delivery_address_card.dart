import 'package:flutter/material.dart';

import '../../../data/models/cart_response_model.dart';

class DeliveryAddressCard extends StatelessWidget {
  final Patient patient;

  const DeliveryAddressCard({super.key, required this.patient});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: const Icon(Icons.location_on),
        title: Text(
          patient.fullName!,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          '${patient.phoneNumber}\n${patient.address}',
        ),
        isThreeLine: true,
      ),
    );
  }
}
