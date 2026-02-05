import 'package:flutter/material.dart';

import '../../../data/models/cart_response_model.dart';

class MedicationItemCard extends StatelessWidget {
  final OrderItem item;

  const MedicationItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  '${ item.drugName} • ${item.strength} ',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Spacer(),
                Text(
                  '₹${item.unitPrice}',
                  style: const TextStyle(
                    decoration: TextDecoration.lineThrough,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  '₹${item.discount}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Strips of ${item.unitPrice} for ${item.numberOfDay}'),
                Text('Qty ${item.quantity}'),
                // Column(
                //   crossAxisAlignment: CrossAxisAlignment.end,
                //   children: [
                //     Text(
                //       '₹${item.unitPrice}',
                //       style: const TextStyle(
                //         decoration: TextDecoration.lineThrough,
                //         color: Colors.grey,
                //       ),
                //     ),
                //     Text(
                //       '₹${item.totalPrice}',
                //       style: const TextStyle(
                //         fontWeight: FontWeight.bold,
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
