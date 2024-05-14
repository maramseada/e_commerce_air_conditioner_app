

import 'package:flutter/cupertino.dart';

import '../../../../../models/social_media.dart';

@immutable
abstract class SocialMediaState {

}
class SocialMediaInitial extends SocialMediaState{}
class SocialMediaLoading extends SocialMediaState{}
class SocialMediaSuccess extends SocialMediaState{
  List<SocialMediaModel> socialMedia;
  SocialMediaSuccess({  required this.socialMedia});
}
class SocialMediaFailure extends SocialMediaState{
  String errMessage;
  SocialMediaFailure({required this.errMessage});
}
