class Note{
  String noteId;
  String noteTitle;
  DateTime createDateTime;
  DateTime latestEditDateTime;

  Note({
    required this.noteId,
    required this.noteTitle,
    required this.createDateTime,
    required this.latestEditDateTime,
  });

  factory Note.fromJson(Map<String,dynamic> item){
    return Note(
      noteId: item['noteID'], 
      noteTitle: item['noteTitle'], 
      createDateTime: DateTime.parse(item['createDateTime']), 
      latestEditDateTime:item['latestEditDateTime'] == null   
        ? DateTime.parse(item['createDateTime'])
        : DateTime.parse(item['latestEditDateTime'])
    );
  }
  
  
}