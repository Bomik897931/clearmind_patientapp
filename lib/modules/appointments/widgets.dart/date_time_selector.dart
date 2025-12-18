import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:patient_app/core/constants/app_text_style.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';

class DateTimeSelector extends StatefulWidget {
  final DateTime? selectedDate;
  final Function(DateTime) onDateSelected;

  const DateTimeSelector({
    Key? key,
    this.selectedDate,
    required this.onDateSelected,
  }) : super(key: key);

  @override
  State<DateTimeSelector> createState() => _DateTimeSelectorState();
}

class _DateTimeSelectorState extends State<DateTimeSelector> {
  late DateTime _currentMonth;

  @override
  void initState() {
    super.initState();
    _currentMonth = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppDimensions.paddingMD),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
      ),
      child: Column(
        children: [
          _buildMonthNavigation(),
          SizedBox(height: AppDimensions.paddingMD),
          _buildWeekDays(),
          SizedBox(height: AppDimensions.paddingSM),
          _buildCalendar(),
        ],
      ),
    );
  }

  Widget _buildMonthNavigation() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () {
            setState(() {
              _currentMonth = DateTime(
                _currentMonth.year,
                _currentMonth.month - 1,
              );
            });
          },
        ),
        // Text(
        //   DateFormat('MMMM yyyy').format(_currentMonth),
        //   style: AppTextStyles.h6,
        // ),
        IconButton(
          icon: const Icon(Icons.chevron_right),
          onPressed: () {
            setState(() {
              _currentMonth = DateTime(
                _currentMonth.year,
                _currentMonth.month + 1,
              );
            });
          },
        ),
      ],
    );
  }

  Widget _buildWeekDays() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su'].map((day) {
        return SizedBox(
          width: 40.w,
          child: Text(
            day,
            style: AppTextStyles.caption.copyWith(fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildCalendar() {
    final daysInMonth = DateUtils.getDaysInMonth(
      _currentMonth.year,
      _currentMonth.month,
    );
    final firstDayOfMonth = DateTime(
      _currentMonth.year,
      _currentMonth.month,
      1,
    );
    final firstWeekday = firstDayOfMonth.weekday;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemCount: 42,
      itemBuilder: (context, index) {
        final dayIndex = index - (firstWeekday - 1);

        if (dayIndex < 0 || dayIndex >= daysInMonth) {
          return const SizedBox();
        }

        final date = DateTime(
          _currentMonth.year,
          _currentMonth.month,
          dayIndex + 1,
        );
        final isSelected =
            widget.selectedDate != null &&
            date.year == widget.selectedDate!.year &&
            date.month == widget.selectedDate!.month &&
            date.day == widget.selectedDate!.day;

        return InkWell(
          onTap: () => widget.onDateSelected(date),
          borderRadius: BorderRadius.circular(AppDimensions.radiusSM),
          child: Container(
            decoration: BoxDecoration(
              color: isSelected ? AppColors.primary : Colors.transparent,
              borderRadius: BorderRadius.circular(AppDimensions.radiusSM),
            ),
            child: Center(
              child: Text(
                '${dayIndex + 1}',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: isSelected ? AppColors.white : AppColors.textPrimary,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
