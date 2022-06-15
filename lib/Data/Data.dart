class Details{
  String last_name;
  String id;
  String email;
  String first_name;
  String avatar;
  Details({required this.id,required this.email,required this.first_name,required this.last_name,required this.avatar});

  String get name=> (first_name+last_name);
}