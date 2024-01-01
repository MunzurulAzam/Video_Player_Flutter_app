class PlayList {
  PlayList({
    this.links,
    this.total,
    this.page,
    this.pageSize,
    this.results,
  });

  PlayList.fromJson(dynamic json) {
    links = json['links'] != null ? Links.fromJson(json['links']) : null;
    total = json['total'];
    page = json['page'];
    pageSize = json['page_size'];
    if (json['results'] != null) {
      results = [];
      json['results'].forEach((v) {
        results?.add(Results.fromJson(v));
      });
    }
  }

  Links? links;
  num? total;
  num? page;
  num? pageSize;
  List<Results>? results;

  PlayList copyWith({
    Links? links,
    num? total,
    num? page,
    num? pageSize,
    List<Results>? results,
  }) =>
      PlayList(
        links: links ?? this.links,
        total: total ?? this.total,
        page: page ?? this.page,
        pageSize: pageSize ?? this.pageSize,
        results: results ?? this.results,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (links != null) {
      map['links'] = links?.toJson();
    }
    map['total'] = total;
    map['page'] = page;
    map['page_size'] = pageSize;
    if (results != null) {
      map['results'] = results?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Results {
  Results({
    this.thumbnail,
    this.id,
    this.title,
    this.dateAndTime,
    this.slug,
    this.createdAt,
    this.manifest,
    this.liveStatus,
    this.liveManifest,
    this.isLive,
    this.channelImage,
    this.channelName,
    this.channelUsername,
    this.isVerified,
    this.channelSlug,
    this.channelSubscriber,
    this.channelId,
    this.type,
    this.viewers,
    this.duration,
    this.objectType,
  });

  Results.fromJson(dynamic json) {
    thumbnail = json['thumbnail'];
    id = json['id'];
    title = json['title'];
    dateAndTime = json['date_and_time'];
    slug = json['slug'];
    createdAt = json['created_at'];
    manifest = json['manifest'];
    liveStatus = json['live_status'];
    liveManifest = json['live_manifest'];
    isLive = json['is_live'];
    channelImage = json['channel_image'];
    channelName = json['channel_name'];
    channelUsername = json['channel_username'];
    isVerified = json['is_verified'];
    channelSlug = json['channel_slug'];
    channelSubscriber = json['channel_subscriber'];
    channelId = json['channel_id'];
    type = json['type'];
    viewers = json['viewers'];
    duration = json['duration'];
    objectType = json['object_type'];
  }

  String? thumbnail;
  num? id;
  String? title;
  String? dateAndTime;
  String? slug;
  String? createdAt;
  String? manifest;
  num? liveStatus;
  dynamic liveManifest;
  bool? isLive;
  String? channelImage;
  String? channelName;
  dynamic channelUsername;
  bool? isVerified;
  String? channelSlug;
  String? channelSubscriber;
  num? channelId;
  String? type;
  String? viewers;
  String? duration;
  String? objectType;

  Results copyWith({
    String? thumbnail,
    num? id,
    String? title,
    String? dateAndTime,
    String? slug,
    String? createdAt,
    String? manifest,
    num? liveStatus,
    dynamic liveManifest,
    bool? isLive,
    String? channelImage,
    String? channelName,
    dynamic channelUsername,
    bool? isVerified,
    String? channelSlug,
    String? channelSubscriber,
    num? channelId,
    String? type,
    String? viewers,
    String? duration,
    String? objectType,
  }) =>
      Results(
        thumbnail: thumbnail ?? this.thumbnail,
        id: id ?? this.id,
        title: title ?? this.title,
        dateAndTime: dateAndTime ?? this.dateAndTime,
        slug: slug ?? this.slug,
        createdAt: createdAt ?? this.createdAt,
        manifest: manifest ?? this.manifest,
        liveStatus: liveStatus ?? this.liveStatus,
        liveManifest: liveManifest ?? this.liveManifest,
        isLive: isLive ?? this.isLive,
        channelImage: channelImage ?? this.channelImage,
        channelName: channelName ?? this.channelName,
        channelUsername: channelUsername ?? this.channelUsername,
        isVerified: isVerified ?? this.isVerified,
        channelSlug: channelSlug ?? this.channelSlug,
        channelSubscriber: channelSubscriber ?? this.channelSubscriber,
        channelId: channelId ?? this.channelId,
        type: type ?? this.type,
        viewers: viewers ?? this.viewers,
        duration: duration ?? this.duration,
        objectType: objectType ?? this.objectType,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['thumbnail'] = thumbnail;
    map['id'] = id;
    map['title'] = title;
    map['date_and_time'] = dateAndTime;
    map['slug'] = slug;
    map['created_at'] = createdAt;
    map['manifest'] = manifest;
    map['live_status'] = liveStatus;
    map['live_manifest'] = liveManifest;
    map['is_live'] = isLive;
    map['channel_image'] = channelImage;
    map['channel_name'] = channelName;
    map['channel_username'] = channelUsername;
    map['is_verified'] = isVerified;
    map['channel_slug'] = channelSlug;
    map['channel_subscriber'] = channelSubscriber;
    map['channel_id'] = channelId;
    map['type'] = type;
    map['viewers'] = viewers;
    map['duration'] = duration;
    map['object_type'] = objectType;
    return map;
  }
}

class Links {
  Links({
    this.next,
    this.previous,
  });

  Links.fromJson(dynamic json) {
    next = json['next'];
    previous = json['previous'];
  }

  dynamic next;
  dynamic previous;

  Links copyWith({
    dynamic next,
    dynamic previous,
  }) =>
      Links(
        next: next ?? this.next,
        previous: previous ?? this.previous,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['next'] = next;
    map['previous'] = previous;
    return map;
  }
}
