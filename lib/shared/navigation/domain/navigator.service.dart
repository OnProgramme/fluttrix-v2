abstract class NavigatorService{
  Future<dynamic> navigate(String route, {dynamic arguments});
  Future<dynamic> ofAllNames(String route, {dynamic arguments});
  Future<void> back([dynamic result]);
}