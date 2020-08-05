mixin UserUtils {
  String capitalize(String string) => string[0].toUpperCase() + string.substring(1).toLowerCase();
}