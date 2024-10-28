// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:objectbox/objectbox.dart';

part 'event.g.dart';

@Entity()
@JsonSerializable()
class EventResponse extends Equatable {
  @JsonKey(defaultValue: 0, includeIfNull: false)
  int? id;

  @Id(assignable: true)
  int? objId = 0;

  @JsonKey(name: "data", includeIfNull: false)
  @_EventRelToManyConverter()
  ToMany<Event> data;

  @JsonKey(name: "links", includeIfNull: false)
  @_LinksRelToOneConverter()
  ToOne<Links> links;

  @JsonKey(name: "meta", includeIfNull: false)
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
  @JsonKey(defaultValue: 0, includeIfNull: false)
  int? id;

  @Id(assignable: true)
  int? objId = 0;

  @JsonKey(name: "title", defaultValue: "", includeIfNull: false)
  String title;

  @JsonKey(name: "description", defaultValue: "", includeIfNull: false)
  String description;

  @JsonKey(name: "start_date", includeIfNull: false)
  @Property(type: PropertyType.dateNano)
  DateTime startDate;

  @JsonKey(name: "end_date", includeIfNull: false)
  @Property(type: PropertyType.dateNano)
  DateTime endDate;

  @JsonKey(name: "status", defaultValue: "", includeIfNull: false)
  String status;

  @JsonKey(name: "lifecycle_status", defaultValue: "", includeIfNull: false)
  String lifecycleStatus;

  @JsonKey(name: "currency", defaultValue: "", includeIfNull: false)
  String currency;

  @JsonKey(name: "timezone", defaultValue: "", includeIfNull: false)
  String timezone;

  @JsonKey(name: "slug", defaultValue: "", includeIfNull: false)
  String slug;

  @JsonKey(name: "images", includeIfNull: false)
  @_ImageRelToManyConverter()
  ToMany<EventImage> images;

  @JsonKey(name: "tickets", includeIfNull: false)
  @_TicketRelToManyConverter()
  ToMany<Ticket> tickets;

  @JsonKey(name: "settings", includeIfNull: false)
  @_SettingsRelToOneConverter()
  ToOne<Settings> settings;

  @JsonKey(name: "organizer", includeIfNull: false)
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
    required this.tickets,
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
  @JsonKey(defaultValue: 0, includeIfNull: false)
  int? id;

  @Id(assignable: true)
  int? objId = 0;

  @JsonKey(name: "url", defaultValue: "", includeIfNull: false)
  String url;

  @JsonKey(name: "size", defaultValue: 0, includeIfNull: false)
  int size;

  @JsonKey(name: "file_name", defaultValue: "", includeIfNull: false)
  String fileName;

  @JsonKey(name: "mime_type", defaultValue: "", includeIfNull: false)
  String mimeType;

  @JsonKey(name: "type", defaultValue: "", includeIfNull: false)
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
  @JsonKey(defaultValue: 0, includeIfNull: false)
  int? id;

  @Id(assignable: true)
  int? objId = 0;

  @JsonKey(name: "name", defaultValue: "", includeIfNull: false)
  String name;

  @JsonKey(name: "email", defaultValue: "", includeIfNull: false)
  String email;

  @JsonKey(name: "phone", defaultValue: "", includeIfNull: false)
  String? phone;

  @JsonKey(name: "website", defaultValue: "", includeIfNull: false)
  String? website;

  @JsonKey(name: "description", defaultValue: "", includeIfNull: false)
  String? description;

  @JsonKey(name: "timezone", defaultValue: "", includeIfNull: false)
  String timezone;

  @JsonKey(name: "currency", defaultValue: "", includeIfNull: false)
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
  @JsonKey(defaultValue: 0, includeIfNull: false)
  int? id;

  @Id(assignable: true)
  int? objId = 0;

  @JsonKey(name: "pre_checkout_message", defaultValue: "", includeIfNull: false)
  String? preCheckoutMessage;

  @JsonKey(
      name: "post_checkout_message", defaultValue: "", includeIfNull: false)
  String? postCheckoutMessage;

  @JsonKey(name: "ticket_page_message", defaultValue: "", includeIfNull: false)
  String? ticketPageMessage;

  @JsonKey(name: "continue_button_text", defaultValue: "", includeIfNull: false)
  String? continueButtonText;

  @JsonKey(
      name: "required_attendee_details",
      defaultValue: false,
      includeIfNull: false)
  bool requiredAttendeeDetails;

  @JsonKey(name: "email_footer_message", defaultValue: "", includeIfNull: false)
  String? emailFooterMessage;

  @JsonKey(name: "support_email", defaultValue: "", includeIfNull: false)
  String? supportEmail;

