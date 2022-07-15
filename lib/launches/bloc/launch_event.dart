import 'package:meta/meta.dart';

@immutable
abstract class LaunchEvent {}

class LaunchPageRequested extends LaunchEvent {}
