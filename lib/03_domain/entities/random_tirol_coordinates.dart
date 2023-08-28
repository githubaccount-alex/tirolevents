import 'dart:math';

class RandomTirolCoordinate {
  late double longitude;
  late double latitude;

  List<String> tirolCoordinates = [
    "47.2865, 11.3839",
    "47.1247, 11.0837",
    "47.3456, 10.9210",
    "47.5732, 12.2568",
    "47.0489, 11.6014",
    "47.3910, 11.1153",
    "47.2276, 11.8652",
    "47.5051, 11.7279",
    "47.1978, 10.4395",
    "47.6612, 11.3260",
    "47.3194, 10.6907",
    "47.7654, 11.9642",
    "47.5339, 10.9856",
    "47.4392, 10.2580",
    "47.0618, 10.6834",
    "47.2749, 11.2747",
    "47.6287, 11.2246",
    "47.8903, 11.4876",
    "47.4865, 10.5679",
    "47.1576, 11.7812",
    "47.4198, 11.6155",
    "47.7134, 11.6281",
    "47.2563, 10.8209",
    "47.5856, 11.8769",
    "47.0512, 11.2685",
    "47.3580, 11.5267",
    "47.4761, 11.0063",
    "47.2009, 11.2228",
    "47.7421, 11.0706",
    "47.3017, 11.9979",
  ];

  RandomTirolCoordinate() {
    Random random = Random();
    int randomIndex = random.nextInt(tirolCoordinates.length);
    String coordinate = tirolCoordinates[randomIndex];
    double latitude = double.parse(coordinate.split(', ')[0]);
    double longitude = double.parse(coordinate.split(', ')[1]);
    this.latitude = latitude;
    this.longitude = longitude;
  }
}
