// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:objectbox/objectbox.dart';

part 'event.g.dart';

@Entity()
@JsonSerializable()
class EventResponse extends Equatable {
  int? id;

  @JsonKey(includeFromJson: false, includeToJson: false, defaultValue: 0)
  @Id(assignable: true)
  int? objId;

  @JsonKey(name: "data")
  @_EventRelToManyConverter()
  ToMany<Event> data;

  @JsonKey(name: "links")
  @_LinksRelToOneConverter()
  ToOne<Links> links;

  @JsonKey(name: "meta")
  @_MetaRelToOneConverter()
  ToOne<Meta> meta;

  EventResponse({
    this.objId = 0,
    required this.id,
    required this.data,
    required this.links,
    required this.meta,
  });

  factory EventResponse.fromJson(Map<String, dynamic> json) =>
      _$EventResponseFromJson(json);

  Map<String, dynamic> toJson() => _$EventResponseToJson(this);

  @override
  List<Object?> get props => [objId, id, data, links, meta];
}

@Entity()
@JsonSerializable()
class Event extends Equatable {
  int? id;

  @JsonKey(includeFromJson: false, includeToJson: false, defaultValue: 0)
  @Id(assignable: true)
  int? objId;

  @JsonKey(name: "title")
  String title;

  @JsonKey(name: "description")
  String description;

  @JsonKey(name: "start_date")
  @Property(type: PropertyType.dateNano)
  DateTime startDate;

  @JsonKey(name: "end_date")
  @Property(type: PropertyType.dateNano)
  DateTime endDate;

  @JsonKey(name: "status")
  String status;

  @JsonKey(name: "lifecycle_status")
  String lifecycleStatus;

  @JsonKey(name: "currency")
  String currency;

  @JsonKey(name: "timezone")
  String timezone;

  @JsonKey(name: "slug")
  String slug;

  @JsonKey(name: "images")
  @_ImageRelToManyConverter()
  ToMany<EventImage> images;

  @JsonKey(name: "settings")
  @_SettingsRelToOneConverter()
  ToOne<Settings> settings;

  @JsonKey(name: "organizer")
  @_OrganizerRelToOneConverter()
  ToOne<Organizer> organizer;

  Event({
    this.objId = 0,
    required this.id,
    required this.title,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.lifecycleStatus,
    required this.currency,
    required this.timezone,
    required this.slug,
    required this.images,
    required this.settings,
    required this.organizer,
  });

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);

  Map<String, dynamic> toJson() => _$EventToJson(this);

  @override
  List<Object?> get props => [
        objId,
        id,
        title,
        description,
        startDate,
        endDate,
        status,
        lifecycleStatus,
        currency,
        timezone,
        slug,
        images,
        settings,
        organizer,
      ];
}

@Entity()
@JsonSerializable()
class EventImage extends Equatable {
  int? id;

  @JsonKey(includeFromJson: false, includeToJson: false, defaultValue: 0)
  @Id(assignable: true)
  int? objId;

  @JsonKey(name: "url")
  String url;

  @JsonKey(name: "size")
  int size;

  @JsonKey(name: "file_name")
  String fileName;

  @JsonKey(name: "mime_type")
  String mimeType;

  @JsonKey(name: "type")
  String type;

  EventImage({
    this.objId = 0,
    required this.id,
    required this.url,
    required this.size,
    required this.fileName,
    required this.mimeType,
    required this.type,
  });

  factory EventImage.fromJson(Map<String, dynamic> json) =>
      _$EventImageFromJson(json);

  Map<String, dynamic> toJson() => _$EventImageToJson(this);

  @override
  List<Object?> get props => [objId, id, url, size, fileName, mimeType, type];
}

@Entity()
@JsonSerializable()
class Organizer extends Equatable {
  int? id;

  @JsonKey(includeFromJson: false, includeToJson: false, defaultValue: 0)
  @Id(assignable: true)
  int? objId;

  @JsonKey(name: "name")
  String name;

  @JsonKey(name: "email")
  String email;

  @JsonKey(name: "phone")
  String? phone;

  @JsonKey(name: "website")
  String? website;

  @JsonKey(name: "description")
  String? description;

  @JsonKey(name: "timezone")
  String timezone;

