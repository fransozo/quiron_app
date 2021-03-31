// class Contact {
//   String allergyProf;
//   String birthProf;
//   String bloodProf;
//   List<String> diseProf;
//   String famNameProf;
//   String healthProf;
//   int heightProf;
//   String idUser;
//   List<String> mAllergyProf;
//   List<String> medicineProf;
//   String momNameProf;
//   int nHealthProf;
//   String nameProf;
//   String proxProf;
//   int rgProf;
//   String sexProf;
//   int weightProf;

//   Contact(
//       {this.allergyProf,
//       this.birthProf,
//       this.bloodProf,
//       this.diseProf,
//       this.famNameProf,
//       this.healthProf,
//       this.heightProf,
//       this.idUser,
//       this.mAllergyProf,
//       this.medicineProf,
//       this.momNameProf,
//       this.nHealthProf,
//       this.nameProf,
//       this.proxProf,
//       this.rgProf,
//       this.sexProf,
//       this.weightProf});

//   Contact.fromJson(Map<String, dynamic> json) {
//     allergyProf = json['allergy_prof'];
//     birthProf = json['birth_prof'];
//     bloodProf = json['blood_prof'];
//     diseProf = json['dise_prof'].cast<String>();
//     famNameProf = json['fam_name_prof'];
//     healthProf = json['health_prof'];
//     heightProf = json['height_prof'];
//     idUser = json['id_user'];
//     mAllergyProf = json['m_allergy_prof'].cast<String>();
//     medicineProf = json['medicine_prof'].cast<String>();
//     momNameProf = json['mom_name_prof'];
//     nHealthProf = json['n_health_prof'];
//     nameProf = json['name_prof'];
//     proxProf = json['prox_prof'];
//     rgProf = json['rg_prof'];
//     sexProf = json['sex_prof'];
//     weightProf = json['weight_prof'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['allergy_prof'] = this.allergyProf;
//     data['birth_prof'] = this.birthProf;
//     data['blood_prof'] = this.bloodProf;
//     data['dise_prof'] = this.diseProf;
//     data['fam_name_prof'] = this.famNameProf;
//     data['health_prof'] = this.healthProf;
//     data['height_prof'] = this.heightProf;
//     data['id_user'] = this.idUser;
//     data['m_allergy_prof'] = this.mAllergyProf;
//     data['medicine_prof'] = this.medicineProf;
//     data['mom_name_prof'] = this.momNameProf;
//     data['n_health_prof'] = this.nHealthProf;
//     data['name_prof'] = this.nameProf;
//     data['prox_prof'] = this.proxProf;
//     data['rg_prof'] = this.rgProf;
//     data['sex_prof'] = this.sexProf;
//     data['weight_prof'] = this.weightProf;
//     return data;
//   }
// }
