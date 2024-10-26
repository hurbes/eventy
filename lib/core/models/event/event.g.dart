// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventResponse _$EventResponseFromJson(Map<String, dynamic> json) =>
    EventResponse(
      id: (json['id'] as num?)?.toInt(),
      data: const _EventRelToManyConverter()
          .fromJson(json['data'] as List<Map<String, dynamic>>?),
      links: const _LinksRelToOneConverter()
          .fromJson(json['links'] as Map<String, dynamic>?),
      meta: const _MetaRelToOneConverter()
          .fromJson(json['meta'] as Map<String, dynamic>?),
    );

Map<String, dynamic> _$EventResponseToJson(EventResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'data': const _EventRelToManyConverter().toJson(instance.data),
      'links': const _LinksRelToOneConverter().toJson(instance.links),
      'meta': const _MetaRelToOneConverter().toJson(instance.meta),
    };

Event _$EventFromJson(Map<String, dynamic> json) => Event(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String,
      description: json['description'] as String,
      startDate: DateTime.parse(json['start_date'] as String),
      endDate: DateTime.parse(json['end_date'] as String),
      status: json['status'] as String,
      lifecycleStatus: json['lifecycle_status'] as String,
      currency: json['currency'] as String,
      timezone: json['timezone'] as String,
      slug: json['slug'] as String,
      images:
          const _ImageRelToManyConverter().fromJson(json['images'] as List?),
      settings: const _SettingsRelToOneConverter()
          .fromJson(json['settings'] as Map<String, dynamic>?),
      organizer: const _OrganizerRelToOneConverter()
          .fromJson(json['organizer'] as Map<String, dynamic>?),
    );

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'start_date': instance.startDate.toIso8601String(),
      'end_date': instance.endDate.toIso8601String(),
      'status': instance.status,
      'lifecycle_status': instance.lifecycleStatus,
      'currency': instance.currency,
      'timezone': instance.timezone,
      'slug': instance.slug,
      'images': const _ImageRelToManyConverter().toJson(instance.images),
      'settings': const _SettingsRelToOneConverter().toJson(instance.settings),
      'organizer':
          const _OrganizerRelToOneConverter().toJson(instance.organizer),
    };

EventImage _$EventImageFromJson(Map<String, dynamic> json) => EventImage(
      id: (json['id'] as num?)?.toInt(),
      url: json['url'] as String,
      size: (json['size'] as num).toInt(),
      fileName: json['file_name'] as String,
      mimeType: json['mime_type'] as String,
      type: json['type'] as String,
    );

Map<String, dynamic> _$EventImageToJson(EventImage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'size': instance.size,
      'file_name': instance.fileName,
      'mime_type': instance.mimeType,
      'type': instance.type,
    };

Organizer _$OrganizerFromJson(Map<String, dynamic> json) => Organizer(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String?,
      website: json['website'] as String?,
      description: json['description'] as String?,
      timezone: json['timezone'] as String,
      currency: json['currency'] as String,
    );

Map<String, dynamic> _$OrganizerToJson(Organizer instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'website': instance.website,
      'description': instance.description,
      'timezone': instance.timezone,
      'currency': instance.currency,
    };

