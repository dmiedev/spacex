import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:spacex/launch_details/bloc/bloc.dart';
import 'package:spacex/launch_details/widgets/widgets.dart';
import 'package:spacex_api/spacex_api.dart';
import 'package:spacex_ui/spacex_ui.dart';

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
    return Scaffold(
      appBar: const SpacexAppBar(title: 'LAUNCH DETAILS'),
      body: BlocBuilder<LaunchDetailsBloc, LaunchDetailsState>(
        builder: (context, state) {
          final launch = state.launch;
          final images = launch.links?.flickr?.original;
          final redditLinks = launch.links?.reddit;
          return ListView(
            children: [
              if (images != null)
                Container(
                  padding: const EdgeInsets.only(bottom: 10),
                  height: 400,
                  child: ImageGallery(imageUrls: images),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (launch.flightNumber != null)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Text(
                          '#${launch.flightNumber}',
                          style: const TextStyle(fontSize: 26),
                        ),
                      ),
                    if (launch.name != null)
                      Text(
                        launch.name!.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                  ],
                ),
              ),
              DetailsSection(body: launch.details ?? 'No details available.'),
              if (launch.dateUtc != null)
                DetailsSection(
                  title: 'LAUNCH TIME (UTC)',
                  body: _getLaunchTimeString(
                    date: launch.dateUtc!,
                    precision: launch.datePrecision,
                  ),
                ),
              if (redditLinks?.campaign != null ||
                  redditLinks?.launch != null ||
                  redditLinks?.media != null ||
                  redditLinks?.recovery != null)
                DetailsSection(
                  title: 'JOIN THE DISCUSSION',
                  body:
                      'Check out Reddit threads associated with this launch: ',
                  bulletedList: [
                    if (redditLinks?.campaign != null)
                      DetailsSectionBullet(
                        label: 'Campaign Thread',
                        onTap: () {},
                      ),
                    if (redditLinks?.launch != null)
                      DetailsSectionBullet(
                        label: 'Discussion and Updates Thread',
                        onTap: () {},
                      ),
                    if (redditLinks?.media != null)
                      DetailsSectionBullet(
                        label: 'Media Thread',
                        onTap: () {},
                      ),
                    if (redditLinks?.recovery != null)
                      DetailsSectionBullet(
                        label: 'Recovery Thread',
                        onTap: () {},
                      ),
                  ],
                ),
              const SizedBox(height: 75),
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
}
