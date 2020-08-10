class Note {
  String text;

  Note(this.text);

  Note.fromJson(Map<String, dynamic> json) {
    text = json['name_of_category'];
  }
}
