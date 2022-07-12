// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'launch_links.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LaunchLinks _$LaunchLinksFromJson(Map<String, dynamic> json) => $checkedCreate(
      'LaunchLinks',
      json,
      ($checkedConvert) {
        final val = LaunchLinks(
          patch: $checkedConvert(
              'patch',
              (v) => v == null
                  ? const PatchLinks()
                  : PatchLinks.fromJson(v as Map<String, dynamic>)),
          reddit: $checkedConvert(
              'reddit',
              (v) => v == null
                  ? const RedditLaunchLinks()
                  : RedditLaunchLinks.fromJson(v as Map<String, dynamic>)),
          flickr: $checkedConvert('flickr',
              (v) => FlickrLaunchLinks.fromJson(v as Map<String, dynamic>)),
          pressKit: $checkedConvert('presskit', (v) => v as String?),
          webcast: $checkedConvert('webcast', (v) => v as String?),
          youtubeId: $checkedConvert('youtube_id', (v) => v as String?),
          article: $checkedConvert('article', (v) => v as String?),
          wikipedia: $checkedConvert('wikipedia', (v) => v as String?),
        );
        return val;
      },
      fieldKeyMap: const {'pressKit': 'presskit', 'youtubeId': 'youtube_id'},
    );

Map<String, dynamic> _$LaunchLinksToJson(LaunchLinks instance) =>
    <String, dynamic>{
      'patch': instance.patch.toJson(),
      'reddit': instance.reddit.toJson(),
      'flickr': instance.flickr.toJson(),
      'presskit': instance.pressKit,
      'webcast': instance.webcast,
      'youtube_id': instance.youtubeId,
      'article': instance.article,
      'wikipedia': instance.wikipedia,
    };

PatchLinks _$PatchLinksFromJson(Map<String, dynamic> json) => $checkedCreate(
      'PatchLinks',
      json,
      ($checkedConvert) {
        final val = PatchLinks(
          small: $checkedConvert('small', (v) => v as String?),
          large: $checkedConvert('large', (v) => v as String?),
        );
        return val;
      },
    );

Map<String, dynamic> _$PatchLinksToJson(PatchLinks instance) =>
    <String, dynamic>{
      'small': instance.small,
      'large': instance.large,
    };

RedditLaunchLinks _$RedditLaunchLinksFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'RedditLaunchLinks',
      json,
      ($checkedConvert) {
        final val = RedditLaunchLinks(
          campaign: $checkedConvert('campaign', (v) => v as String?),
          launch: $checkedConvert('launch', (v) => v as String?),
          media: $checkedConvert('media', (v) => v as String?),
          recovery: $checkedConvert('recovery', (v) => v as String?),
        );
        return val;
      },
    );

Map<String, dynamic> _$RedditLaunchLinksToJson(RedditLaunchLinks instance) =>
    <String, dynamic>{
      'campaign': instance.campaign,
      'launch': instance.launch,
      'media': instance.media,
      'recovery': instance.recovery,
    };

FlickrLaunchLinks _$FlickrLaunchLinksFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'FlickrLaunchLinks',
      json,
      ($checkedConvert) {
        final val = FlickrLaunchLinks(
          small: $checkedConvert('small',
              (v) => (v as List<dynamic>).map((e) => e as String).toList()),
          original: $checkedConvert('original',
              (v) => (v as List<dynamic>).map((e) => e as String).toList()),
        );
        return val;
      },
    );

Map<String, dynamic> _$FlickrLaunchLinksToJson(FlickrLaunchLinks instance) =>
    <String, dynamic>{
      'small': instance.small,
      'original': instance.original,
    };
