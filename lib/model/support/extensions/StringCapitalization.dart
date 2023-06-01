extension StringCapitalization on String {

  String get capitalize => '${this[0].toUpperCase()}${this.substring(1)}';
  String get capitalizeFirstOfEach => this.split(" ").map((str) => str.capitalize).join(" ");

}