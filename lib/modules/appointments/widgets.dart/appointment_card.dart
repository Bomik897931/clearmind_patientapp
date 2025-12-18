/*
// lib/modules/appointments/widgets/appointment_card.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_text_style.dart';
import '../../../data/models/appointment_model.dart';

class AppointmentCard extends StatelessWidget {
  final Appointment appointment;
  final bool isUpcoming;
  final VoidCallback onTap;
  final VoidCallback? onReschedule;

  const AppointmentCard({
    Key? key,
    required this.appointment,
    required this.isUpcoming,
    required this.onTap,
    this.onReschedule,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
      ),
      child: InkWell(
        onTap: (){},
        // onTap: onTap,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
        child: Padding(
          padding: EdgeInsets.all(AppDimensions.paddingMD),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Doctor Info
              Row(
                children: [
                  // CircleAvatar(
                  //   radius: 30.w,
                  //   backgroundColor: AppColors.primary.withOpacity(0.1),
                  //   child: appointment.profilePicUrl != null &&
                  //       appointment.profilePicUrl != 'string'
                  //       ? ClipOval(
                  //     child: Image.network(
                  //       appointment.profilePicUrl!,
                  //       fit: BoxFit.cover,
                  //       errorBuilder: (_, __, ___) => Icon(
                  //         Icons.person,
                  //         size: 30.w,
                  //         color: AppColors.primary,
                  //       ),
                  //     ),
                  //   )
                  //       : Icon(
                  //     Icons.person,
                  //     size: 30.w,
                  //     color: AppColors.primary,
                  //   ),
                  // ),
                  //
                  CircleAvatar(
                    radius: 30.w,
                    backgroundColor: AppColors.primary.withOpacity(0.1),
                    child: Text(
                      appointment.doctorName.isNotEmpty
                          ? appointment.doctorName[0].toUpperCase()
                          : 'D',
                      style: AppTextStyles.h4.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(width: AppDimensions.paddingSM),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          appointment.doctorName,
                          style: AppTextStyles.bodyLarge.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          appointment.diagnosis,
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  _buildStatusChip(appointment.status),
                ],
              ),

              Divider(height: AppDimensions.paddingLG),

              // Appointment Details
              _buildInfoRow(Icons.calendar_today, _formatDate(appointment.appointmentDate)),
              SizedBox(height: AppDimensions.paddingXS),
              _buildInfoRow(Icons.access_time, appointment.time),
              SizedBox(height: AppDimensions.paddingXS),
              _buildInfoRow(Icons.location_city, appointment.city),

              if (appointment.reason.isNotEmpty) ...[
                SizedBox(height: AppDimensions.paddingXS),
                _buildInfoRow(Icons.note, appointment.reason),
              ],

              // Action Buttons
              if (isUpcoming) ...[
                SizedBox(height: AppDimensions.paddingSM),
                Row(
                  children: [
                    // Expanded(
                    //   child: OutlinedButton(
                    //     onPressed: (){},
                    //     // onPressed: onReschedule,
                    //     child: const Text('Reschedule'),
                    //   ),
                    // ),
                    // SizedBox(width: AppDimensions.paddingSM),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: (){},
                        // onPressed: onTap,
                        child: const Text('Call'),
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color color;
    String displayStatus = status;

    switch (status.toLowerCase()) {
      case 'confirmed':
        color = Colors.green;
        break;
      case 'pending':
        color = Colors.orange;
        break;
      case 'cancelled':
        color = Colors.red;
        break;
      case 'completed':
        color = Colors.blue;
        break;
      default:
        color = Colors.grey;
    }

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingSM,
        vertical: AppDimensions.paddingXS,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppDimensions.radiusSM),
        border: Border.all(color: color),
      ),
      child: Text(
        displayStatus,
        style: AppTextStyles.bodySmall.copyWith(
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16.w, color: AppColors.textSecondary),
        SizedBox(width: AppDimensions.paddingXS),
        Expanded(
          child: Text(
            text,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ),
      ],
    );
  }

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
        'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
      return '${date.day} ${months[date.month - 1]}, ${date.year}';
    } catch (e) {
      return dateString.split('T')[0];
    }
  }
}*/

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_text_style.dart';
import '../../../data/models/appointment_model.dart';

class AppointmentCard extends StatelessWidget {
  final Appointment appointment;
  final String type; // 'upcoming', 'completed', 'cancelled'
  final VoidCallback onTap;
  final VoidCallback? onReschedule;
  final VoidCallback? onCancel;
  final VoidCallback? onLeaveReview;
  final VoidCallback? onBookAgain;
  final VoidCallback? onCall;

