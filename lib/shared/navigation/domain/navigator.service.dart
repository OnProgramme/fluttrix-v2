abstract class NavigatorService{
  Future<dynamic> navigate(String route, {dynamic arguments});
  Future<void> back([dynamic result]);
}