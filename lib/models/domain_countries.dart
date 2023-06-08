class Country {
  final String name;
  final String domain;

  const Country({required this.name, required this.domain});
}

List<Country> countries = [
  const Country(name: "Russia", domain: "ru"),
  const Country(name: "Brazil", domain: "br"),
  const Country(name: "Korea", domain: "kr"),
  const Country(name: "USA", domain: "us"),
];
