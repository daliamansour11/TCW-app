class EventModel {

  factory EventModel.fromJson(Map<String, dynamic> json){
    return EventModel(
      currentPage: json['current_page'],
      data: json['data'] == null ? [] : List<EventItem>.from(json['data']!.map((x) => EventItem.fromJson(x))),
      firstPageUrl: json['first_page_url'],
      from: json['from'],
      lastPage: json['last_page'],
      lastPageUrl: json['last_page_url'],
      links: json['links'] == null ? [] : List<Link>.from(json['links']!.map((x) => Link.fromJson(x))),
      nextPageUrl: json['next_page_url'],
      path: json['path'],
      perPage: json['per_page'],
      prevPageUrl: json['prev_page_url'],
      to: json['to'],
      total: json['total'],
    );
  }
  EventModel({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.links,
    required this.nextPageUrl,
    required this.path,
    required this.perPage,
    required this.prevPageUrl,
    required this.to,
    required this.total,
  });

  final int? currentPage;
  final List<EventItem> data;
  final String? firstPageUrl;
  final int? from;
  final int? lastPage;
  final String? lastPageUrl;
  final List<Link> links;
  final dynamic nextPageUrl;
  final String? path;
  final int? perPage;
  final dynamic prevPageUrl;
  final int? to;
  final int? total;

}


class EventItem {
  final int? id;
  final String? title;
  final String? subTitle;
  final int? instructorId;
  final String? thumbUrl;
  final Instructor? instructor;

  EventItem({
    required this.id,
    required this.title,
    required this.subTitle,
    required this.instructorId,
    required this.thumbUrl,
    required this.instructor,
  });

  factory EventItem.fromJson(Map<String, dynamic> json) {
    return EventItem(
      id: json['id'],
      title: json['title'],
      subTitle: json['sub_title'],
      instructorId: json['instructor_id'],
      thumbUrl: json['thumb_url'],
      instructor: json['instructor'] != null
          ? Instructor.fromJson(json['instructor'])
          : null,
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