  const AppointmentCard({
    Key? key,
    required this.appointment,
    required this.type,
    required this.onTap,
    this.onReschedule,
    this.onCancel,
    this.onLeaveReview,
    this.onBookAgain,
    this.onCall,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
      ),
      child: Padding(
        padding: EdgeInsets.all(AppDimensions.paddingMD),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Doctor Info Row
            Row(
              children: [
                CircleAvatar(
                  radius: 35.w,
                  backgroundColor: AppColors.primary.withOpacity(0.1),
                  child: Text(
                    appointment.doctorName.isNotEmpty
                        ? appointment.doctorName[0].toUpperCase()
                        : 'D',
                    style: AppTextStyles.h4.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(width: AppDimensions.paddingSM),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        appointment.doctorName,
                        style: AppTextStyles.h6.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              appointment.diagnosis,
                              style: AppTextStyles.bodySmall.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ),
                          SizedBox(width: 8.w),
                          _buildStatusChip(appointment.status),
                        ],
                      ),
                    ],
                  ),
                ),
                // Message/Call Icon
                // Container(
                //   padding: EdgeInsets.all(12.w),
                //   decoration: BoxDecoration(
                //     color: AppColors.primary.withOpacity(0.1),
                //     shape: BoxShape.circle,
                //   ),
                //   child: Icon(
                //     _getAppointmentIcon(),
                //     color: AppColors.primary,
                //     size: 20.w,
                //   ),
                // ),
              ],
            ),

            SizedBox(height: AppDimensions.paddingSM),

            // Appointment Date & Time
            Text(
              _formatAppointmentDateTime(appointment.appointmentDate, appointment.time),
              style: AppTextStyles.bodyMedium.copyWith(
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
            ),

            // Action Buttons based on type
            SizedBox(height: AppDimensions.paddingSM),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  IconData _getAppointmentIcon() {
    if (type == 'upcoming') {
      // You can differentiate based on diagnosis or appointment type
      // For now, showing message icon for all upcoming
      return Icons.chat_bubble_outline;
    } else if (type == 'completed') {
      return Icons.chat_bubble_outline;
    }
    return Icons.chat_bubble_outline;
  }

  Widget _buildActionButtons() {
    if (type == 'upcoming') {
      return Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: onCancel,
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.primary,
                side: const BorderSide(color: AppColors.primary),
                padding: EdgeInsets.symmetric(vertical: 12.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppDimensions.radiusSM),
                ),
              ),
              child: Text(
                'Cancel Appointment',
                style: AppTextStyles.bodySmall.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          SizedBox(width: AppDimensions.paddingSM),
          Expanded(
            child: ElevatedButton(
              onPressed: onReschedule,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: EdgeInsets.symmetric(vertical: 12.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppDimensions.radiusSM),
                ),
              ),
              child: Text(
                'Reschedule',
                style: AppTextStyles.bodySmall.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      );
    } else if (type == 'completed') {
      return Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: onBookAgain,
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.primary,
                side: const BorderSide(color: AppColors.primary),
                padding: EdgeInsets.symmetric(vertical: 12.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppDimensions.radiusSM),
                ),
              ),
              child: Text(
                'Book Again',
                style: AppTextStyles.bodySmall.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          SizedBox(width: AppDimensions.paddingSM),
          Expanded(
            child: ElevatedButton(
              onPressed: onLeaveReview,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: EdgeInsets.symmetric(vertical: 12.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppDimensions.radiusSM),
                ),
              ),
              child: Text(
                'Leave a Review',
                style: AppTextStyles.bodySmall.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      );
    }

    // For cancelled - no action buttons
    return const SizedBox.shrink();
  }

  Widget _buildStatusChip(String status) {
    Color color;
    String displayStatus = status;

    switch (status.toLowerCase()) {
      case 'confirmed':
        color = AppColors.primary;
        displayStatus = type == 'upcoming' ? 'Upcoming' : 'Confirmed';
        break;
      case 'pending':
        color = Colors.orange;
        displayStatus = 'Upcoming';
        break;
      case 'cancelled':
        color = Colors.red;
        displayStatus = 'Cancelled';
        break;
      case 'completed':
        color = Colors.blue;
        displayStatus = 'Completed';
        break;
      default:
        color = Colors.grey;
    }

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10.w,
        vertical: 4.h,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(color: color, width: 1),
      ),
      child: Text(
        displayStatus,
        style: AppTextStyles.bodySmall.copyWith(
          color: color,
          fontWeight: FontWeight.w600,
          fontSize: 11.sp,
        ),
      ),
    );
  }

  String _formatAppointmentDateTime(String dateString, String time) {
    try {
      final date = DateTime.parse(dateString);
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final appointmentDate = DateTime(date.year, date.month, date.day);

      String dateText;
      if (appointmentDate == today) {
        dateText = 'Today';
      } else if (appointmentDate == today.add(const Duration(days: 1))) {
        dateText = 'Tomorrow';
      } else {
        final months = [
          'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
          'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
        ];
        dateText = '${months[date.month - 1]} ${date.day}, ${date.year}';
      }

      return '$dateText | $time';
    } catch (e) {
      return '$dateString | $time';
    }
  }
}




