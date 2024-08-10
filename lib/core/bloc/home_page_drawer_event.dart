part of 'home_page_drawer_bloc.dart';

@immutable
sealed class HomePageDrawerEvent {}

class NavigateTo extends HomePageDrawerEvent {
  final NavItem destination;

  NavigateTo({required this.destination});

  @override
  List<Object?> get props => [destination];
}