  @JsonKey(
      name: "order_timeout_in_minutes", defaultValue: 30, includeIfNull: false)
  int orderTimeoutInMinutes;

  @JsonKey(
      name: "homepage_body_background_color",
      defaultValue: "#FFFFFF",
      includeIfNull: false)
  String homepageBodyBackgroundColor;

  @JsonKey(
      name: "homepage_background_color",
      defaultValue: "#FFFFFF",
      includeIfNull: false)
  String homepageBackgroundColor;

  @JsonKey(
      name: "homepage_primary_color",
      defaultValue: "#000000",
      includeIfNull: false)
  String homepagePrimaryColor;

  @JsonKey(
      name: "homepage_primary_text_color",
      defaultValue: "#FFFFFF",
      includeIfNull: false)
  String homepagePrimaryTextColor;

  @JsonKey(
      name: "homepage_secondary_color",
      defaultValue: "#FFFFFF",
      includeIfNull: false)
  String homepageSecondaryColor;

  @JsonKey(
      name: "homepage_secondary_text_color",
      defaultValue: "#000000",
      includeIfNull: false)
  String homepageSecondaryTextColor;

  @JsonKey(
      name: "homepage_background_type",
      defaultValue: "color",
      includeIfNull: false)
  String homepageBackgroundType;

  @JsonKey(name: "website_url", defaultValue: "", includeIfNull: false)
  String? websiteUrl;

  @JsonKey(name: "maps_url", defaultValue: "", includeIfNull: false)
  String? mapsUrl;

  @JsonKey(name: "location_details", includeIfNull: false)
  @_LocationDetailsRelToOneConverter()
  ToOne<LocationDetails> locationDetails;

  @JsonKey(name: "is_online_event", defaultValue: false, includeIfNull: false)
  bool isOnlineEvent;

  @JsonKey(
      name: "online_event_connection_details",
      defaultValue: "",
      includeIfNull: false)
  String? onlineEventConnectionDetails;

  @JsonKey(name: "seo_title", defaultValue: "", includeIfNull: false)
  String? seoTitle;

  @JsonKey(name: "seo_description", defaultValue: "", includeIfNull: false)
  String? seoDescription;

  @JsonKey(name: "seo_keywords", defaultValue: "", includeIfNull: false)
  String? seoKeywords;

  @JsonKey(
      name: "allow_search_engine_indexing",
      defaultValue: true,
      includeIfNull: false)
  bool allowSearchEngineIndexing;

  @JsonKey(
      name: "notify_organizer_of_new_orders",
      defaultValue: false,
      includeIfNull: false)
  bool notifyOrganizerOfNewOrders;

  @JsonKey(
      name: "price_display_mode", defaultValue: "default", includeIfNull: false)
  String? priceDisplayMode;

  @JsonKey(
      name: "hide_getting_started_page",
      defaultValue: false,
      includeIfNull: false)
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
  @JsonKey(defaultValue: 0, includeIfNull: false)
  int? id;

  @Id(assignable: true)
  int? objId = 0;

  @JsonKey(name: "city", defaultValue: "", includeIfNull: false)
  String city;

  @JsonKey(name: "country", defaultValue: "", includeIfNull: false)
  String country;

  @JsonKey(name: "venue_name", defaultValue: "", includeIfNull: false)
  String venueName;

  @JsonKey(name: "address_line_1", defaultValue: "", includeIfNull: false)
  String addressLine1;

  @JsonKey(name: "address_line_2", defaultValue: "", includeIfNull: false)
  String? addressLine2;

  @JsonKey(name: "state_or_region", defaultValue: "", includeIfNull: false)
  String? stateOrRegion;

  @JsonKey(name: "zip_or_postal_code", defaultValue: "", includeIfNull: false)
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
  @JsonKey(defaultValue: 0, includeIfNull: false)
  int? id;

  @Id(assignable: true)
  int? objId = 0;

  @JsonKey(name: "first", defaultValue: "", includeIfNull: false)
  String first;

  @JsonKey(name: "last", defaultValue: "", includeIfNull: false)
  String last;

  @JsonKey(name: "prev", defaultValue: "", includeIfNull: false)
  String? prev;

  @JsonKey(name: "next", defaultValue: "", includeIfNull: false)
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
  @JsonKey(defaultValue: 0, includeIfNull: false)
  int? id;

  @Id(assignable: true)
  int? objId = 0;

  @JsonKey(name: "current_page", defaultValue: 1, includeIfNull: false)
  int currentPage;

  @JsonKey(name: "from", defaultValue: 0, includeIfNull: false)
  int from;

  @JsonKey(name: "last_page", defaultValue: 1, includeIfNull: false)
  int lastPage;

  @JsonKey(name: "links", includeIfNull: false)
  @_LinkRelToManyConverter()
  ToMany<Link> links;

