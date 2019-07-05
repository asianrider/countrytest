import 'package:cloud_firestore/cloud_firestore.dart';

class Country {
  String name;
  String isoA2;
  String adm0A3;
  String geometry;
  var documentID;

  Country(this.name, this.isoA2, this.adm0A3, this.geometry);

  Country.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        isoA2 = json['iso_a2'],
        adm0A3 = json['adm0_a3'],
        geometry = json['geometry'];

  Map<String, dynamic> toJson() => {
    'name' : name,
    'iso_a2' : isoA2,
    'adm0_a3' : adm0A3,
    'geometry' : geometry
  };

  Country.fromSnapshot(DocumentSnapshot snapshot)
      : name = snapshot['name'],
        isoA2 = snapshot['iso_a2'],
        adm0A3 = snapshot['adm0_a3'],
        geometry = snapshot['geometry'],
        documentID = snapshot.documentID;

  void updateValues() {
      if (documentID) {
        Firestore.instance
            .collection("countries").document(documentID).setData(toJson());
      }
  }

}

