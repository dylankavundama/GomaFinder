abstract class BlocEvent {}


class BlocEventFetch extends BlocEvent {
  final String? data;
  final String? dateDebut;
  final String? dateFin;
  final String? search;
  final int? limit;
  BlocEventFetch(
      {this.data, this.dateDebut, this.dateFin, this.search, this.limit});
  @override
  String toString() => 'BlocEventFetch';
}

class BlocEventStoriesFetch extends BlocEvent {
  BlocEventStoriesFetch();
  @override
  String toString() => 'BlocEventStoriesFetch';
}
