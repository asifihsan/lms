// ignore_for_file: unused_import

import 'package:flutter/foundation.dart';

import '../networking/api_service.dart';

import '../../utils/enums/endpoint_enum.dart';

import 'interface_data_repository.dart';

import '../../models/author.dart';
import '../../models/book.dart';
import '../../models/genre.dart';
import '../../models/member.dart';
import '../../models/author_review.dart';
import '../../models/book_review.dart';
import '../../models/member_author_review.dart';
import '../../models/member_book_review.dart';
import '../../models/book_copy.dart';
import '../../models/member_book_issue.dart';

abstract class IDataRepository {
  Stream<List<BookCopy>> bookCopiesStream({required int id});
}

class DataRepository implements IDataRepository {
  DataRepository._();

  /// Singleton instance of a DataRepository class.
  static final instance = DataRepository._();

  final ApiService _apiService = ApiService.instance;

  @override
  Stream<List<BookCopy>> bookCopiesStream({required int id}) {
    return _apiService.collectionStream<BookCopy>(
      endPoint: EndPoint.BOOK_COPIES,
      id: id.toString(),
      builder: (data) => BookCopy.fromJson(data),
    );
  }

  Stream<List<Book>> booksStream() {
    return _apiService.collectionStream<Book>(
      endPoint: EndPoint.BOOKS,
      builder: (data) => Book.fromJson(data),
    );
  }

  Stream<List<Author>> authorsStream() {
    return _apiService.collectionStream<Author>(
      endPoint: EndPoint.AUTHORS,
      builder: (data) => Author.fromJson(data),
    );
  }

  Stream<List<Genre>> genresStream() {
    return _apiService.collectionStream<Genre>(
      endPoint: EndPoint.GENRES,
      builder: (data) => Genre.fromJson(data),
    );
  }

  Stream<List<Member>> membersStream() {
    return _apiService.collectionStream<Member>(
      endPoint: EndPoint.MEMBERS,
      builder: (data) => Member.fromJson(data),
    );
  }

  Stream<Author> authorStream({required int id}) {
    return _apiService.documentStream(
      endPoint: EndPoint.AUTHORS,
      id: id.toString(),
      builder: (data) => Author.fromJson(data),
    );
  }

  Stream<Book> bookStream({required int id}) {
    return _apiService.documentStream(
      endPoint: EndPoint.BOOKS,
      id: id.toString(),
      builder: (data) => Book.fromJson(data),
    );
  }

  Stream<Member> memberStream({required int id}) {
    return _apiService.documentStream(
      endPoint: EndPoint.MEMBERS,
      id: id.toString(),
      builder: (data) => Member.fromJson(data),
    );
  }

  Future<int> copyIssuesCount({required int id}) async {
    return await _apiService.documentFuture<int>(
      endPoint: EndPoint.COPY_ISSUES_COUNT,
      id: id.toString(),
      builder: (data) => data["count_issues"],
    );
  }

  Future<int> addBookIssue({required Map<String, dynamic> data}) async {
    return await _apiService.setData(
      endPoint: EndPoint.BOOK_COPIES_ISSUES,
      data: data,
      builder: (response) => response["issue_id"],
    );
  }

  Future<int> createAccount({required Map<String, dynamic> data}) async {
    return await _apiService.setData(
      endPoint: EndPoint.MEMBERS,
      data: data,
      builder: (response) => response["m_id"],
    );
  }

  Future<int> changeAccountData(
      {required Map<String, dynamic> data, required int id}) async {
    print(data);
    return await _apiService.updateData(
      endPoint: EndPoint.MEMBERS,
      id: id.toString(),
      data: data,
      builder: (response) => response["m_id"],
    );
  }

  Future<int> changeMemberPreferences(
      {required Map<String, dynamic> data}) async {
    return await _apiService.setData(
      endPoint: EndPoint.MEMBER_PREFS_TABLE,
      data: data,
      builder: (response) => response["m_id"],
    );
  }

  Future<void> deleteMemberPreferences({required String id}) async {
    return await _apiService.deleteData(
      endPoint: EndPoint.MEMBER_PREFS_TABLE,
      id: id,
      builder: (response) => response["rowsDeleted"],
    );
  }

  top5NewBooksStream() {}

  top5RatedBooksStream() {}

  genreBooksStream({required int id}) {}

  authorBooksStream({required int id}) {}

  bookAuthorsStream({required int id}) {}

  authorReviewsStream({required int id}) {}

  bookReviewsStream({required int id}) {}

  authorGenresStream({required int id}) {}

  memberGenresStream({required int id}) {}

  bookGenresStream({required int id}) {}

  memberBookIssuesStream({required int id}) {}
}
