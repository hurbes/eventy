import 'package:flutter/material.dart';
import 'package:eventy/ui/common/app_colors.dart';

class AvatarStack extends StatelessWidget {
  const AvatarStack({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 96,
      height: 24,
      child: Stack(
        children: List.generate(4, (index) {
          return Positioned(
            left: index * 18.0,
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: kcTextPrimaryColor, width: 2),
              ),
              child: ClipOval(
                child: Image.network(
                  'https://picsum.photos/seed/face$index/100/100',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
