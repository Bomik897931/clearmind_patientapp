import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_style.dart';
import '../controller/editaddress_controller.dart';

class EditAddressView extends GetView<EditAddressController> {
  const EditAddressView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text(
          'Edit Address',
          style: TextStyle(
            fontFamily: 'EBGaramond',
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: false,
        leading: const BackButton(),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _label('Name'),
            _field(controller.nameController, 'Aman Khan'),

            _label('Phone Number'),
            _phoneField(),

            _label('Pincode'),
            _field(controller.zipCodeController, '202001', suffix: Icons.check),

            _label('City'),
            _field(controller.cityController, 'Aligarh', suffix: Icons.check),

            _label('State'),
            _field(
              controller.stateController,
              'Uttar Pradesh',
              suffix: Icons.check,
            ),

            _label('House No. / Building Name'),
            _field(controller.streetController, 'House Number 45'),

            _label('Road Name / Area / Colony'),
            _field(controller.cityController, '455 Chandi Chowk'),

            const SizedBox(height: 24),

            Obx(
              () => SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: controller.isLoading.value
                      ? null
                      : controller.saveAddress,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFB36A2E),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  child: controller.isLoading.value
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('Save Address'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 🔹 Label Widget (Figma Heading 5)
  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(text, style: AppTextStyles.heading5),
    );
  }

  /// 🔹 Normal Input Field
  Widget _field(
    TextEditingController controller,
    String hint, {
    IconData? suffix,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: SizedBox(
        height: 40,
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            fillColor: AppColors.white,
            hintText: hint,
            hintStyle: AppTextStyles.bodySmallGrey,
            suffixIcon: suffix != null
                ? Icon(suffix, color: Colors.green)
                : null,
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 13,
            ),
          ),
        ),
      ),
    );
  }

  /// 🔹 Phone Input with Country Code
  Widget _phoneField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            height: 40,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text('+91', style: AppTextStyles.bodySmallGrey),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: SizedBox(
              height: 40,
              child: TextField(
                controller: controller.phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  fillColor: AppColors.white,
                  hintText: '672836521',
                  hintStyle: AppTextStyles.bodySmallGrey,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
