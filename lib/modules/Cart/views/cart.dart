import 'package:flutter/material.dart';

import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';


import '../../../core/constants/app_colors.dart';
import '../controller/cart_controller.dart';
import '../widget/bill_details_card.dart';
import '../widget/delivery_address_card.dart';
import '../widget/medication_item_card.dart';

class CartScreen extends GetView<CartController> {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final cart = controller.cart.value;
        if (cart == null) return const SizedBox();

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Delivery Address
              DeliveryAddressCard(patient: cart.patient),

              const SizedBox(height: 16),

              /// Medicines
              ...cart.orderItems.map(
                    (item) => MedicationItemCard(item: item),
              ),

              const SizedBox(height: 16),

              /// Bill Details
              BillDetailsCard(
                totalAmount: cart.totalAmount,
              ),

              const SizedBox(height: 20),

              /// Proceed Button
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    'Proceed to Checkout  ₹${cart.totalAmount.toStringAsFixed(0)}',
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
