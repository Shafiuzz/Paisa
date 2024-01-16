import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:image_picker/image_picker.dart';
import 'package:paisa/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:paisa/main.dart';

import 'package:paisa/core/common.dart';
import 'package:paisa/core/widgets/paisa_widget.dart';
import 'package:provider/provider.dart';

class IntroImagePickerWidget extends StatelessWidget {
  const IntroImagePickerWidget({
    Key? key,
  }) : super(key: key);

  void _pickImage(BuildContext context) {
    final ImagePicker picker = ImagePicker();
    picker.pickImage(source: ImageSource.gallery).then((pickedFile) {
      if (pickedFile != null) {
        Provider.of<Box<dynamic>>(context).put(userImageKey, pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt.get<ProfileCubit>(),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IntroTopWidget(
              title: context.loc.image,
              icon: Icons.camera_enhance,
              description: context.loc.imageDesc,
            ),
            Center(
              child: PaisaUserImageWidget(
                pickImage: () => _pickImage(context),
                maxRadius: 72,
                useDefault: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class IntroTopWidget extends StatelessWidget {
  const IntroTopWidget({
    super.key,
    required this.title,
    this.titleWidget,
    this.description,
    required this.icon,
  });

  final String? description;
  final IconData icon;
  final String title;
  final Widget? titleWidget;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.8,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          ColorFiltered(
            colorFilter: ColorFilter.mode(
              context.primary,
              BlendMode.srcIn,
            ),
            child: Icon(
              icon,
              size: 72,
            ),
          ),
          const SizedBox(height: 16),
          titleWidget ??
              Text(
                title,
                style: context.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: context.onSurface,
                ),
              ),
          const SizedBox(height: 6),
          if (description != null)
            Text(
              description!,
              style: context.titleSmall?.copyWith(
                color:
                    Theme.of(context).colorScheme.onSurface.withOpacity(0.75),
              ),
            )
          else
            const SizedBox.shrink(),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
