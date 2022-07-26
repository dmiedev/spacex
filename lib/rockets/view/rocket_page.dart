import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:rocket_repository/rocket_repository.dart';
import 'package:spacex/l10n/l10n.dart';
import 'package:spacex/rockets/bloc/bloc.dart';
import 'package:spacex_api/spacex_api.dart';
import 'package:spacex_ui/spacex_ui.dart';

class RocketPage extends StatelessWidget {
  const RocketPage({super.key});

  /// Returns a [MaterialPageRoute] that contains this page.
  static Route<RocketPage> route() {
    return MaterialPageRoute(
      builder: (context) => const RocketPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RocketBloc(
        rocketRepository: context.read<RocketRepository>(),
      )..add(RocketLoadRequested()),
      child: const _RocketView(),
    );
  }
}

class _RocketView extends StatelessWidget {
  const _RocketView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RocketBloc, RocketState>(
      builder: (context, state) {
        if (state is RocketInitial || state is RocketLoadInProgress) {
          return Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).colorScheme.onBackground,
            ),
          );
        } else if (state is RocketLoadFailure) {
          final l10n = context.l10n;
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: TextMessage(
                  title: l10n.loadingErrorMessageTitle,
                  text: l10n.loadingErrorMessageTextShort,
                  button: IconTextButton(
                    icon: const Icon(Icons.replay),
                    label: l10n.retryButtonLabel,
                    onPressed: () => _handleRetryButtonPress(context),
                  ),
                ),
              ),
            ],
          );
        }
        final tabs = _buildTabs(context, state as RocketLoadSuccess);
        return DefaultTabController(
          length: tabs.length,
          child: Scaffold(
            primary: false,
            appBar: AppBar(
              toolbarHeight: 0,
              bottom: TabBar(tabs: tabs, isScrollable: true),
            ),
            body: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
                for (final rocket in state.rockets)
                  _buildRocketArticle(context, rocket),
              ],
            ),
          ),
        );
      },
    );
  }

  List<Tab> _buildTabs(BuildContext context, RocketLoadSuccess state) {
    return state.rockets
        .map(
          (rocket) => Tab(
            text: rocket.name != null
                ? rocket.name!.toUpperCase()
                : context.l10n.unnamedRocketTitle,
          ),
        )
        .toList();
  }

  void _handleRetryButtonPress(BuildContext context) {
    context.read<RocketBloc>().add(RocketLoadRequested());
  }

  Widget _buildRocketArticle(BuildContext context, Rocket rocket) {
    final l10n = context.l10n;
    return Article(
      // Interactive Scrollbar (such as in multiple ListViews) requires these
      // ListViews to have unique ScrollControllers.
      controller: ScrollController(),
      images: rocket.flickrImages ?? [],
      title: rocket.name != null
          ? rocket.name!.toUpperCase()
          : l10n.unnamedRocketTitle,
      sections: [
        if (rocket.description != null)
          ArticleSection(body: rocket.description),
        if (rocket.active != null)
          ArticleSection(
            title: l10n.activeRocketSectionTitle,
            body: rocket.active!
                ? l10n.activeRocketSectionBodyYes
                : l10n.activeRocketSectionBodyNo,
          ),
        if (rocket.stages != null)
          ArticleSection(
            title: l10n.stagesRocketSectionTitle,
            body: '${rocket.stages}',
          ),
        if (rocket.boosters != null)
          ArticleSection(
            title: l10n.boostersRocketSectionTitle,
            body: '${rocket.boosters}',
          ),
        if (rocket.costPerLaunch != null)
          ArticleSection(
            title: l10n.costPerLaunchRocketSectionTitle,
            body: l10n.costPerLaunchRocketSectionBody(rocket.costPerLaunch!),
          ),
        if (rocket.successRatePct != null)
          ArticleSection(
            title: l10n.successRateRocketSectionTitle,
            body: l10n.successRateRocketSectionBody(rocket.successRatePct!),
          ),
        if (rocket.firstFlight != null && rocket.country != null)
          ArticleSection(
            title: l10n.firstFlightRocketSectionTitle,
            body: l10n.firstFlightRocketSectionBody(
              DateFormat.yMMMMd().format(rocket.firstFlight!),
              rocket.country!,
            ),
          ),
        if (rocket.height?.meters != null)
          ArticleSection(
            title: l10n.heightRocketSectionTitle,
            body: l10n.heightRocketSectionBodyMeters(rocket.height!.meters!),
          ),
        if (rocket.diameter?.meters != null)
          ArticleSection(
            title: l10n.diameterRocketSectionTitle,
            body:
                l10n.diameterRocketSectionBodyMeters(rocket.diameter!.meters!),
          ),
        if (rocket.mass?.kg != null)
          ArticleSection(
            title: l10n.massRocketSectionTitle,
            body: l10n.massRocketSectionBodyKilograms(rocket.mass!.kg!),
          ),
      ],
    );
  }
}