  @JsonKey(name: "currency")
  String currency;

  Organizer({
    this.objId = 0,
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    this.website,
    this.description,
    required this.timezone,
    required this.currency,
  });

  factory Organizer.fromJson(Map<String, dynamic> json) =>
      _$OrganizerFromJson(json);

  Map<String, dynamic> toJson() => _$OrganizerToJson(this);

  @override
  List<Object?> get props => [
        objId,
        id,
        name,
        email,
        phone,
        website,
        description,
        timezone,
        currency,
      ];
}

@Entity()
@JsonSerializable()
class Settings extends Equatable {
  int? id;

  @JsonKey(includeFromJson: false, includeToJson: false, defaultValue: 0)
  @Id(assignable: true)
  int? objId;

  @JsonKey(name: "pre_checkout_message")
  String? preCheckoutMessage;

  @JsonKey(name: "post_checkout_message")
  String? postCheckoutMessage;

  @JsonKey(name: "ticket_page_message")
  String? ticketPageMessage;

  @JsonKey(name: "continue_button_text")
  String? continueButtonText;

  @JsonKey(name: "required_attendee_details")
  bool requiredAttendeeDetails;

  @JsonKey(name: "email_footer_message")
  String? emailFooterMessage;

  @JsonKey(name: "support_email")
  String? supportEmail;

  @JsonKey(name: "order_timeout_in_minutes")
  int orderTimeoutInMinutes;

  @JsonKey(name: "homepage_body_background_color")
  String homepageBodyBackgroundColor;

  @JsonKey(name: "homepage_background_color")
  String homepageBackgroundColor;

  @JsonKey(name: "homepage_primary_color")
  String homepagePrimaryColor;

  @JsonKey(name: "homepage_primary_text_color")
  String homepagePrimaryTextColor;

  @JsonKey(name: "homepage_secondary_color")
  String homepageSecondaryColor;

  @JsonKey(name: "homepage_secondary_text_color")
  String homepageSecondaryTextColor;

  @JsonKey(name: "homepage_background_type")
  String homepageBackgroundType;

  @JsonKey(name: "website_url")
  String? websiteUrl;

  @JsonKey(name: "maps_url")
  String? mapsUrl;

  @JsonKey(name: "location_details")
  @_LocationDetailsRelToOneConverter()
  ToOne<LocationDetails> locationDetails;

  @JsonKey(name: "is_online_event")
  bool isOnlineEvent;

  @JsonKey(name: "online_event_connection_details")
  String? onlineEventConnectionDetails;

  @JsonKey(name: "seo_title")
  String? seoTitle;

  @JsonKey(name: "seo_description")
  String? seoDescription;

  @JsonKey(name: "seo_keywords")
  String? seoKeywords;

  @JsonKey(name: "allow_search_engine_indexing")
  bool allowSearchEngineIndexing;

  @JsonKey(name: "notify_organizer_of_new_orders")
  bool notifyOrganizerOfNewOrders;

  @JsonKey(name: "price_display_mode")
  String? priceDisplayMode;

  @JsonKey(name: "hide_getting_started_page")
  bool hideGettingStartedPage;

  Settings({
    this.id,
    this.objId = 0,
    this.preCheckoutMessage,
    this.postCheckoutMessage,
    this.ticketPageMessage,
    this.continueButtonText,
    required this.requiredAttendeeDetails,
    this.emailFooterMessage,
    this.supportEmail,
    required this.orderTimeoutInMinutes,
    required this.homepageBodyBackgroundColor,
    required this.homepageBackgroundColor,
    required this.homepagePrimaryColor,
    required this.homepagePrimaryTextColor,
    required this.homepageSecondaryColor,
    required this.homepageSecondaryTextColor,
    required this.homepageBackgroundType,
    this.websiteUrl,
    this.mapsUrl,
    required this.locationDetails,
    required this.isOnlineEvent,
    this.onlineEventConnectionDetails,
    this.seoTitle,
    this.seoDescription,
    this.seoKeywords,
    required this.allowSearchEngineIndexing,
    required this.notifyOrganizerOfNewOrders,
    this.priceDisplayMode,
    required this.hideGettingStartedPage,
  });

