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
        color = AppColors.green;
        break;
      case 'pending':
        color = AppColors.orange;
        break;
      case 'cancelled':
        color = AppColors.red;
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

/*
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
    super.key,
    required this.appointment,
    required this.type,
    required this.onTap,
    this.onReschedule,
    this.onCancel,
    this.onLeaveReview,
    this.onBookAgain,
    this.onCall,
  });

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
              _formatAppointmentDateTime(
                appointment.appointmentDate,
                appointment.time,
              ),
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
              onPressed: onCall,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: EdgeInsets.symmetric(vertical: 12.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppDimensions.radiusSM),
                ),
              ),
              child: Text(
                'Join Call',
                style: AppTextStyles.bodySmall.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.white,
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
                  color: AppColors.white,
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
        color = AppColors.orange;
        displayStatus = 'Upcoming';
        break;
      case 'cancelled':
        color = AppColors.red;
        displayStatus = 'Cancelled';
        break;
      case 'completed':
        color = AppColors.blue;
        displayStatus = 'Completed';
        break;
      default:
        color = AppColors.lightGrey;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
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
          'Jan',
          'Feb',
          'Mar',
          'Apr',
          'May',
          'Jun',
          'Jul',
          'Aug',
          'Sep',
          'Oct',
          'Nov',
          'Dec',
        ];
        dateText = '${months[date.month - 1]} ${date.day}, ${date.year}';
      }

      return '$dateText | $time';
    } catch (e) {
      return '$dateString | $time';
    }
  }
}
*/


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/app_colors.dart';
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
    super.key,
    required this.appointment,
    required this.type,
    required this.onTap,
    this.onReschedule,
    this.onCancel,
    this.onLeaveReview,
    this.onBookAgain,
    this.onCall,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Doctor Info Row with Image and Status
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Doctor Image
              // ClipRRect(
              //   borderRadius: BorderRadius.circular(8.r),
              //   child: Container(
              //     width: 60.w,
              //     height: 70.h,
              //     color: AppColors.grey100,
              //     child: appointment.doctorImage != null
              //         ? Image.network(
              //       appointment.doctorImage!,
              //       fit: BoxFit.cover,
              //       errorBuilder: (context, error, stackTrace) =>
              //           _buildPlaceholderImage(),
              //     )
              //         : _buildPlaceholderImage(),
              //   ),
              // ),
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
              SizedBox(width: 12.w),

              // Doctor Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Doctor Name
                    Text(
                      appointment.doctorName,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 2.h),

                    // Specialization
                    Text(
                      appointment.diagnosis,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    SizedBox(height: 8.h),

                    // Date and Time Row
                    Row(
                      children: [
                        // Date
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Date',
                              style: TextStyle(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w400,
                                color: AppColors.textSecondary,
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              _formatDate(appointment.appointmentDate),
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 20.w),

                        // Time
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Time',
                              style: TextStyle(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w400,
                                color: AppColors.textSecondary,
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              appointment.time,
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Status Badge
              _buildStatusBadge(),
            ],
          ),

          SizedBox(height: 12.h),

          // Action Buttons
          _buildActionButtons(),
        ],
      ),
    );
  }

  Widget _buildPlaceholderImage() {
    return Container(
      color: AppColors.grey100,
      child: Center(
        child: Icon(
          Icons.person,
          size: 30.w,
          color: AppColors.textTertiary,
        ),
      ),
    );
  }

  Widget _buildStatusBadge() {
    String statusText;
    Color statusColor;

    switch (type) {
      case 'upcoming':
        statusText = 'Upcoming';
        statusColor = Color(0xFFFF9800); // Orange
        break;
      case 'completed':
        statusText = 'Completed';
        statusColor = Color(0xFF4CAF50); // Green
        break;
      case 'cancelled':
        statusText = 'Cancelled';
        statusColor = Color(0xFFF44336); // Red
        break;
      default:
        statusText = type;
        statusColor = AppColors.grey400;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Text(
        statusText,
        style: TextStyle(
          fontSize: 10.sp,
          fontWeight: FontWeight.w600,
          color: statusColor,
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    if (type == 'upcoming') {
      // Check if Join Call should be enabled (5 minutes before appointment)
      bool isJoinCallEnabled = _canJoinCall();

      return Row(
        children: [
          // Cancel Appointment Button
          Expanded(
            child: OutlinedButton(
              onPressed: onCancel,
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.primary,
                side: BorderSide(color: AppColors.grey300, width: 1),
                padding: EdgeInsets.symmetric(vertical: 10.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.r),
                ),
              ),
              child: Text(
                'Cancel Appointment',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
          SizedBox(width: 8.w),

          // Join Call Button
          Expanded(
            child: ElevatedButton(
              onPressed: isJoinCallEnabled ? onCall : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: isJoinCallEnabled
                    ? AppColors.primary
                    : AppColors.grey300,
                disabledBackgroundColor: AppColors.grey300,
                padding: EdgeInsets.symmetric(vertical: 10.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.r),
                ),
                elevation: 0,
              ),
              child: Text(
                'Join Call',
                style: TextStyle(
                  fontSize: 12.sp,
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
          // Appointment Detail Button
          Expanded(
            child: OutlinedButton(
              onPressed: onTap,
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.primary,
                side: BorderSide(color: AppColors.grey300, width: 1),
                padding: EdgeInsets.symmetric(vertical: 10.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.r),
                ),
              ),
              child: Text(
                'Appointment Detail',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
          SizedBox(width: 8.w),

          // Book Again Button
          Expanded(
            child: ElevatedButton(
              onPressed: onBookAgain,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: EdgeInsets.symmetric(vertical: 10.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.r),
                ),
                elevation: 0,
              ),
              child: Text(
                'Book Again',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      );
    } else if (type == 'cancelled') {
      return Row(
        children: [
          // Refund Details Button
          Expanded(
            child: OutlinedButton(
              onPressed: onTap,
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.primary,
                side: BorderSide(color: AppColors.grey300, width: 1),
                padding: EdgeInsets.symmetric(vertical: 10.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.r),
                ),
              ),
              child: Text(
                'Refund Details',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
          SizedBox(width: 8.w),

          // Book Again Button
          Expanded(
            child: ElevatedButton(
              onPressed: onBookAgain,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: EdgeInsets.symmetric(vertical: 10.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.r),
                ),
                elevation: 0,
              ),
              child: Text(
                'Book Again',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      );
    }

    return const SizedBox.shrink();
  }

  // Check if user can join the call (5 minutes before appointment time)
  bool _canJoinCall() {
    try {
      final appointmentDateTime = DateTime.parse(appointment.appointmentDate);

      // Parse time (format: "9:00 Am to 9:15 Am")
      final timeString = appointment.time.split(' to ')[0].trim();
      final timeParts = timeString.split(' ');
      final hourMin = timeParts[0].split(':');
      int hour = int.parse(hourMin[0]);
      final minute = int.parse(hourMin[1]);

      // Handle AM/PM
      if (timeParts[1].toLowerCase() == 'pm' && hour != 12) {
        hour += 12;
      } else if (timeParts[1].toLowerCase() == 'am' && hour == 12) {
        hour = 0;
      }

      // Create full appointment datetime
      final fullAppointmentTime = DateTime(
        appointmentDateTime.year,
        appointmentDateTime.month,
        appointmentDateTime.day,
        hour,
        minute,
      );

      // Check if current time is within 5 minutes before appointment
      final now = DateTime.now();
      final fiveMinutesBefore = fullAppointmentTime.subtract(Duration(minutes: 5));

      // Enable if current time is 5 minutes before or after appointment start
      return now.isAfter(fiveMinutesBefore) && now.isBefore(fullAppointmentTime.add(Duration(hours: 1)));
    } catch (e) {
      // If parsing fails, disable the button
      return false;
    }
  }

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      final day = date.day.toString().padLeft(2, '0');
      final month = date.month.toString().padLeft(2, '0');
      final year = date.year;
      return '$day/$month/$year';
    } catch (e) {
      return dateString;
    }
  }
}