abstract class LayoutStates{}

class LayoutInitialState extends LayoutStates{}

class ChangeBottomNavigationIndexState extends LayoutStates{}

class GetUserDataSuccessState extends LayoutStates{}
class GetUserDataLoadingState extends LayoutStates{}
class FailedToGetUserDataState extends LayoutStates{
  String message;
  FailedToGetUserDataState(this.message);
}