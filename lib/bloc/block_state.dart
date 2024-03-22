import 'package:meta/meta.dart';

abstract class BlocState<T> {
  T? data;
}

class BlocStateUninitialized extends BlocState {
  @override
  String toString() => 'BlocStateUninitialized';
}

class BlocStateLoading extends BlocState {
  @override
  String toString() => 'BlocStateLoading';
}

class BlocStateLoaded extends BlocState {
  var data;
  BlocStateLoaded({@required this.data});

  @override
  String toString() => 'BlocStateLoaded';
}

class BlocStateError extends BlocState {
  final dynamic error;
  BlocStateError({@required this.error});

  @override
  String toString() => 'RelatedError';
}
