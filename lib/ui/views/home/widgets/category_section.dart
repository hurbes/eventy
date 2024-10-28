import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:eventy/ui/common/app_colors.dart';
import 'package:stacked/stacked.dart';
import '../home_viewmodel.dart';

class CategorySection extends ViewModelWidget<HomeViewModel> {
  const CategorySection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    final categories = [
      {'icon': '✨', 'label': 'Upcoming'},
      {'icon': '⏲︎', 'label': 'Past Events'},
    ];

    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return CategoryItem(
            icon: categories[index]['icon'] as String,
            label: categories[index]['label'] as String,
            isSelected: viewModel.currentIndex == index,
            onTap: () => viewModel.setIndex(index),
          );
        },
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final String icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryItem({
    Key? key,
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 350),
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? withOpacity(kcPrimaryColor, 0.7)
              : ComponentColors.cardBackground,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(icon, style: const TextStyle(fontSize: 16)),
            const SizedBox(width: 8),
            Text(
              label,
              style: GoogleFonts.inter(
                color: isSelected ? kcTextPrimaryColor : kcTextSecondaryColor,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
