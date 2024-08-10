import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'home_page_drawer_event.dart';
part 'home_page_drawer_state.dart';

class HomePageDrawerBloc
    extends Bloc<HomePageDrawerEvent, HomePageDrawerInitial> {
  HomePageDrawerBloc()
      : super(HomePageDrawerInitial(selectedItem: NavItem.homePage)) {
    on<NavigateTo>((event, emit) {
      if (event.destination != state.selectedItem) {}
    });
  }
}