  factory Settings.fromJson(Map<String, dynamic> json) =>
      _$SettingsFromJson(json);

  Map<String, dynamic> toJson() => _$SettingsToJson(this);

  @override
  List<Object?> get props => [
        id,
        objId,
        preCheckoutMessage,
        postCheckoutMessage,
        ticketPageMessage,
        continueButtonText,
        requiredAttendeeDetails,
        emailFooterMessage,
        supportEmail,
        orderTimeoutInMinutes,
        homepageBodyBackgroundColor,
        homepageBackgroundColor,
        homepagePrimaryColor,
        homepagePrimaryTextColor,
        homepageSecondaryColor,
        homepageSecondaryTextColor,
        homepageBackgroundType,
        websiteUrl,
        mapsUrl,
        locationDetails,
        isOnlineEvent,
        onlineEventConnectionDetails,
        seoTitle,
        seoDescription,
        seoKeywords,
        allowSearchEngineIndexing,
        notifyOrganizerOfNewOrders,
        priceDisplayMode,
        hideGettingStartedPage,
      ];
}

@Entity()
@JsonSerializable()
class LocationDetails extends Equatable {
  int? id;

  @JsonKey(includeFromJson: false, includeToJson: false, defaultValue: 0)
  @Id(assignable: true)
  int? objId;

  @JsonKey(name: "city")
  String city;

  @JsonKey(name: "country")
  String country;

  @JsonKey(name: "venue_name")
  String venueName;

  @JsonKey(name: "address_line_1")
  String addressLine1;

  @JsonKey(name: "address_line_2")
  String? addressLine2;

  @JsonKey(name: "state_or_region")
  String? stateOrRegion;

  @JsonKey(name: "zip_or_postal_code")
  String zipOrPostalCode;

  LocationDetails({
    this.objId = 0,
    required this.id,
    required this.city,
    required this.country,
    required this.venueName,
    required this.addressLine1,
    this.addressLine2,
    this.stateOrRegion,
    required this.zipOrPostalCode,
  });

  factory LocationDetails.fromJson(Map<String, dynamic> json) =>
      _$LocationDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$LocationDetailsToJson(this);

  @override
  List<Object?> get props => [
        objId,
        id,
        city,
        country,
        venueName,
        addressLine1,
        addressLine2,
        stateOrRegion,
        zipOrPostalCode,
      ];
}

@Entity()
@JsonSerializable()
class Links extends Equatable {
  int? id;

  @JsonKey(includeFromJson: false, includeToJson: false, defaultValue: 0)
  @Id(assignable: true)
  int? objId;

  @JsonKey(name: "first")
  String first;

  @JsonKey(name: "last")
  String last;

  @JsonKey(name: "prev")
  String? prev;

  @JsonKey(name: "next")
  String next;

  Links({
    this.objId = 0,
    required this.id,
    required this.first,
    required this.last,
    this.prev,
    required this.next,
  });

  factory Links.fromJson(Map<String, dynamic> json) => _$LinksFromJson(json);

  Map<String, dynamic> toJson() => _$LinksToJson(this);

  @override
  List<Object?> get props => [objId, id, first, last, prev, next];
}

@Entity()
@JsonSerializable()
class Meta extends Equatable {
  int? id;

  @JsonKey(includeFromJson: false, includeToJson: false, defaultValue: 0)
  @Id(assignable: true)
  int? objId;

  @JsonKey(name: "current_page")
  int currentPage;

  @JsonKey(name: "from")
  int from;

  @JsonKey(name: "last_page")
  int lastPage;

  @JsonKey(name: "links")
  @_LinkRelToManyConverter()
  ToMany<Link> links;

  @JsonKey(name: "path")
  String path;

  @JsonKey(name: "per_page")
  int perPage;

  @JsonKey(name: "to")
  int to;

  @JsonKey(name: "total")
  int total;

  @JsonKey(name: "allowed_filter_fields")
  List<String> allowedFilterFields;

  @JsonKey(name: "allowed_sorts")
  @_AllowedSortsRelToOneConverter()
  ToOne<AllowedSorts> allowedSorts;

  @JsonKey(name: "default_sort")
  String defaultSort;

