import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_colors.dart';
import '../controller/review_confirm_controller.dart';

class ReviewConfirmScreen extends GetView<ReviewConfirmController> {
  const ReviewConfirmScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey50,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.black),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Review & Confirm',
          style: TextStyle(
            color: AppColors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDoctorCard(),
                  const SizedBox(height: 10),
                  _buildAppointmentDetails(),
                  const SizedBox(height: 24),
                  _buildSelectedId(),
                  const SizedBox(height: 24),
                  _buildBillDetails(),
                  // const SizedBox(height: 100),
                ],
              ),
            ),
          ),
          _buildBottomBar(),
        ],
      ),
    );
  }

  Widget _buildDoctorCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: NetworkImage('https://images.pexels.com/photos/8460157/pexels-photo-8460157.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  /*controller.doctor.fullName*/"Amir",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                 /* controller.doctor.specialty*/"Therapist",
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.grey600,
                  ),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () => Get.back(),
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: const Size(0, 0),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: const Text(
              'View Detail',
              style: TextStyle(
                color: AppColors.circularprogressindicator,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppointmentDetails() {
    return Container(
      padding: const EdgeInsets.all(16),
      // decoration: BoxDecoration(
      //   color: AppColors.white,
      //   borderRadius: BorderRadius.circular(16),
      // ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Appointment Details',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          _buildDetailRow(
            Icons.calendar_today_outlined,
            'Date',
            controller.getFormattedDate(),
          ),
          const SizedBox(height: 12),
          _buildDetailRow(
            Icons.access_time,
            'Consultation Duration',
            '${controller.selectedTime}',
          ),
          const SizedBox(height: 12),
          _buildDetailRow(
            Icons.schedule_outlined,
            'Slot',
            '${controller.consultationDuration}',
          ),
          const SizedBox(height: 12),
          _buildDetailRow(
            Icons.account_balance_wallet_outlined,
            'Charges',
            '₹ ${controller.consultationFee.value}',
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Container(
      padding: const EdgeInsets.only(left: 8,right: 8,top: 4,bottom: 4),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 18,
            color: AppColors.grey600,
          ),
          const SizedBox(width: 8),
          Text(
            '$label : ',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.grey600,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectedId() {
    return Container(
      padding: const EdgeInsets.only(left: 16,right: 16),
      // decoration: BoxDecoration(
      //   color: AppColors.white,
      //   borderRadius: BorderRadius.circular(16),
      // ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Selected Id',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.grey50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.grey300),
            ),
            child: Row(
              children: [
                Text(
                  '${controller.selectedIdProof} : ',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.grey600,
                  ),
                ),
                const Text(
                  'XXXXXXXXX',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildBillDetails() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔹 Title
          const Text(
            'Bill Details',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.black87,
            ),
          ),

          const SizedBox(height: 12),

          // 🔹 Price Details Card
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.grey50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Price Details',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: AppColors.grey600,
                  ),
                ),
                const SizedBox(height: 8),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Consultation Fees',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.black87,
                      ),
                    ),
                    Obx(() => Text(
                      '₹ ${controller.consultationFee.value}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.black87,
                      ),
                    )),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // 🔹 Total Amount Highlight
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFF3F9EE), // light green
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: const Color(0xFFB7E0A2), // green border
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.account_balance_wallet_outlined,
                  size: 18,
                  color: AppColors.grey600,
                ),
                const SizedBox(width: 8),
                const Text(
                  'Total Amount',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black87,
                  ),
                ),
                const Spacer(),
                Obx(() => Text(
                  '₹ ${controller.consultationFee.value}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.black87,
                  ),
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(11),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: 40,
          child: ElevatedButton(
            onPressed: controller.proceedToPay,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.circularprogressindicator,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              elevation: 0,
            ),
            child: const Text(
              'Proceed To Pay',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
