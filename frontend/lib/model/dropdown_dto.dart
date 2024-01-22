class DropdownDTO {
  String? message;
  List<WorkSteps>? data;

  DropdownDTO({this.message, this.data});

  DropdownDTO.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <WorkSteps>[];
      json['data'].forEach((v) {
        data!.add(WorkSteps.fromJson(v));
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

class WorkSteps {
  String? id;
  String? name;

  WorkSteps({this.id, this.name});

  WorkSteps.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}