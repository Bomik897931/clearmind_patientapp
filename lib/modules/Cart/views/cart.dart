import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_colors.dart';
import '../controller/cart_controller.dart';
import '../widget/bill_details_card.dart';
import '../widget/delivery_address_card.dart';
import '../widget/medication_item_card.dart';

class CartScreen extends GetView<CartController> {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {

    /// 🔥 VERY IMPORTANT
    /// This ensures Cart refreshes:
    /// - when coming from bottom navigation
    /// - when navigating with prescriptionId
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.handleEntry(args: Get.arguments);
    });

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: const Text('Cart'),
        centerTitle: true,
      ),
      body: Obx(() {
        print('🟢 UI rebuild | loading=${controller.isLoading.value}'
            ' | noRecord=${controller.noRecordFound.value}'
            ' | cart=${controller.cart.value}');

        // 🔄 LOADING STATE
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        // 🚫 NO RECORD FOUND
        if (controller.noRecordFound.value) {
          return const Center(
            child: Text(
              'No record found',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          );
        }

        final cart = controller.cart.value;

        // 🟡 SAFETY EMPTY STATE
        if (cart == null) {
          return const Center(
            child: Text(
              'No cart data available',
              style: TextStyle(fontSize: 14),
            ),
          );
        }

        // ✅ CART UI
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// 📦 DELIVERY ADDRESS
              DeliveryAddressCard(
                patient: cart.patient,
              ),

              const SizedBox(height: 16),

              /// 💊 MEDICATION LIST
              if (cart.orderItems.isNotEmpty)
                ...cart.orderItems.map(
                      (item) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: MedicationItemCard(item: item),
                  ),
                )
              else
                const Center(
                  child: Text(
                    'No medicines added',
                    style: TextStyle(fontSize: 14),
                  ),
                ),

              const SizedBox(height: 16),

              /// 💰 BILL DETAILS
              BillDetailsCard(
                totalAmount: cart.totalAmount,
              ),

              const SizedBox(height: 24),

              /// 🟢 PROCEED BUTTON
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
                  onPressed: () {
                    // TODO: Checkout flow
                    print('🟢 Proceed to checkout clicked');
                  },
                  child: Text(
                    'Proceed to Checkout  ₹${cart.totalAmount.toStringAsFixed(0)}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
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
