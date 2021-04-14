List<String> dana = [
  'assets/img/dana/1.jpg',
  'assets/img/dana/2.jpg',
  'assets/img/dana/3.jpg',
  'assets/img/dana/4.jpg',
  'assets/img/dana/5.jpg',
];
List<String> another = ['assets/img/another/1.jpg','assets/img/another/2.jpg','assets/img/another/3.jpg'];

List<String> test = dana;

String getPhoto(index) {
  return test[index % test.length];
}
