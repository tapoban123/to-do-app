part of 'home_page_drawer_bloc.dart';

enum NavItem {
  homePage,
  completedTasksPage,
  aboutPage,
}

// @immutable
// sealed class HomePageDrawerState {
//   final NavItem selectedItem;
//   HomePageDrawerState({required this.selectedItem});
// }

class HomePageDrawerInitial {
  final NavItem selectedItem;

  HomePageDrawerInitial({required this.selectedItem});

  @override
  List<Object> get props => [selectedItem];
}
