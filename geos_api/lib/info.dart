class Info{
  String worker_id;
  String worker_group_id;
  String user_business_id;
  String? firstname;
  String? lastname;
  String? patronymic;
  String? initials;
  String? email;
  String? telephone;
  dynamic image;
  String? date_added;
  String? date_modified;
  String? post;

  Info({
      required this.worker_id,
      required this.worker_group_id,
      required this.user_business_id,
      this.firstname,
      this.lastname,
      this.patronymic,
      this.initials,
      this.email,
      this.telephone,
      this.image,
      this.date_added,
      this.date_modified,
      this.post});

  factory Info.fromMap(Map<String, dynamic> map){
    Map<String, dynamic> info = map['info'];
    return Info(
      worker_id: info['worker_id'],
      worker_group_id: info['worker_group_id'],
      user_business_id: info['user_business_id'],
      firstname: info['firstname'],
      lastname: info['lastname'],
      patronymic: info['patronymic'],
      initials: info['initials'],
      email: info['email'],
      telephone: info['telephone'],
      image: info['image'],
      date_added: info['date_added'],
      date_modified: info['date_modified'],
      post: info['post']
    );
  }
}