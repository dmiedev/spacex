import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:spacex/launch_details/bloc/bloc.dart';
import 'package:spacex_api/spacex_api.dart';
import 'package:spacex_ui/spacex_ui.dart';

class LaunchDetailsPage extends StatelessWidget {
  const LaunchDetailsPage({
    super.key,
    required this.launch,
  });

  final Launch launch;

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
          final images = state.launch.links?.flickr?.original;
          final number = state.launch.flightNumber;
          final name = state.launch.name;
          final details = state.launch.details;
          final redditLinks = state.launch.links?.reddit;
          final date = state.launch.dateUtc;
          final datePrecision = state.launch.datePrecision;
          return ListView(
            children: [
              if (images != null)
                Container(
                  padding: const EdgeInsets.only(bottom: 10),
                  height: 400,
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      if (images.isEmpty) {
                        return const Center(
                          child: Text(
                            'No images available.',
                            style: TextStyle(fontSize: 20),
                          ),
                        );
                      } else if (constraints.maxWidth < 600) {
                        return Image(
                          image: NetworkImage(images.first),
                          fit: BoxFit.fitHeight,
                        );
                      }
                      return ShaderMask(
                        blendMode: BlendMode.dstOut,
                        shaderCallback: (rect) => const LinearGradient(
                          colors: [
                            Colors.transparent,
                            Colors.black87,
                          ],
                          stops: [0.9, 1],
                        ).createShader(rect),
                        child: Center(
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: images.length,
                            itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Image(
                                image: NetworkImage(images[index]),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (number != null)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Text(
                          '#$number',
                          style: const TextStyle(fontSize: 26),
                        ),
                      ),
                    if (name != null)
                      Text(
                        name.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                  ],
                ),
              ),
              _DetailsSection(
                body: details ?? 'No details available.',
              ),
              if (date != null)
                _DetailsSection(
                  title: 'LAUNCH TIME',
                  body: _getLaunchTimeString(date, datePrecision),
                ),
              if (redditLinks?.campaign != null ||
                  redditLinks?.launch != null ||
                  redditLinks?.media != null ||
                  redditLinks?.recovery != null)
                _DetailsSection(
                  title: 'JOIN THE DISCUSSION',
                  body:
                      'There are multiple Reddit threads associated with this launch: ',
                  bulletList: [
                    if (redditLinks?.campaign != null)
                      _DetailsSectionListItem(
                        label: 'Campaign Thread',
                        onTap: () {},
                      ),
                    if (redditLinks?.launch != null)
                      _DetailsSectionListItem(
                        label: 'Discussion and Updates Thread',
                        onTap: () {},
                      ),
                    if (redditLinks?.media != null)
                      _DetailsSectionListItem(
                        label: 'Media Thread',
                        onTap: () {},
                      ),
                    if (redditLinks?.recovery != null)
                      _DetailsSectionListItem(
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

  String _getLaunchTimeString(DateTime date, DateTimePrecision? precision) {
    print(precision);
    var time = DateFormat.yMMMMd().format(date);
    if (precision == DateTimePrecision.hour) {
      time += '\n${DateFormat.jm().format(date)}';
    }
    return time;
  }
}

class _DetailsSection extends StatelessWidget {
  const _DetailsSection({
    super.key,
    this.title,
    this.body,
    this.bulletList,
  });

  final String? title;
  final String? body;
  final List<_DetailsSectionListItem>? bulletList;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                title!,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          if (body != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                body!,
                style: const TextStyle(
                  fontSize: 20,
                  height: 1.5,
                ),
              ),
            ),
          ...?bulletList,
        ],
      ),
    );
  }
}

class _DetailsSectionListItem extends StatelessWidget {
  const _DetailsSectionListItem({
    required this.label,
    this.onTap,
  });

  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    const fontSize = 20.0;
    const height = 1.5;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          '• ',
          style: TextStyle(fontSize: fontSize, height: height),
        ),
        InkWell(
          onTap: onTap,
          child: Text(
            label,
            style: TextStyle(
              decoration: onTap != null
                  ? TextDecoration.underline
                  : TextDecoration.none,
              fontSize: fontSize,
              height: height,
            ),
          ),
        ),
      ],
    );
  }
}
