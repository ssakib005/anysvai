class ApplicantListDTO {
  String? message;
  List<ApplicantDTO>? data;

  ApplicantListDTO({this.message, this.data});

  ApplicantListDTO.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <ApplicantDTO>[];
      json['data'].forEach((v) {
        data!.add(ApplicantDTO.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ApplicantDTO {
  int? id;
  String? applicantName;
  String? nidNo;
  String? mobileNo;
  String? freedomFighterName;
  String? fatherName;
  String? village;
  String? upazila;
  String? district;
  String? division;
  String? indianList;
  String? redLightRelease;
  String? govtCivilGadgetNo;
  String? misNo;
  String? landDetails;
  String? landLocation;
  List<ProjectProgressDTOS>? projectProgressDTOS;

  ApplicantDTO(
      {this.id,
      this.applicantName,
      this.nidNo,
      this.mobileNo,
      this.freedomFighterName,
      this.fatherName,
      this.village,
      this.upazila,
      this.district,
      this.division,
      this.indianList,
      this.redLightRelease,
      this.govtCivilGadgetNo,
      this.misNo,
      this.landDetails,
      this.landLocation,
      this.projectProgressDTOS});

  ApplicantDTO.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    applicantName = json['applicantName'];
    nidNo = json['nidNo'];
    mobileNo = json['mobileNo'];
    freedomFighterName = json['freedomFighterName'];
    fatherName = json['fatherName'];
    village = json['village'];
    upazila = json['upazila'];
    district = json['district'];
    division = json['division'];
    indianList = json['indianList'];
    redLightRelease = json['redLightRelease'];
    govtCivilGadgetNo = json['govtCivilGadgetNo'];
    misNo = json['misNo'];
    landDetails = json['landDetails'];
    landLocation = json['landLocation'];
    if (json['projectProgressDTOS'] != null) {
      projectProgressDTOS = <ProjectProgressDTOS>[];
      json['projectProgressDTOS'].forEach((v) {
        projectProgressDTOS!.add(ProjectProgressDTOS.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['applicantName'] = applicantName;
    data['nidNo'] = nidNo;
    data['mobileNo'] = mobileNo;
    data['freedomFighterName'] = freedomFighterName;
    data['fatherName'] = fatherName;
    data['village'] = village;
    data['upazila'] = upazila;
    data['district'] = district;
    data['division'] = division;
    data['indianList'] = indianList;
    data['redLightRelease'] = redLightRelease;
    data['govtCivilGadgetNo'] = govtCivilGadgetNo;
    data['misNo'] = misNo;
    data['landDetails'] = landDetails;
    data['landLocation'] = landLocation;
    if (projectProgressDTOS != null) {
      data['projectProgressDTOS'] =
          projectProgressDTOS!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProjectProgressDTOS {
  int? id;
  String? details;
  String? submittedDae;
  String? workStep;
  String? billingStatus;
  List<String>? images;

  ProjectProgressDTOS(
      {this.id,
      this.details,
      this.submittedDae,
      this.workStep,
      this.billingStatus,
      this.images});

  ProjectProgressDTOS.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    details = json['details'];
    submittedDae = json['submittedDae'];
    workStep = json['workStep'];
    billingStatus = json['billingStatus'];
    images = json['images'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['details'] = details;
    data['submittedDae'] = submittedDae;
    data['workStep'] = workStep;
    data['billingStatus'] = billingStatus;
    data['images'] = images;
    return data;
  }
}