// ignore_for_file: unnecessary_new, unnecessary_this

import 'package:flutter/foundation.dart';

import '../utils/helper.dart';
import '../utils/enums/book_issue_status_enum.dart';

import 'book_copy.dart';

class MemberBookIssue {
  final int _issueId;
  final int _mId;
  final BookCopy _bookCopy;
  final DateTime _issueDate;
  final DateTime _dueDate;
  final DateTime? _returnedDate; // Update to accept nullable DateTime
  final String _bookName;
  final String _authorName;
  final String _bookImageUrl;

  const MemberBookIssue({
    required String bookName, // Specify type for required parameters
    required String authorName, // Specify type for required parameters
    required String bookImageUrl, // Specify type for required parameters
    required int issueId,
    required int mId,
    required BookCopy bookCopy,
    required DateTime issueDate,
    required DateTime dueDate,
    required DateTime? returnedDate, // Update to accept nullable DateTime
  })  : _issueId = issueId,
        _mId = mId,
        _bookCopy = bookCopy,
        _issueDate = issueDate,
        _dueDate = dueDate,
        _returnedDate = returnedDate,
        _bookName = bookName,
        _bookImageUrl = bookImageUrl,
        _authorName = authorName;

  factory MemberBookIssue.fromJson(Map<String, dynamic> json) {
    return MemberBookIssue(
      issueId: json['issue_id'] as int,
      mId: json['m_id'] as int,
      bookCopy: BookCopy(
          copyId: json['copy_id'] as String, bkId: json['bk_id'] as int),
      issueDate: Helper.dateDeserializer(json['issue_date'])!,
      dueDate: Helper.dateDeserializer(json['due_date'])!,
      bookName: json['bk_name'] as String,
      authorName: json['a_name'] as String,
      bookImageUrl: json['bk_image_url'] as String,
      returnedDate: json['returned_date'] != null
          ? Helper.dateDeserializer(
              json['returned_date']) // No need for null check here
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'issue_id': _issueId,
      'm_id': _mId,
      'bk_id': _bookCopy.bkId,
      'copy_id': _bookCopy.copyId,
      'bk_name': _bookName,
      'a_name': _authorName,
      'bk_image_url': _bookImageUrl,
      'issue_date': _issueDate,
      'due_date': _dueDate,
      'returned_date': _returnedDate,
    };
  }

  BookCopy get bookCopy => _bookCopy;

  int get mId => _mId;

  int get issueId => _issueId;

  DateTime? get returnedDate =>
      _returnedDate; // Update to return nullable DateTime

  DateTime get dueDate => _dueDate;

  DateTime get issueDate => _issueDate;

  BookIssueStatus get status {
    if (_returnedDate != null) return BookIssueStatus.RETURNED;
    if (_dueDate.isBefore(DateTime.now())) return BookIssueStatus.OVERDUE;
    return BookIssueStatus.DUE;
  }

  String get authorName => _authorName;

  String get bookImageUrl => _bookImageUrl;

  String get bookName => _bookName;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MemberBookIssue &&
          runtimeType == other.runtimeType &&
          _issueId == other.issueId;

  @override
  int get hashCode => _issueId.hashCode;

  @override
  String toString() {
    return 'BookCopyIssue{issueId: $_issueId, mId: $_mId, bookCopy: $_bookCopy, issueDate: $_issueDate, dueDate: $_dueDate, returnedDate: $_returnedDate, bookName: $_bookName, authorName: $_authorName}';
  }
}
