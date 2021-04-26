import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';


List<String> months = [
    'jan.',
    'febr.',
    'march',
    'april',
    'may',
    'june',
    'july',
    'aug.',
    'sept.',
    'oct.',
    'nov.',
    'dec.'
  ]; 

String DataFormatter(Timestamp timestamp) {
  var data=timestamp.toDate();
  return '${data.day} ${months[data.month]} \'${data.year-2000}';
}

String NumberFormatter(int number){
  double thouthand=number/1000;
  double milion=number/1000000;
  if(milion>=1){
    return '${(milion*10).toInt()/10}M';
  }
  if(thouthand>=1){
    return '${(thouthand*10).toInt()/10}K';
  }
  return number.toString();
}