  @JsonKey(name: "path", defaultValue: "", includeIfNull: false)
  String path;

  @JsonKey(name: "per_page", defaultValue: 10, includeIfNull: false)
  int perPage;

  @JsonKey(name: "to", defaultValue: 0, includeIfNull: false)
  int to;

  @JsonKey(name: "total", defaultValue: 0, includeIfNull: false)
  int total;

  @JsonKey(
      name: "allowed_filter_fields",
      defaultValue: <String>[],
      includeIfNull: false)
  List<String> allowedFilterFields;

  @JsonKey(name: "allowed_sorts", includeIfNull: false)
  @_AllowedSortsRelToOneConverter()
  ToOne<AllowedSorts> allowedSorts;

  @JsonKey(
      name: "default_sort", defaultValue: "created_at", includeIfNull: false)
  String defaultSort;

  @JsonKey(
      name: "default_sort_direction",
      defaultValue: "desc",
      includeIfNull: false)
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
  @JsonKey(defaultValue: 0, includeIfNull: false)
  int? id;

  @Id(assignable: true)
  int? objId = 0;

  @JsonKey(name: "start_date", includeIfNull: false)
  @_CreatedAtRelToOneConverter()
  ToOne<CreatedAt> startDate;

  @JsonKey(name: "end_date", includeIfNull: false)
  @_CreatedAtRelToOneConverter()
  ToOne<CreatedAt> endDate;

  @JsonKey(name: "created_at", includeIfNull: false)
  @_CreatedAtRelToOneConverter()
  ToOne<CreatedAt> createdAt;

  @JsonKey(name: "updated_at", includeIfNull: false)
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
  @JsonKey(defaultValue: 0, includeIfNull: false)
  int? id;

  @Id(assignable: true)
  int? objId = 0;

  @JsonKey(name: "asc", defaultValue: "asc", includeIfNull: false)
  String asc;

  @JsonKey(name: "desc", defaultValue: "desc", includeIfNull: false)
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
  @JsonKey(defaultValue: 0, includeIfNull: false)
  int? id;

  @Id(assignable: true)
  int? objId = 0;

  @JsonKey(name: "url", defaultValue: "", includeIfNull: false)
  String? url;

  @JsonKey(name: "label", defaultValue: "", includeIfNull: false)
  String label;

  @JsonKey(name: "active", defaultValue: false, includeIfNull: false)
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

@Entity()
@JsonSerializable()
class Ticket extends Equatable {
  @Id(assignable: true)
  int? objId = 0;

  @JsonKey(name: "id", defaultValue: 0, includeIfNull: false)
  int? id;

  @JsonKey(name: "title", defaultValue: "", includeIfNull: false)
  String? title;

  @JsonKey(name: "type", defaultValue: "", includeIfNull: false)
  String? type;

  @JsonKey(name: "description", defaultValue: "", includeIfNull: false)
  String? description;

  @JsonKey(name: "max_per_order", defaultValue: 10, includeIfNull: false)
  int? maxPerOrder;

  @JsonKey(name: "min_per_order", defaultValue: 1, includeIfNull: false)
  int? minPerOrder;

  @JsonKey(name: "sale_start_date", includeIfNull: false)
  @Property(type: PropertyType.dateNano)
  DateTime? saleStartDate;

  @JsonKey(name: "sale_end_date", includeIfNull: false)
  @Property(type: PropertyType.dateNano)
  DateTime? saleEndDate;

  @JsonKey(name: "event_id", defaultValue: 0, includeIfNull: false)
  int eventId;

  @JsonKey(
      name: "is_before_sale_start_date",
      defaultValue: false,
      includeIfNull: false)
  bool? isBeforeSaleStartDate;

  @JsonKey(
      name: "is_after_sale_end_date", defaultValue: false, includeIfNull: false)
  bool? isAfterSaleEndDate;

  @JsonKey(name: "quantity_available", defaultValue: 0, includeIfNull: false)
  int? quantityAvailable;

  @JsonKey(name: "price", defaultValue: 0.0, includeIfNull: false)
  double? price;

  @JsonKey(name: "prices", includeIfNull: false)
  @_TicketPriceRelToManyConverter()
  ToMany<TicketPrice> prices;

  @JsonKey(name: "is_available", defaultValue: false, includeIfNull: false)
  bool isAvailable;

  @JsonKey(name: "is_sold_out", defaultValue: false, includeIfNull: false)
  bool isSoldOut;

