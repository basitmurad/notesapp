
class MyNotes
{
int? id ;
String? title;
String? content;
DateTime modifiedTime;


MyNotes(
{
required this.id,
required this.title,
required this.content,
  required this.modifiedTime
});

static List<MyNotes> sampleNotes = [
  MyNotes(
    id: 0,
    title: 'Like and Subscribe',
    content:
    'A FREE way to support the channel is to give us a LIKE . It does not cost you but means a lot to us.\nIf you are new here please Subscribe',
    modifiedTime: DateTime(2024,1,1,12,5),

  ),

  MyNotes(
    id: 1,
    title: 'Ideas for Vacation',
    content:
    '1. Visit Grand Canyon\n2. Go on a hot air balloon ride\n3. Try local cuisine\n4. Attend a concert',
    modifiedTime: DateTime(2022,1,1,34,5),


  ),
  MyNotes(
    id: 2,
    title: 'Ideas for Vacation',
    content:
    '1. Visit Grand Canyon\n2. Go on a hot air balloon ride\n3. Try local cuisine\n4. Attend a concert',
    modifiedTime: DateTime(2022,1,1,34,5),


  ),
  MyNotes(
    id: 3,
    title: 'Ideas for Vacation',
    content:
    '1. Visit Grand Canyon\n2. Go on a hot air balloon ride\n3. Try local cuisine\n4. Attend a concert',
    modifiedTime: DateTime(2022,1,1,34,5),


  ),
  MyNotes(
    id: 4,
    title: 'Ideas for Vacation',
    content:
    '1. Visit Grand Canyon\n2. Go on a hot air balloon ride\n3. Try local cuisine\n4. Attend a concert',
    modifiedTime: DateTime(2022,1,1,34,5),


  ),
  MyNotes(
    id: 5,
    title: 'Like and Subscribe',
    content:
    'A FREE way to support the channel is to give us a LIKE . It does not cost you but means a lot to us.\nIf you are new here please Subscribe',
    modifiedTime: DateTime(2022,1,1,34,5),


  ),
  MyNotes(
    id: 6,
    title: 'Like and Subscribe',
    content:
    'A FREE way to support the channel is to give us a LIKE . It does not cost you but means a lot to us.\nIf you are new here please Subscribe',
    modifiedTime: DateTime(2024,1,15,13,56),


  ),
  MyNotes(
    id: 7,
    title: 'Like and Subscribe',
    content:
    'A FREE way to support the channel is to give us a LIKE . It does not cost you but means a lot to us.\nIf you are new here please Subscribe',
    modifiedTime: DateTime(2022,1,1,34,5),


  ),

];

}