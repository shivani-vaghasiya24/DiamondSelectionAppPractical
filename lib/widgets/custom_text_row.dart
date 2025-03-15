import 'package:diamond_selection_app/utils/app_colors.dart';
import 'package:diamond_selection_app/utils/app_styles.dart';
import 'package:flutter/material.dart';

class CustomTextRow extends StatelessWidget {
  const CustomTextRow({
    super.key,
    required this.title,
    required this.value,
    this.isMainRow = false,
    this.isFromFilter = false,
  });

  final String title;
  final String value;
  final bool isMainRow;
  final bool isFromFilter;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("$title ",
            style: isMainRow
                ? AppStyles.textStyle18
                : isFromFilter
                    ? AppStyles.textStyle14.copyWith(color: AppColors.textColor)
                    : AppStyles.textStyle16
                        .copyWith(fontWeight: FontWeight.w700)),
        Expanded(
          child: Text(value,
              style: isFromFilter
                  ? AppStyles.textStyle14
                  : (isMainRow ? AppStyles.textStyle18 : AppStyles.textStyle16)
                      .copyWith(fontWeight: FontWeight.w400)),
        ),
      ],
    );
  }
}
