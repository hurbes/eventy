import 'package:eventy/ui/common/app_colors.dart';
import 'package:eventy/ui/common/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_octicons/flutter_octicons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';

import '../details_form_viewmodel.dart';

class DetailsFormAppBar extends ViewModelWidget<DetailsFormViewModel> {
  const DetailsFormAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, DetailsFormViewModel viewModel) {
    return SliverAppBar(
      backgroundColor: kcBackgroundColor,
      elevation: 0,
      pinned: true,
      leading: IconButton(
        icon: const Icon(OctIcons.arrow_left_16, color: kcTextPrimaryColor),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Text(
        viewModel.event?.title ?? '',
        style: GoogleFonts.inter(
          color: kcTextPrimaryColor,
          fontSize: getResponsiveFontSize(context, fontSize: 40),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
