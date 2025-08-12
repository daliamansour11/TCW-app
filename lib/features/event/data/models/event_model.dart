import 'live_model_details.dart';

class EventModel {

  final List<Meeting> data;
  final Links links;
  final Meta meta;

  EventModel({
    required this.data,
    required this.links,
    required this.meta,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      data: (json['data'] as List).map((e) => Meeting.fromJson(e)).toList(),
      links: Links.fromJson(json['links']),
      meta: Meta.fromJson(json['meta']),
    );
  }


}

class Instructor {

  factory Instructor.fromJson(Map<String, dynamic> json){
    return Instructor(
      id: json['id'],
      name: json['name'],
    );
  }
  Instructor({
    required this.id,
    required this.name,
  });

  final int? id;
  final String? name;
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
  };
}

class Link {

  factory Link.fromJson(Map<String, dynamic> json){
    return Link(
      url: json['url'],
      label: json['label'],
      active: json['active'],
    );
  }
  Link({
    required this.url,
    required this.label,
    required this.active,
  });

  final String? url;
  final String? label;
  final bool? active;

}
class MeetingResponse {
  final List<Meeting> data;
  final Links links;
  final Meta meta;

  MeetingResponse({
    required this.data,
    required this.links,
    required this.meta,
  });

  factory MeetingResponse.fromJson(Map<String, dynamic> json) {
    return MeetingResponse(
      data: (json['data'] as List).map((e) => Meeting.fromJson(e)).toList(),
      links: Links.fromJson(json['links']),
      meta: Meta.fromJson(json['meta']),
    );
  }
}

class Meeting {
  final int id;
  final String title;
  final String thumbUrl;
  final String meetingLink;
  final DateTime scheduledAt;
  final String scheduledForHumans;
  final Course course;
  final String subTitle;
  final Instructor instructor;
  final int enrolledStudentsCount;
  final List<Comment> comments;

  Meeting({
    required this.id,
    required this.title,
    required this.meetingLink,
    required this.scheduledAt,
    required this.scheduledForHumans,
    required this.course,
    required this.instructor,
    required this.enrolledStudentsCount,
    required this.comments,
    required this.subTitle,
    required this.thumbUrl,

  });

  factory Meeting.fromJson(Map<String, dynamic> json) => Meeting(
    id: json['id'],
    title: json['title'],
    subTitle: json['sub_title'],
    meetingLink: json['meeting_link'],
    thumbUrl: json['thumb_url'],

    scheduledAt: DateTime.parse(json['scheduled_at']),
    scheduledForHumans: json['scheduled_for_humans'],
    course: Course.fromJson(json['course']),
    instructor: Instructor.fromJson(json['instructor']),
    enrolledStudentsCount: json['enrolled_students_count'],
    comments: List<Comment>.from(json['comments']),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'meeting_link': meetingLink,
    'scheduled_at': scheduledAt.toIso8601String(),
    'scheduled_for_humans': scheduledForHumans,
    'course': course.toJson(),
    'instructor': instructor.toJson(),
    'enrolled_students_count': enrolledStudentsCount,
    'comments': comments,
  };
}
class Comment {
  final int id;
  final String body;
  final String createdAt;
  final Instructor author;

  Comment({
    required this.id,
    required this.body,
    required this.createdAt,
    required this.author,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      body: json['body'],
      createdAt: json['created_at'],
      author: Instructor.fromJson(json['author']),
    );
  }
  Map<String, dynamic> toJson() => {
    'id': id,
    'body': body,
    'created_at': createdAt,
    'author': author.toJson(),
  };
}
class Links {
  final String? first;
  final String? last;
  final String? prev;
  final String? next;


  Links({
    this.first,
    this.last,
    this.prev,
    this.next,
  });

  factory Links.fromJson(Map<String, dynamic> json) {
    return Links(
      first: json['first'],
      last: json['last'],
      prev: json['prev'],
      next: json['next'],
    );
  }
}

class Meta {
  final int currentPage;
  final int? from;
  final int lastPage;
  final List<Link> links;
  final String path;
  final int perPage;
  final int? to;
  final int total;

  Meta({
    required this.currentPage,
    this.from,
    required this.lastPage,
    required this.links,
    required this.path,
    required this.perPage,
    this.to,
    required this.total,
  });

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      currentPage: json['current_page'],
      from: json['from'],
      lastPage: json['last_page'],
      links: (json['links'] as List)
          .map((e) => Link.fromJson(e))
          .toList(),
      path: json['path'],
      perPage: json['per_page'],
      to: json['to'],
      total: json['total'],
    );
  }
}

class Course {
  final int id;
  final String title;

  Course({
    required this.id,
    required this.title,
  });

  factory Course.fromJson(Map<String, dynamic> json) => Course(
    id: json['id'],
    title: json['title'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
  };
}





