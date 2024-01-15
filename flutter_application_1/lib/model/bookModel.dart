class BookModel {
  final String name;
  final String author;
  final String year;
  final String url;
  final bool toRead;
  final bool isFinish;
  BookModel(
      {required this.name,
      required this.author,
      required this.year,
      required this.url,
      required this.toRead,
      required this.isFinish});
}