Settings _$SettingsFromJson(Map<String, dynamic> json) => Settings(
      id: (json['id'] as num?)?.toInt(),
      preCheckoutMessage: json['pre_checkout_message'] as String?,
      postCheckoutMessage: json['post_checkout_message'] as String?,
      ticketPageMessage: json['ticket_page_message'] as String?,
      continueButtonText: json['continue_button_text'] as String?,
      requiredAttendeeDetails: json['required_attendee_details'] as bool,
      emailFooterMessage: json['email_footer_message'] as String?,
      supportEmail: json['support_email'] as String?,
      orderTimeoutInMinutes: (json['order_timeout_in_minutes'] as num).toInt(),
      homepageBodyBackgroundColor:
          json['homepage_body_background_color'] as String,
      homepageBackgroundColor: json['homepage_background_color'] as String,
      homepagePrimaryColor: json['homepage_primary_color'] as String,
      homepagePrimaryTextColor: json['homepage_primary_text_color'] as String,
      homepageSecondaryColor: json['homepage_secondary_color'] as String,
      homepageSecondaryTextColor:
          json['homepage_secondary_text_color'] as String,
      homepageBackgroundType: json['homepage_background_type'] as String,
      websiteUrl: json['website_url'] as String?,
      mapsUrl: json['maps_url'] as String?,
      locationDetails: const _LocationDetailsRelToOneConverter()
          .fromJson(json['location_details'] as Map<String, dynamic>?),
      isOnlineEvent: json['is_online_event'] as bool,
      onlineEventConnectionDetails:
          json['online_event_connection_details'] as String?,
      seoTitle: json['seo_title'] as String?,
      seoDescription: json['seo_description'] as String?,
      seoKeywords: json['seo_keywords'] as String?,
      allowSearchEngineIndexing: json['allow_search_engine_indexing'] as bool,
      notifyOrganizerOfNewOrders:
          json['notify_organizer_of_new_orders'] as bool,
      priceDisplayMode: json['price_display_mode'] as String?,
      hideGettingStartedPage: json['hide_getting_started_page'] as bool,
    );

Map<String, dynamic> _$SettingsToJson(Settings instance) => <String, dynamic>{
      'id': instance.id,
      'pre_checkout_message': instance.preCheckoutMessage,
      'post_checkout_message': instance.postCheckoutMessage,
      'ticket_page_message': instance.ticketPageMessage,
      'continue_button_text': instance.continueButtonText,
      'required_attendee_details': instance.requiredAttendeeDetails,
      'email_footer_message': instance.emailFooterMessage,
      'support_email': instance.supportEmail,
      'order_timeout_in_minutes': instance.orderTimeoutInMinutes,
      'homepage_body_background_color': instance.homepageBodyBackgroundColor,
      'homepage_background_color': instance.homepageBackgroundColor,
      'homepage_primary_color': instance.homepagePrimaryColor,
      'homepage_primary_text_color': instance.homepagePrimaryTextColor,
      'homepage_secondary_color': instance.homepageSecondaryColor,
      'homepage_secondary_text_color': instance.homepageSecondaryTextColor,
      'homepage_background_type': instance.homepageBackgroundType,
      'website_url': instance.websiteUrl,
      'maps_url': instance.mapsUrl,
      'location_details': const _LocationDetailsRelToOneConverter()
          .toJson(instance.locationDetails),
      'is_online_event': instance.isOnlineEvent,
      'online_event_connection_details': instance.onlineEventConnectionDetails,
      'seo_title': instance.seoTitle,
      'seo_description': instance.seoDescription,
      'seo_keywords': instance.seoKeywords,
      'allow_search_engine_indexing': instance.allowSearchEngineIndexing,
      'notify_organizer_of_new_orders': instance.notifyOrganizerOfNewOrders,
      'price_display_mode': instance.priceDisplayMode,
      'hide_getting_started_page': instance.hideGettingStartedPage,
    };

LocationDetails _$LocationDetailsFromJson(Map<String, dynamic> json) =>
    LocationDetails(
      id: (json['id'] as num?)?.toInt(),
      city: json['city'] as String,
      country: json['country'] as String,
      venueName: json['venue_name'] as String,
      addressLine1: json['address_line_1'] as String,
      addressLine2: json['address_line_2'] as String?,
      stateOrRegion: json['state_or_region'] as String?,
      zipOrPostalCode: json['zip_or_postal_code'] as String,
    );

Map<String, dynamic> _$LocationDetailsToJson(LocationDetails instance) =>
    <String, dynamic>{
      'id': instance.id,
      'city': instance.city,
      'country': instance.country,
      'venue_name': instance.venueName,
      'address_line_1': instance.addressLine1,
      'address_line_2': instance.addressLine2,
      'state_or_region': instance.stateOrRegion,
      'zip_or_postal_code': instance.zipOrPostalCode,
    };

