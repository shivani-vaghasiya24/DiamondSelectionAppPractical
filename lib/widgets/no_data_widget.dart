import 'package:diamond_selection_app/utils/app_strings.dart';
import 'package:diamond_selection_app/utils/app_styles.dart';
import 'package:flutter/material.dart';

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(left: 8, right: 8, bottom: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // SvgImage(image: AppAssets.noEmployeeImage),
            Text(AppStrings.noDimondMessage,
                style: AppStyles.textStyle18
                    .copyWith(fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }
}