  Ticket({
    this.objId = 0,
    required this.id,
    required this.title,
    required this.type,
    required this.description,
    required this.maxPerOrder,
    required this.minPerOrder,
    required this.saleStartDate,
    required this.saleEndDate,
    required this.eventId,
    required this.isBeforeSaleStartDate,
    required this.isAfterSaleEndDate,
    required this.quantityAvailable,
    required this.price,
    required this.prices,
    required this.isAvailable,
    required this.isSoldOut,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) => _$TicketFromJson(json);

  Map<String, dynamic> toJson() => _$TicketToJson(this);

  @override
  List<Object?> get props => [
        objId,
        id,
        title,
        type,
        description,
        maxPerOrder,
        minPerOrder,
        saleStartDate,
        saleEndDate,
        eventId,
        isBeforeSaleStartDate,
        isAfterSaleEndDate,
        quantityAvailable,
        price,
        prices,
        isAvailable,
        isSoldOut,
      ];
}

@Entity()
@JsonSerializable()
class TicketPrice extends Equatable {
  @Id(assignable: true)
  int? objId = 0;

  @JsonKey(name: "id", includeIfNull: false, defaultValue: 0)
  int? id;

  @JsonKey(name: "label", includeIfNull: false, defaultValue: "")
  String? label;

  @JsonKey(name: "price", defaultValue: 0.0)
  double price;

  @JsonKey(name: "sale_start_date", includeIfNull: false)
  @Property(type: PropertyType.dateNano)
  DateTime? saleStartDate;

  @JsonKey(name: "sale_end_date", includeIfNull: false)
  @Property(type: PropertyType.dateNano)
  DateTime? saleEndDate;

  @JsonKey(
      name: "price_including_taxes_and_fees",
      includeIfNull: false,
      defaultValue: 0.0)
  double? priceIncludingTaxesAndFees;

  @JsonKey(
      name: "price_before_discount", includeIfNull: false, defaultValue: 0.0)
  double? priceBeforeDiscount;

  @JsonKey(name: "is_discounted", defaultValue: false)
  bool isDiscounted;

  @JsonKey(name: "tax_total", defaultValue: 0.0)
  double taxTotal;

  @JsonKey(name: "fee_total", defaultValue: 0.0)
  double feeTotal;

  @JsonKey(name: "is_before_sale_start_date", defaultValue: false)
  bool isBeforeSaleStartDate;

  @JsonKey(name: "is_after_sale_end_date", defaultValue: false)
  bool isAfterSaleEndDate;

  @JsonKey(name: "is_available", defaultValue: true)
  bool isAvailable;

  @JsonKey(name: "is_sold_out", defaultValue: false)
  bool isSoldOut;

  @JsonKey(name: "quantity_remaining", defaultValue: 0)
  int quantityRemaining;

  TicketPrice({
    this.objId = 0,
    required this.id,
    this.label,
    required this.price,
    this.saleStartDate,
    this.saleEndDate,
    required this.priceIncludingTaxesAndFees,
    this.priceBeforeDiscount,
    required this.isDiscounted,
    required this.taxTotal,
    required this.feeTotal,
    required this.isBeforeSaleStartDate,
    required this.isAfterSaleEndDate,
    required this.isAvailable,
    required this.isSoldOut,
    required this.quantityRemaining,
  });

  factory TicketPrice.fromJson(Map<String, dynamic> json) =>
      _$TicketPriceFromJson(json);

  Map<String, dynamic> toJson() => _$TicketPriceToJson(this);

  @override
  List<Object?> get props => [
        objId,
        id,
        label,
        price,
        saleStartDate,
        saleEndDate,
        priceIncludingTaxesAndFees,
        priceBeforeDiscount,
        isDiscounted,
        taxTotal,
        feeTotal,
        isBeforeSaleStartDate,
        isAfterSaleEndDate,
        isAvailable,
        isSoldOut,
        quantityRemaining,
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

class _TicketPriceRelToManyConverter
    implements JsonConverter<ToMany<TicketPrice>, List<dynamic>?> {
  const _TicketPriceRelToManyConverter();

  @override
  ToMany<TicketPrice> fromJson(List<dynamic>? json) => ToMany<TicketPrice>(
      items: json == null
          ? []
          : json.map((e) => TicketPrice.fromJson(e)).toList());

  @override
  List<Map<String, dynamic>>? toJson(ToMany<TicketPrice> rel) =>
      rel.map((TicketPrice obj) => obj.toJson()).toList();
}

class _TicketRelToManyConverter
    implements JsonConverter<ToMany<Ticket>, List<dynamic>?> {
  const _TicketRelToManyConverter();

  @override
  ToMany<Ticket> fromJson(List<dynamic>? json) => ToMany<Ticket>(
      items: json == null ? [] : json.map((e) => Ticket.fromJson(e)).toList());

  @override
  List<Map<String, dynamic>>? toJson(ToMany<Ticket> rel) =>
      rel.map((Ticket obj) => obj.toJson()).toList();
}
