
import 'package:e_commerce/features/more/presentation/controllers/social_media_cubit/social_media_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../models/social_media.dart';
import '../../../data/dataSource/settings_data_source.dart';

class SocialMediaCubit extends Cubit<SocialMediaState> {
late   List<SocialMediaModel> socialMedia;
  SettingsApi api ;
  SocialMediaCubit({required this.api }) : super(SocialMediaInitial());



  void getSocialMedia()async{
    try{
      socialMedia = await api.socialMedia();
      emit(SocialMediaSuccess(socialMedia: socialMedia));
    }catch(e, stackTrace){
      emit(SocialMediaFailure(errMessage: '$e $stackTrace'));
    }
  }




}
