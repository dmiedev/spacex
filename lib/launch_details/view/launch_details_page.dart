import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:spacex/l10n/l10n.dart';
import 'package:spacex/launch_details/bloc/bloc.dart';
import 'package:spacex_api/spacex_api.dart';
import 'package:spacex_ui/spacex_ui.dart';
import 'package:url_launcher/url_launcher.dart';

/// A page that displays launch-related details.
class LaunchDetailsPage extends StatelessWidget {
  /// Creates a page that displays launch-related details.
  const LaunchDetailsPage({
    super.key,
    required this.launch,
  });

  /// The launch whose details are displayed.
  final Launch launch;

  /// Returns a [MaterialPageRoute] that contains this page.
  ///
  /// The [launch] parameter is the launch that this page displays details of.
  static Route<LaunchDetailsPage> route({required Launch launch}) {
    return MaterialPageRoute(
      builder: (context) => LaunchDetailsPage(
        launch: launch,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LaunchDetailsBloc(
        launch: launch,
      ),
      child: const _LaunchDetailsView(),
    );
  }
}

class _LaunchDetailsView extends StatelessWidget {
  const _LaunchDetailsView();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: SpacexAppBar(title: l10n.launchDetailsAppBarTitle),
      body: BlocBuilder<LaunchDetailsBloc, LaunchDetailsState>(
        builder: (context, state) {
          final launch = state.launch;
          final images = launch.links?.flickr?.original;
          final redditLinks = launch.links?.reddit;
          return Article(
            images: images ?? [],
            subtitle:
                launch.flightNumber != null ? '#${launch.flightNumber}' : null,
            title: launch.name != null ? launch.name!.toUpperCase() : null,
            description: ArticleSection(
              body: launch.details ?? l10n.noLaunchDetailsAvailableSectionBody,
            ),
            sections: [
              if (launch.dateUtc != null)
                ArticleSection(
                  title: l10n.launchTimeUtcSectionTitle,
                  body: _getLaunchTimeString(
                    date: launch.dateUtc!,
                    precision: launch.datePrecision,
                  ),
                ),
              if (redditLinks?.campaign != null ||
                  redditLinks?.launch != null ||
                  redditLinks?.media != null ||
                  redditLinks?.recovery != null)
                ArticleSection(
                  title: l10n.redditLinksSectionTitle,
                  body: l10n.redditLinksSectionBody,
                  bulletedList: [
                    if (redditLinks?.campaign != null)
                      DetailsSectionBullet(
                        label: l10n.campaignRedditLaunchThread,
                        onTap: () => _handleLinkTap(redditLinks!.campaign!),
                      ),
                    if (redditLinks?.launch != null)
                      DetailsSectionBullet(
                        label: l10n.discussionRedditLaunchThread,
                        onTap: () => _handleLinkTap(redditLinks!.launch!),
                      ),
                    if (redditLinks?.media != null)
                      DetailsSectionBullet(
                        label: l10n.mediaRedditLaunchThread,
                        onTap: () => _handleLinkTap(redditLinks!.media!),
                      ),
                    if (redditLinks?.recovery != null)
                      DetailsSectionBullet(
                        label: l10n.recoveryRedditLaunchThread,
                        onTap: () => _handleLinkTap(redditLinks!.recovery!),
                      ),
                  ],
                ),
            ],
          );
        },
      ),
    );
  }

  String _getLaunchTimeString({
    required DateTime date,
    DateTimePrecision? precision,
  }) {
    var time = DateFormat.yMMMMd().format(date);
    if (precision == DateTimePrecision.hour) {
      time += '\n${DateFormat.jm().format(date)}';
    }
    return time;
  }

  void _handleLinkTap(String link) {
    final url = Uri.tryParse(link);
    if (url != null) {
      launchUrl(url);
    }
  }
}
