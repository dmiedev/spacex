import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'launch_links.g.dart';

/// A collection of links related to a rocket launch.
@JsonSerializable(fieldRename: FieldRename.snake)
class LaunchLinks extends Equatable {
  /// Creates a collection of links related to a rocket launch.
  const LaunchLinks({
    this.patch = const PatchLinks(),
    this.reddit = const RedditLaunchLinks(),
    required this.flickr,
    this.pressKit,
    this.webcast,
    this.youtubeId,
    this.article,
    this.wikipedia,
  });

  /// Links to the patch.
  final PatchLinks patch;

  /// Links to Reddit threads.
  final RedditLaunchLinks reddit;

  /// Links to Flickr images.
  final FlickrLaunchLinks flickr;

  /// A URL to a press kit.
  @JsonKey(name: 'presskit')
  final String? pressKit;

  /// A URL to a webcast.
  final String? webcast;

  /// An ID of a YouTube video.
  final String? youtubeId;

  /// A URL to an article.
  final String? article;

  /// A URL to a Wikipedia article.
  final String? wikipedia;

  @override
  List<Object?> get props => [
        patch,
        reddit,
        flickr,
        pressKit,
        webcast,
        youtubeId,
        article,
        wikipedia,
      ];

  /// Converts a given JSON [Map] into a [LaunchLinks] instance.
  static LaunchLinks fromJson(Map<String, dynamic> json) {
    return _$LaunchLinksFromJson(json);
  }

  /// Converts this [LaunchLinks] instance into a JSON [Map].
  Map<String, dynamic> toJson() => _$LaunchLinksToJson(this);
}

/// A collection of links to a launch patch.
@JsonSerializable(fieldRename: FieldRename.snake)
class PatchLinks extends Equatable {
  /// Creates a collection of links to a launch patch.
  const PatchLinks({
    this.small,
    this.large,
  });

  /// A URL to a small-sized image of the patch.
  final String? small;

  /// A URL to a large-sized image of the patch.
  final String? large;

  @override
  List<Object?> get props => [small, large];

  /// Converts a given JSON [Map] into a [PatchLinks] instance.
  static PatchLinks fromJson(Map<String, dynamic> json) {
    return _$PatchLinksFromJson(json);
  }

  /// Converts this [PatchLinks] instance into a JSON [Map].
  Map<String, dynamic> toJson() => _$PatchLinksToJson(this);
}

/// A collection of links to Reddit threads devoted to a rocket launch.
@JsonSerializable(fieldRename: FieldRename.snake)
class RedditLaunchLinks extends Equatable {
  /// Creates a collection of links to Reddit threads devoted to a rocket
  /// launch.
  const RedditLaunchLinks({
    this.campaign,
    this.launch,
    this.media,
    this.recovery,
  });

  /// A URL to a campaign thread.
  final String? campaign;

  /// A URL to a discussion and updates thread.
  final String? launch;

  /// A URL to a media thread.
  final String? media;

  /// A URL to a recovery thread.
  final String? recovery;

  @override
  List<Object?> get props => [campaign, launch, media, recovery];

  /// Converts a given JSON [Map] into a [RedditLaunchLinks] instance.
  static RedditLaunchLinks fromJson(Map<String, dynamic> json) {
    return _$RedditLaunchLinksFromJson(json);
  }

  /// Converts this [RedditLaunchLinks] instance into a JSON [Map].
  Map<String, dynamic> toJson() => _$RedditLaunchLinksToJson(this);
}

/// A collection of links to launch-related images on Flickr.
@JsonSerializable(fieldRename: FieldRename.snake)
class FlickrLaunchLinks extends Equatable {
  /// Creates a collection of links to launch-related images on Flickr.
  const FlickrLaunchLinks({
    required this.small,
    required this.original,
  });

  /// A list of URLs to small-sized images.
  final List<String> small;

  /// A list of URLs to images of original size.
  final List<String> original;

  @override
  List<Object?> get props => [small, original];

  /// Converts a given JSON [Map] into a [FlickrLaunchLinks] instance.
  static FlickrLaunchLinks fromJson(Map<String, dynamic> json) {
    return _$FlickrLaunchLinksFromJson(json);
  }

  /// Converts this [FlickrLaunchLinks] instance into a JSON [Map].
  Map<String, dynamic> toJson() => _$FlickrLaunchLinksToJson(this);
}
