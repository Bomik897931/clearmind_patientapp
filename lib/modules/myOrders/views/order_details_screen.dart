import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../controllers/order_details_controller.dart';

class OrderDetailsScreen extends GetView<OrderDetailsController> {
  const OrderDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black, size: 24.w),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'My Orders',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        centerTitle: false,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(
              color: AppColors.primary,
            ),
          );
        }

        if (controller.order.value == null) {
          return Center(
            child: Text(
              'Order not found',
              style: TextStyle(
                fontSize: 16.sp,
                color: AppColors.textSecondary,
              ),
            ),
          );
        }

        final order = controller.order.value!;
        final trackInfo = controller.getTrackInfo();

        return SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Order ID and Date
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Order Id: #${order.orderId} | Placed On: ${controller.formatDateTime(order.orderDate)}',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),

              Row(
                children: [
                  Text(
                    'Expected Delivery: 8-Dec-2025',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 24.h),

              // Track Your Order Section
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: AppColors.grey50,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: AppColors.grey200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Track Your Order',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'Check The Current Status Of Your Medicine Delivery',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    SizedBox(height: 20.h),

                    // Track Steps
                    _buildTrackSteps(order.status),
                  ],
                ),
              ),

              SizedBox(height: 24.h),

              // Delivery Address
              _buildSectionTitle('Delivery Address'),
              SizedBox(height: 12.h),
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: AppColors.grey50,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: AppColors.grey200),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 20.w,
                      color: AppColors.textSecondary,
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            order.patient?.fullName ?? 'N/A',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            order.patient?.phoneNumber ?? 'N/A',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: AppColors.textSecondary,
                            ),
                          ),
                          Text(
                            order.patient?.address ?? '4325 Chandra Chowk, Delhi, 110006',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 24.h),

              // Bill Details
              _buildSectionTitle('Bill Details'),
              SizedBox(height: 12.h),
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: AppColors.grey50,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: AppColors.grey200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Prescribed Medicines
                    Text(
                      'Prescribed Medicines',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 12.h),

                    // Medicine items
                    if (order.orderItems != null)
                      ...order.orderItems!.map((item) => Padding(
                        padding: EdgeInsets.only(bottom: 8.h),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.drugName,
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                      height: 18 / 12,
                                      letterSpacing: -0.11 * 12 / 100,
                                    ),
                                  ),
                                  Text(
                                    '${item.quantity} Tablets/Day × ${item.numberOfDay}',
                                    style: TextStyle(
                                      fontSize: 11.sp,
                                      color: AppColors.textTertiary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Text(
                            //   '₹ ${item.totalPrice.toStringAsFixed(0)}',
                            //   style: TextStyle(
                            //     fontSize: 12.sp,
                            //     fontWeight: FontWeight.w600,
                            //     color: Colors.black,
                            //   ),
                            // ),
                          ],
                        ),
                      )),

                    Divider(height: 24.h, color: AppColors.grey300),

                    // Price Details
                    Text(
                      'Price Details',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 12.h),

                    // Calculate subtotal
                    _buildPriceRow(
                      'Paracetamol (10 Tablets)',
                      '₹ ${order.orderItems?.fold<double>(0, (sum, item) => sum + (item.unitPrice * item.quantity)).toStringAsFixed(0) ?? "0"}',
                    ),
                    SizedBox(height: 8.h),
                    _buildPriceRow(
                      'Delivery Charges',
                      '₹ 50',
                    ),
                    SizedBox(height: 8.h),
                    _buildPriceRow(
                      'Discount',
                      '-₹ ${order.orderItems?.fold<double>(0, (sum, item) => sum + item.discount).toStringAsFixed(0) ?? "0"}',
                      color: AppColors.success,
                    ),

                    Divider(height: 24.h, color: AppColors.grey300),

                    // Total
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.account_balance_wallet_outlined,
                              size: 16.w,
                              color: AppColors.textSecondary,
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              'VFI',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          '₹ ${order.totalAmount.toStringAsFixed(0)}',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 24.h),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
    );
  }

  Widget _buildTrackSteps(String currentStatus) {
    final steps = [
      {'title': 'Order Placed', 'subtitle': 'Your Order Has Been Received'},
      {'title': 'Order Confirmed', 'subtitle': 'Pharmacy Has Confirmed Your Medicines'},
      {'title': 'Packed & Ready To Dispatch', 'subtitle': 'Your Medicines Are Packed'},
      {'title': 'Dispatched', 'subtitle': 'On The Way [20234589]'},
    ];

    int currentStep = 0;
    switch (currentStatus) {
      case 'Placed':
        currentStep = 0;
        break;
      case 'Confirmed':
        currentStep = 1;
        break;
      case 'Packed':
        currentStep = 2;
        break;
      case 'Dispatched':
        currentStep = 3;
        break;
    }

    return Column(
      children: List.generate(steps.length, (index) {
        final isActive = index <= currentStep;
        final isLast = index == steps.length - 1;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Circle and Line
            Column(
              children: [
                Container(
                  width: 24.w,
                  height: 24.h,
                  decoration: BoxDecoration(
                    color: isActive ? AppColors.success : Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isActive ? AppColors.success : AppColors.grey300,
                      width: 2,
                    ),
                  ),
                  child: isActive
                      ? Icon(
                    Icons.check,
                    size: 14.w,
                    color: Colors.white,
                  )
                      : null,
                ),
                if (!isLast)
                  Container(
                    width: 2,
                    height: 40.h,
                    color: isActive ? AppColors.success : AppColors.grey300,
                  ),
              ],
            ),
            SizedBox(width: 12.w),

            // Text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    steps[index]['title']!,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: isActive ? Colors.black : AppColors.textSecondary,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    steps[index]['subtitle']!,
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: AppColors.textTertiary,
                    ),
                  ),
                  if (!isLast) SizedBox(height: 16.h),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildPriceRow(String label, String value, {Color? color}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            color: AppColors.textSecondary,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: color ?? Colors.black,
          ),
        ),
      ],
    );
  }
}