// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'launch_links.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LaunchLinks _$LaunchLinksFromJson(Map<String, dynamic> json) => LaunchLinks(
      patch: json['patch'] == null
          ? const PatchLinks()
          : PatchLinks.fromJson(json['patch'] as Map<String, dynamic>),
      reddit: json['reddit'] == null
          ? const RedditLaunchLinks()
          : RedditLaunchLinks.fromJson(json['reddit'] as Map<String, dynamic>),
      flickr:
          FlickrLaunchLinks.fromJson(json['flickr'] as Map<String, dynamic>),
      pressKit: json['presskit'] as String?,
      webcast: json['webcast'] as String?,
      youtubeId: json['youtube_id'] as String?,
      article: json['article'] as String?,
      wikipedia: json['wikipedia'] as String?,
    );

Map<String, dynamic> _$LaunchLinksToJson(LaunchLinks instance) =>
    <String, dynamic>{
      'patch': instance.patch,
      'reddit': instance.reddit,
      'flickr': instance.flickr,
      'presskit': instance.pressKit,
      'webcast': instance.webcast,
      'youtube_id': instance.youtubeId,
      'article': instance.article,
      'wikipedia': instance.wikipedia,
    };

PatchLinks _$PatchLinksFromJson(Map<String, dynamic> json) => PatchLinks(
      small: json['small'] as String?,
      large: json['large'] as String?,
    );

Map<String, dynamic> _$PatchLinksToJson(PatchLinks instance) =>
    <String, dynamic>{
      'small': instance.small,
      'large': instance.large,
    };

RedditLaunchLinks _$RedditLaunchLinksFromJson(Map<String, dynamic> json) =>
    RedditLaunchLinks(
      campaign: json['campaign'] as String?,
      launch: json['launch'] as String?,
      media: json['media'] as String?,
      recovery: json['recovery'] as String?,
    );

Map<String, dynamic> _$RedditLaunchLinksToJson(RedditLaunchLinks instance) =>
    <String, dynamic>{
      'campaign': instance.campaign,
      'launch': instance.launch,
      'media': instance.media,
      'recovery': instance.recovery,
    };

FlickrLaunchLinks _$FlickrLaunchLinksFromJson(Map<String, dynamic> json) =>
    FlickrLaunchLinks(
      small: (json['small'] as List<dynamic>).map((e) => e as String).toList(),
      original:
          (json['original'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$FlickrLaunchLinksToJson(FlickrLaunchLinks instance) =>
    <String, dynamic>{
      'small': instance.small,
      'original': instance.original,
    };
