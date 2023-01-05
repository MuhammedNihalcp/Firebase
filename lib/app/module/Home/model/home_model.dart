class Details {
  String? name;
  String? mob;
  String? age;
  String? domain;
  String? id;
  Details({this.age, this.domain, this.mob, this.name, this.id});
  factory Details.fromJson(Map<String, dynamic> json) {
    return Details(
        name: json['name'],
        age: json['age'],
        mob: json['mob'],
        id: json['id'],
        domain: json['domain']);
  }
  Map<String, dynamic> toJson() => {
        'name': name,
        'age': age,
        'mob': mob,
        'id': id,
        'domain': domain,
      };
}
