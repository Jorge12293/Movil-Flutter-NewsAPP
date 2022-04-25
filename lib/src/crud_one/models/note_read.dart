class NoteReade{
  String noteId;
  String noteTitle;
  String noteContent;
  DateTime createDateTime;
  DateTime latestEditDateTime;

  NoteReade({
    required this.noteId,
    required this.noteTitle,
    required this.noteContent,
    required this.createDateTime,
    required this.latestEditDateTime,
  });

  factory NoteReade.fromJson(Map<String,dynamic> item){
    return NoteReade(
      noteId: item['noteID'], 
      noteTitle: item['noteTitle'], 
      noteContent: item['noteContent'], 
      createDateTime: DateTime.parse(item['createDateTime']), 
      latestEditDateTime:item['latestEditDateTime'] == null   
        ? DateTime.parse(item['createDateTime'])
        : DateTime.parse(item['latestEditDateTime'])
    );
  }
  
}