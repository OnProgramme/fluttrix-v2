abstract class NavigatorService{
  Future<dynamic> navigate(String route, {dynamic arguments, Map<String, String>? parameters});
  Future<dynamic> ofAllNames(String route, {dynamic arguments});
  Future<void> back([dynamic result]);
}