Links _$LinksFromJson(Map<String, dynamic> json) => Links(
      id: (json['id'] as num?)?.toInt(),
      first: json['first'] as String,
      last: json['last'] as String,
      prev: json['prev'] as String?,
      next: json['next'] as String,
    );

Map<String, dynamic> _$LinksToJson(Links instance) => <String, dynamic>{
      'id': instance.id,
      'first': instance.first,
      'last': instance.last,
      'prev': instance.prev,
      'next': instance.next,
    };

Meta _$MetaFromJson(Map<String, dynamic> json) => Meta(
      id: (json['id'] as num?)?.toInt(),
      currentPage: (json['current_page'] as num).toInt(),
      from: (json['from'] as num).toInt(),
      lastPage: (json['last_page'] as num).toInt(),
      links: const _LinkRelToManyConverter()
          .fromJson(json['links'] as List<Map<String, dynamic>>?),
      path: json['path'] as String,
      perPage: (json['per_page'] as num).toInt(),
      to: (json['to'] as num).toInt(),
      total: (json['total'] as num).toInt(),
      allowedFilterFields: (json['allowed_filter_fields'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      allowedSorts: const _AllowedSortsRelToOneConverter()
          .fromJson(json['allowed_sorts'] as Map<String, dynamic>?),
      defaultSort: json['default_sort'] as String,
      defaultSortDirection: json['default_sort_direction'] as String,
    );

Map<String, dynamic> _$MetaToJson(Meta instance) => <String, dynamic>{
      'id': instance.id,
      'current_page': instance.currentPage,
      'from': instance.from,
      'last_page': instance.lastPage,
      'links': const _LinkRelToManyConverter().toJson(instance.links),
      'path': instance.path,
      'per_page': instance.perPage,
      'to': instance.to,
      'total': instance.total,
      'allowed_filter_fields': instance.allowedFilterFields,
      'allowed_sorts':
          const _AllowedSortsRelToOneConverter().toJson(instance.allowedSorts),
      'default_sort': instance.defaultSort,
      'default_sort_direction': instance.defaultSortDirection,
    };

AllowedSorts _$AllowedSortsFromJson(Map<String, dynamic> json) => AllowedSorts(
      id: (json['id'] as num?)?.toInt(),
      startDate: const _CreatedAtRelToOneConverter()
          .fromJson(json['start_date'] as Map<String, dynamic>?),
      endDate: const _CreatedAtRelToOneConverter()
          .fromJson(json['end_date'] as Map<String, dynamic>?),
      createdAt: const _CreatedAtRelToOneConverter()
          .fromJson(json['created_at'] as Map<String, dynamic>?),
      updatedAt: const _CreatedAtRelToOneConverter()
          .fromJson(json['updated_at'] as Map<String, dynamic>?),
    );

Map<String, dynamic> _$AllowedSortsToJson(AllowedSorts instance) =>
    <String, dynamic>{
      'id': instance.id,
      'start_date':
          const _CreatedAtRelToOneConverter().toJson(instance.startDate),
      'end_date': const _CreatedAtRelToOneConverter().toJson(instance.endDate),
      'created_at':
          const _CreatedAtRelToOneConverter().toJson(instance.createdAt),
      'updated_at':
          const _CreatedAtRelToOneConverter().toJson(instance.updatedAt),
    };

CreatedAt _$CreatedAtFromJson(Map<String, dynamic> json) => CreatedAt(
      id: (json['id'] as num?)?.toInt(),
      asc: json['asc'] as String,
      desc: json['desc'] as String,
    );

Map<String, dynamic> _$CreatedAtToJson(CreatedAt instance) => <String, dynamic>{
      'id': instance.id,
      'asc': instance.asc,
      'desc': instance.desc,
    };

Link _$LinkFromJson(Map<String, dynamic> json) => Link(
      id: (json['id'] as num?)?.toInt(),
      url: json['url'] as String?,
      label: json['label'] as String,
      active: json['active'] as bool,
    );

Map<String, dynamic> _$LinkToJson(Link instance) => <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'label': instance.label,
      'active': instance.active,
    };
