class Location {
  Location({required this.country, required this.town, required this.image});
  String country, town, image;
}

List<Location> locations = [
  Location(
    country: 'Ethiopia',
    town: 'Addis Ababa',
    image: 'assets/images/aa.jpg',
  ),
  Location(
    town: 'Venice',
    country: 'Italy',
    image: 'assets/images/italy.jpg',
  ),
  Location(
      town: 'Machu Picchu',
      country: 'Peru',
      image: 'assets/images/machu_pichu.jpg'),
  Location(
    town: 'Bergen',
    country: 'Norway',
    image: 'assets/images/norway.jpg',
  ),
  Location(
    town: 'Alberta',
    country: 'Canada',
    image: 'assets/images/lake.jpg',
  )
];