  @JsonKey(name: "default_sort_direction")
  String defaultSortDirection;

  Meta({
    this.objId = 0,
    required this.id,
    required this.currentPage,
    required this.from,
    required this.lastPage,
    required this.links,
    required this.path,
    required this.perPage,
    required this.to,
    required this.total,
    required this.allowedFilterFields,
    required this.allowedSorts,
    required this.defaultSort,
    required this.defaultSortDirection,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => _$MetaFromJson(json);

  Map<String, dynamic> toJson() => _$MetaToJson(this);

  @override
  List<Object?> get props => [
        id,
        objId,
        currentPage,
        from,
        lastPage,
        links,
        path,
        perPage,
        to,
        total,
        allowedFilterFields,
        allowedSorts,
        defaultSort,
        defaultSortDirection,
      ];
}

@Entity()
@JsonSerializable()
class AllowedSorts extends Equatable {
  int? id;

  @JsonKey(includeFromJson: false, includeToJson: false, defaultValue: 0)
  @Id(assignable: true)
  int? objId;

  @JsonKey(name: "start_date")
  @_CreatedAtRelToOneConverter()
  ToOne<CreatedAt> startDate;

  @JsonKey(name: "end_date")
  @_CreatedAtRelToOneConverter()
  ToOne<CreatedAt> endDate;

  @JsonKey(name: "created_at")
  @_CreatedAtRelToOneConverter()
  ToOne<CreatedAt> createdAt;

  @JsonKey(name: "updated_at")
  @_CreatedAtRelToOneConverter()
  ToOne<CreatedAt> updatedAt;

  AllowedSorts({
    this.objId = 0,
    required this.id,
    required this.startDate,
    required this.endDate,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AllowedSorts.fromJson(Map<String, dynamic> json) =>
      _$AllowedSortsFromJson(json);

  Map<String, dynamic> toJson() => _$AllowedSortsToJson(this);

  @override
  List<Object?> get props => [
        id,
        objId,
        startDate,
        endDate,
        createdAt,
        updatedAt,
      ];
}

@Entity()
@JsonSerializable()
class CreatedAt extends Equatable {
  int? id;

  @JsonKey(includeFromJson: false, includeToJson: false, defaultValue: 0)
  @Id(assignable: true)
  int? objId;

  @JsonKey(name: "asc")
  String asc;

  @JsonKey(name: "desc")
  String desc;

  CreatedAt({
    required this.id,
    required this.asc,
    required this.desc,
    this.objId = 0,
  });

  factory CreatedAt.fromJson(Map<String, dynamic> json) =>
      _$CreatedAtFromJson(json);

  Map<String, dynamic> toJson() => _$CreatedAtToJson(this);

  @override
  List<Object?> get props => [
        id,
        objId,
        asc,
        desc,
      ];
}

@Entity()
@JsonSerializable()
class Link extends Equatable {
  int? id;

  @JsonKey(includeFromJson: false, includeToJson: false, defaultValue: 0)
  @Id(assignable: true)
  int? objId;

  @JsonKey(name: "url")
  String? url;

  @JsonKey(name: "label")
  String label;

  @JsonKey(name: "active")
  bool active;

  Link({
    required this.id,
    this.url,
    this.objId = 0,
    required this.label,
    required this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => _$LinkFromJson(json);

  Map<String, dynamic> toJson() => _$LinkToJson(this);

  @override
  List<Object?> get props => [
        id,
        objId,
        url,
        label,
        active,
      ];
}

// The converters remain the same
class _EventRelToManyConverter
    implements JsonConverter<ToMany<Event>, List<Map<String, dynamic>>?> {
  const _EventRelToManyConverter();

  @override
  ToMany<Event> fromJson(List<Map<String, dynamic>>? json) => ToMany<Event>(
      items: json == null ? [] : json.map((e) => Event.fromJson(e)).toList());

  @override
  List<Map<String, dynamic>>? toJson(ToMany<Event> rel) =>
      rel.map((Event obj) => obj.toJson()).toList();
}

class _ImageRelToManyConverter
    implements JsonConverter<ToMany<EventImage>, List<dynamic>?> {
  const _ImageRelToManyConverter();

  @override
  ToMany<EventImage> fromJson(List<dynamic>? json) => ToMany<EventImage>(
      items:
          json == null ? [] : json.map((e) => EventImage.fromJson(e)).toList());

  @override
  List<Map<String, dynamic>>? toJson(ToMany<EventImage> rel) =>
      rel.map((EventImage obj) => obj.toJson()).toList();
}

class _LinkRelToManyConverter
    implements JsonConverter<ToMany<Link>, List<Map<String, dynamic>>?> {
  const _LinkRelToManyConverter();

  @override
  ToMany<Link> fromJson(List<Map<String, dynamic>>? json) => ToMany<Link>(
      items: json == null ? [] : json.map((e) => Link.fromJson(e)).toList());

  @override
  List<Map<String, dynamic>>? toJson(ToMany<Link> rel) =>
      rel.map((Link obj) => obj.toJson()).toList();
}

class _LinksRelToOneConverter
    implements JsonConverter<ToOne<Links>, Map<String, dynamic>?> {
  const _LinksRelToOneConverter();

  @override
  ToOne<Links> fromJson(Map<String, dynamic>? json) =>
      ToOne<Links>(target: json == null ? null : Links.fromJson(json));

  @override
  Map<String, dynamic>? toJson(ToOne<Links> rel) => rel.target?.toJson();
}

class _MetaRelToOneConverter
    implements JsonConverter<ToOne<Meta>, Map<String, dynamic>?> {
  const _MetaRelToOneConverter();

  @override
  ToOne<Meta> fromJson(Map<String, dynamic>? json) =>
      ToOne<Meta>(target: json == null ? null : Meta.fromJson(json));

  @override
  Map<String, dynamic>? toJson(ToOne<Meta> rel) => rel.target?.toJson();
}

class _SettingsRelToOneConverter
    implements JsonConverter<ToOne<Settings>, Map<String, dynamic>?> {
  const _SettingsRelToOneConverter();

  @override
  ToOne<Settings> fromJson(Map<String, dynamic>? json) =>
      ToOne<Settings>(target: json == null ? null : Settings.fromJson(json));

  @override
  Map<String, dynamic>? toJson(ToOne<Settings> rel) => rel.target?.toJson();
}

class _OrganizerRelToOneConverter
    implements JsonConverter<ToOne<Organizer>, Map<String, dynamic>?> {
  const _OrganizerRelToOneConverter();

  @override
  ToOne<Organizer> fromJson(Map<String, dynamic>? json) =>
      ToOne<Organizer>(target: json == null ? null : Organizer.fromJson(json));

  @override
  Map<String, dynamic>? toJson(ToOne<Organizer> rel) => rel.target?.toJson();
}

class _LocationDetailsRelToOneConverter
    implements JsonConverter<ToOne<LocationDetails>, Map<String, dynamic>?> {
  const _LocationDetailsRelToOneConverter();

  @override
  ToOne<LocationDetails> fromJson(Map<String, dynamic>? json) =>
      ToOne<LocationDetails>(
          target: json == null ? null : LocationDetails.fromJson(json));

  @override
  Map<String, dynamic>? toJson(ToOne<LocationDetails> rel) =>
      rel.target?.toJson();
}

class _AllowedSortsRelToOneConverter
    implements JsonConverter<ToOne<AllowedSorts>, Map<String, dynamic>?> {
  const _AllowedSortsRelToOneConverter();

  @override
  ToOne<AllowedSorts> fromJson(Map<String, dynamic>? json) =>
      ToOne<AllowedSorts>(
          target: json == null ? null : AllowedSorts.fromJson(json));

  @override
  Map<String, dynamic>? toJson(ToOne<AllowedSorts> rel) => rel.target?.toJson();
}

class _CreatedAtRelToOneConverter
    implements JsonConverter<ToOne<CreatedAt>, Map<String, dynamic>?> {
  const _CreatedAtRelToOneConverter();

  @override
  ToOne<CreatedAt> fromJson(Map<String, dynamic>? json) =>
      ToOne<CreatedAt>(target: json == null ? null : CreatedAt.fromJson(json));

  @override
  Map<String, dynamic>? toJson(ToOne<CreatedAt> rel) => rel.target?.toJson();
}
