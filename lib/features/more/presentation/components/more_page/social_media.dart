import 'package:e_commerce/features/more/presentation/components/more_page/social_media_body.dart';
import 'package:e_commerce/features/more/presentation/controllers/social_media_cubit/social_media_cubit.dart';
import 'package:e_commerce/features/more/presentation/controllers/social_media_cubit/social_media_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../models/social_media.dart';

class SocialMedia extends StatelessWidget {
  const SocialMedia({super.key});

  @override
  Widget build(BuildContext context) {
    late List<SocialMediaModel> socialMedia;

    return BlocBuilder<SocialMediaCubit, SocialMediaState>(builder: (context, state) {
      if (state is SocialMediaSuccess) {
        socialMedia = state.socialMedia;
        return SocialMediaBody(socialMedia: socialMedia);
      } else {
        return const SizedBox();
      }
    });
  }
}
