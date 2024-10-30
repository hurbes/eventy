// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventResponse _$EventResponseFromJson(Map<String, dynamic> json) =>
    EventResponse(
      objId: (json['objId'] as num?)?.toInt() ?? 0,
      id: (json['id'] as num?)?.toInt() ?? 0,
      data: const _EventRelToManyConverter()
          .fromJson(json['data'] as List<Map<String, dynamic>>?),
      links: const _LinksRelToOneConverter()
          .fromJson(json['links'] as Map<String, dynamic>?),
      meta: const _MetaRelToOneConverter()
          .fromJson(json['meta'] as Map<String, dynamic>?),
    );

Map<String, dynamic> _$EventResponseToJson(EventResponse instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  val['objId'] = instance.objId;
  writeNotNull('data', const _EventRelToManyConverter().toJson(instance.data));
  writeNotNull('links', const _LinksRelToOneConverter().toJson(instance.links));
  writeNotNull('meta', const _MetaRelToOneConverter().toJson(instance.meta));
  return val;
}

Event _$EventFromJson(Map<String, dynamic> json) => Event(
      objId: (json['objId'] as num?)?.toInt() ?? 0,
      id: (json['id'] as num?)?.toInt() ?? 0,
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      startDate: DateTime.parse(json['start_date'] as String),
      endDate: DateTime.parse(json['end_date'] as String),
      status: json['status'] as String? ?? '',
      lifecycleStatus: json['lifecycle_status'] as String? ?? '',
      currency: json['currency'] as String? ?? '',
      timezone: json['timezone'] as String? ?? '',
      slug: json['slug'] as String? ?? '',
      images: const _ImageRelToManyConverter().fromJson(json['images'] as List),
      settings: const _SettingsRelToOneConverter()
          .fromJson(json['settings'] as Map<String, dynamic>?),
      organizer: const _OrganizerRelToOneConverter()
          .fromJson(json['organizer'] as Map<String, dynamic>?),
      tickets:
          const _TicketRelToManyConverter().fromJson(json['tickets'] as List?),
    );

Map<String, dynamic> _$EventToJson(Event instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  val['objId'] = instance.objId;
  val['title'] = instance.title;
  val['description'] = instance.description;
  val['start_date'] = instance.startDate.toIso8601String();
  val['end_date'] = instance.endDate.toIso8601String();
  val['status'] = instance.status;
  val['lifecycle_status'] = instance.lifecycleStatus;
  val['currency'] = instance.currency;
  val['timezone'] = instance.timezone;
  val['slug'] = instance.slug;
  val['images'] = const _ImageRelToManyConverter().toJson(instance.images);
  writeNotNull(
      'tickets', const _TicketRelToManyConverter().toJson(instance.tickets));
  writeNotNull(
      'settings', const _SettingsRelToOneConverter().toJson(instance.settings));
  writeNotNull('organizer',
      const _OrganizerRelToOneConverter().toJson(instance.organizer));
  return val;
}

EventImage _$EventImageFromJson(Map<String, dynamic> json) => EventImage(
      objId: (json['objId'] as num?)?.toInt() ?? 0,
      id: (json['id'] as num?)?.toInt() ?? 0,
      url: json['url'] as String? ?? '',
      size: (json['size'] as num?)?.toInt() ?? 0,
      fileName: json['file_name'] as String? ?? '',
      mimeType: json['mime_type'] as String? ?? '',
      type: json['type'] as String? ?? '',
    );

Map<String, dynamic> _$EventImageToJson(EventImage instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  val['objId'] = instance.objId;
  val['url'] = instance.url;
  val['size'] = instance.size;
  val['file_name'] = instance.fileName;
  val['mime_type'] = instance.mimeType;
  val['type'] = instance.type;
  return val;
}

Organizer _$OrganizerFromJson(Map<String, dynamic> json) => Organizer(
      objId: (json['objId'] as num?)?.toInt() ?? 0,
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name'] as String? ?? '',
      email: json['email'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      website: json['website'] as String? ?? '',
      description: json['description'] as String? ?? '',
      timezone: json['timezone'] as String? ?? '',
      currency: json['currency'] as String? ?? '',
    );

Map<String, dynamic> _$OrganizerToJson(Organizer instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  val['objId'] = instance.objId;
  val['name'] = instance.name;
  val['email'] = instance.email;
  writeNotNull('phone', instance.phone);
  writeNotNull('website', instance.website);
  writeNotNull('description', instance.description);
  val['timezone'] = instance.timezone;
  val['currency'] = instance.currency;
  return val;
}

Settings _$SettingsFromJson(Map<String, dynamic> json) => Settings(
      id: (json['id'] as num?)?.toInt() ?? 0,
      objId: (json['objId'] as num?)?.toInt() ?? 0,
      preCheckoutMessage: json['pre_checkout_message'] as String? ?? '',
      postCheckoutMessage: json['post_checkout_message'] as String? ?? '',
      ticketPageMessage: json['ticket_page_message'] as String? ?? '',
      continueButtonText: json['continue_button_text'] as String? ?? '',
      requiredAttendeeDetails:
          json['required_attendee_details'] as bool? ?? false,
      emailFooterMessage: json['email_footer_message'] as String? ?? '',
      supportEmail: json['support_email'] as String? ?? '',
      orderTimeoutInMinutes:
          (json['order_timeout_in_minutes'] as num?)?.toInt() ?? 30,
      homepageBodyBackgroundColor:
          json['homepage_body_background_color'] as String? ?? '#FFFFFF',
      homepageBackgroundColor:
          json['homepage_background_color'] as String? ?? '#FFFFFF',
      homepagePrimaryColor:
          json['homepage_primary_color'] as String? ?? '#000000',
      homepagePrimaryTextColor:
          json['homepage_primary_text_color'] as String? ?? '#FFFFFF',
      homepageSecondaryColor:
          json['homepage_secondary_color'] as String? ?? '#FFFFFF',
      homepageSecondaryTextColor:
          json['homepage_secondary_text_color'] as String? ?? '#000000',
      homepageBackgroundType:
          json['homepage_background_type'] as String? ?? 'color',
      websiteUrl: json['website_url'] as String? ?? '',
      mapsUrl: json['maps_url'] as String? ?? '',
      locationDetails: const _LocationDetailsRelToOneConverter()
          .fromJson(json['location_details'] as Map<String, dynamic>?),
      isOnlineEvent: json['is_online_event'] as bool? ?? false,
      onlineEventConnectionDetails:
          json['online_event_connection_details'] as String? ?? '',
      seoTitle: json['seo_title'] as String? ?? '',
      seoDescription: json['seo_description'] as String? ?? '',
      seoKeywords: json['seo_keywords'] as String? ?? '',
      allowSearchEngineIndexing:
          json['allow_search_engine_indexing'] as bool? ?? true,
      notifyOrganizerOfNewOrders:
          json['notify_organizer_of_new_orders'] as bool? ?? false,
      priceDisplayMode: json['price_display_mode'] as String? ?? 'default',
      hideGettingStartedPage:
          json['hide_getting_started_page'] as bool? ?? false,
    );

Map<String, dynamic> _$SettingsToJson(Settings instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  val['objId'] = instance.objId;
  writeNotNull('pre_checkout_message', instance.preCheckoutMessage);
  writeNotNull('post_checkout_message', instance.postCheckoutMessage);
  writeNotNull('ticket_page_message', instance.ticketPageMessage);
  writeNotNull('continue_button_text', instance.continueButtonText);
  val['required_attendee_details'] = instance.requiredAttendeeDetails;
  writeNotNull('email_footer_message', instance.emailFooterMessage);
  writeNotNull('support_email', instance.supportEmail);
  val['order_timeout_in_minutes'] = instance.orderTimeoutInMinutes;
  val['homepage_body_background_color'] = instance.homepageBodyBackgroundColor;
  val['homepage_background_color'] = instance.homepageBackgroundColor;
  val['homepage_primary_color'] = instance.homepagePrimaryColor;
  val['homepage_primary_text_color'] = instance.homepagePrimaryTextColor;
  val['homepage_secondary_color'] = instance.homepageSecondaryColor;
  val['homepage_secondary_text_color'] = instance.homepageSecondaryTextColor;
  val['homepage_background_type'] = instance.homepageBackgroundType;
  writeNotNull('website_url', instance.websiteUrl);
  writeNotNull('maps_url', instance.mapsUrl);
  writeNotNull(
      'location_details',
      const _LocationDetailsRelToOneConverter()
          .toJson(instance.locationDetails));
  val['is_online_event'] = instance.isOnlineEvent;
  writeNotNull(
      'online_event_connection_details', instance.onlineEventConnectionDetails);
  writeNotNull('seo_title', instance.seoTitle);
  writeNotNull('seo_description', instance.seoDescription);
  writeNotNull('seo_keywords', instance.seoKeywords);
  val['allow_search_engine_indexing'] = instance.allowSearchEngineIndexing;
  val['notify_organizer_of_new_orders'] = instance.notifyOrganizerOfNewOrders;
  writeNotNull('price_display_mode', instance.priceDisplayMode);
  val['hide_getting_started_page'] = instance.hideGettingStartedPage;
  return val;
}

LocationDetails _$LocationDetailsFromJson(Map<String, dynamic> json) =>
    LocationDetails(
      objId: (json['objId'] as num?)?.toInt() ?? 0,
      id: (json['id'] as num?)?.toInt() ?? 0,
      city: json['city'] as String? ?? '',
      country: json['country'] as String? ?? '',
      venueName: json['venue_name'] as String? ?? '',
      addressLine1: json['address_line_1'] as String? ?? '',
      addressLine2: json['address_line_2'] as String? ?? '',
      stateOrRegion: json['state_or_region'] as String? ?? '',
      zipOrPostalCode: json['zip_or_postal_code'] as String? ?? '',
    );

Map<String, dynamic> _$LocationDetailsToJson(LocationDetails instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  val['objId'] = instance.objId;
  val['city'] = instance.city;
  val['country'] = instance.country;
  val['venue_name'] = instance.venueName;
  val['address_line_1'] = instance.addressLine1;
  writeNotNull('address_line_2', instance.addressLine2);
  writeNotNull('state_or_region', instance.stateOrRegion);
  val['zip_or_postal_code'] = instance.zipOrPostalCode;
  return val;
}

Links _$LinksFromJson(Map<String, dynamic> json) => Links(
      objId: (json['objId'] as num?)?.toInt() ?? 0,
      id: (json['id'] as num?)?.toInt() ?? 0,
      first: json['first'] as String? ?? '',
      last: json['last'] as String? ?? '',
      prev: json['prev'] as String? ?? '',
      next: json['next'] as String? ?? '',
    );

Map<String, dynamic> _$LinksToJson(Links instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  val['objId'] = instance.objId;
  val['first'] = instance.first;
  val['last'] = instance.last;
  writeNotNull('prev', instance.prev);
  val['next'] = instance.next;
  return val;
}

Meta _$MetaFromJson(Map<String, dynamic> json) => Meta(
      objId: (json['objId'] as num?)?.toInt() ?? 0,
      id: (json['id'] as num?)?.toInt() ?? 0,
      currentPage: (json['current_page'] as num?)?.toInt() ?? 1,
      from: (json['from'] as num?)?.toInt() ?? 0,
      lastPage: (json['last_page'] as num?)?.toInt() ?? 1,
      links: const _LinkRelToManyConverter()
          .fromJson(json['links'] as List<Map<String, dynamic>>?),
      path: json['path'] as String? ?? '',
      perPage: (json['per_page'] as num?)?.toInt() ?? 10,
      to: (json['to'] as num?)?.toInt() ?? 0,
      total: (json['total'] as num?)?.toInt() ?? 0,
      allowedFilterFields: (json['allowed_filter_fields'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      allowedSorts: const _AllowedSortsRelToOneConverter()
          .fromJson(json['allowed_sorts'] as Map<String, dynamic>?),
      defaultSort: json['default_sort'] as String? ?? 'created_at',
      defaultSortDirection: json['default_sort_direction'] as String? ?? 'desc',
    );

Map<String, dynamic> _$MetaToJson(Meta instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  val['objId'] = instance.objId;
  val['current_page'] = instance.currentPage;
  val['from'] = instance.from;
  val['last_page'] = instance.lastPage;
  writeNotNull('links', const _LinkRelToManyConverter().toJson(instance.links));
  val['path'] = instance.path;
  val['per_page'] = instance.perPage;
  val['to'] = instance.to;
  val['total'] = instance.total;
  val['allowed_filter_fields'] = instance.allowedFilterFields;
  writeNotNull('allowed_sorts',
      const _AllowedSortsRelToOneConverter().toJson(instance.allowedSorts));
  val['default_sort'] = instance.defaultSort;
  val['default_sort_direction'] = instance.defaultSortDirection;
  return val;
}

AllowedSorts _$AllowedSortsFromJson(Map<String, dynamic> json) => AllowedSorts(
      objId: (json['objId'] as num?)?.toInt() ?? 0,
      id: (json['id'] as num?)?.toInt() ?? 0,
      startDate: const _CreatedAtRelToOneConverter()
          .fromJson(json['start_date'] as Map<String, dynamic>?),
      endDate: const _CreatedAtRelToOneConverter()
          .fromJson(json['end_date'] as Map<String, dynamic>?),
      createdAt: const _CreatedAtRelToOneConverter()
          .fromJson(json['created_at'] as Map<String, dynamic>?),
      updatedAt: const _CreatedAtRelToOneConverter()
          .fromJson(json['updated_at'] as Map<String, dynamic>?),
    );

Map<String, dynamic> _$AllowedSortsToJson(AllowedSorts instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  val['objId'] = instance.objId;
  writeNotNull('start_date',
      const _CreatedAtRelToOneConverter().toJson(instance.startDate));
  writeNotNull(
      'end_date', const _CreatedAtRelToOneConverter().toJson(instance.endDate));
  writeNotNull('created_at',
      const _CreatedAtRelToOneConverter().toJson(instance.createdAt));
  writeNotNull('updated_at',
      const _CreatedAtRelToOneConverter().toJson(instance.updatedAt));
  return val;
}

CreatedAt _$CreatedAtFromJson(Map<String, dynamic> json) => CreatedAt(
      id: (json['id'] as num?)?.toInt() ?? 0,
      asc: json['asc'] as String? ?? 'asc',
      desc: json['desc'] as String? ?? 'desc',
      objId: (json['objId'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$CreatedAtToJson(CreatedAt instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  val['objId'] = instance.objId;
  val['asc'] = instance.asc;
  val['desc'] = instance.desc;
  return val;
}

Link _$LinkFromJson(Map<String, dynamic> json) => Link(
      id: (json['id'] as num?)?.toInt() ?? 0,
      url: json['url'] as String? ?? '',
      objId: (json['objId'] as num?)?.toInt() ?? 0,
      label: json['label'] as String? ?? '',
      active: json['active'] as bool? ?? false,
    );

Map<String, dynamic> _$LinkToJson(Link instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  val['objId'] = instance.objId;
  writeNotNull('url', instance.url);
  val['label'] = instance.label;
  val['active'] = instance.active;
  return val;
}

Ticket _$TicketFromJson(Map<String, dynamic> json) => Ticket(
      objId: (json['objId'] as num?)?.toInt() ?? 0,
      id: (json['id'] as num?)?.toInt() ?? 0,
      title: json['title'] as String? ?? '',
      type: json['type'] as String? ?? '',
      description: json['description'] as String? ?? '',
      maxPerOrder: (json['max_per_order'] as num?)?.toInt() ?? 10,
      minPerOrder: (json['min_per_order'] as num?)?.toInt() ?? 1,
      saleStartDate: json['sale_start_date'] == null
          ? null
          : DateTime.parse(json['sale_start_date'] as String),
      saleEndDate: json['sale_end_date'] == null
          ? null
          : DateTime.parse(json['sale_end_date'] as String),
      eventId: (json['event_id'] as num?)?.toInt() ?? 0,
      isBeforeSaleStartDate:
          json['is_before_sale_start_date'] as bool? ?? false,
      isAfterSaleEndDate: json['is_after_sale_end_date'] as bool? ?? false,
      quantityAvailable: (json['quantity_available'] as num?)?.toInt() ?? 0,
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      prices: const _TicketPriceRelToManyConverter()
          .fromJson(json['prices'] as List?),
      isAvailable: json['is_available'] as bool? ?? false,
      isSoldOut: json['is_sold_out'] as bool? ?? false,
    );

Map<String, dynamic> _$TicketToJson(Ticket instance) {
  final val = <String, dynamic>{
    'objId': instance.objId,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('title', instance.title);
  writeNotNull('type', instance.type);
  writeNotNull('description', instance.description);
  writeNotNull('max_per_order', instance.maxPerOrder);
  writeNotNull('min_per_order', instance.minPerOrder);
  writeNotNull('sale_start_date', instance.saleStartDate?.toIso8601String());
  writeNotNull('sale_end_date', instance.saleEndDate?.toIso8601String());
  val['event_id'] = instance.eventId;
  writeNotNull('is_before_sale_start_date', instance.isBeforeSaleStartDate);
  writeNotNull('is_after_sale_end_date', instance.isAfterSaleEndDate);
  writeNotNull('quantity_available', instance.quantityAvailable);
  writeNotNull('price', instance.price);
  writeNotNull(
      'prices', const _TicketPriceRelToManyConverter().toJson(instance.prices));
  val['is_available'] = instance.isAvailable;
  val['is_sold_out'] = instance.isSoldOut;
  return val;
}

TicketPrice _$TicketPriceFromJson(Map<String, dynamic> json) => TicketPrice(
      objId: (json['objId'] as num?)?.toInt() ?? 0,
      id: (json['id'] as num?)?.toInt() ?? 0,
      label: json['label'] as String? ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      saleStartDate: json['sale_start_date'] == null
          ? null
          : DateTime.parse(json['sale_start_date'] as String),
      saleEndDate: json['sale_end_date'] == null
          ? null
          : DateTime.parse(json['sale_end_date'] as String),
      priceIncludingTaxesAndFees:
          (json['price_including_taxes_and_fees'] as num?)?.toDouble() ?? 0.0,
      priceBeforeDiscount:
          (json['price_before_discount'] as num?)?.toDouble() ?? 0.0,
      isDiscounted: json['is_discounted'] as bool? ?? false,
      taxTotal: (json['tax_total'] as num?)?.toDouble() ?? 0.0,
      feeTotal: (json['fee_total'] as num?)?.toDouble() ?? 0.0,
      isBeforeSaleStartDate:
          json['is_before_sale_start_date'] as bool? ?? false,
      isAfterSaleEndDate: json['is_after_sale_end_date'] as bool? ?? false,
      isAvailable: json['is_available'] as bool? ?? true,
      isSoldOut: json['is_sold_out'] as bool? ?? false,
      quantityRemaining: (json['quantity_remaining'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$TicketPriceToJson(TicketPrice instance) {
  final val = <String, dynamic>{
    'objId': instance.objId,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('label', instance.label);
  val['price'] = instance.price;
  writeNotNull('sale_start_date', instance.saleStartDate?.toIso8601String());
  writeNotNull('sale_end_date', instance.saleEndDate?.toIso8601String());
  writeNotNull(
      'price_including_taxes_and_fees', instance.priceIncludingTaxesAndFees);
  writeNotNull('price_before_discount', instance.priceBeforeDiscount);
  val['is_discounted'] = instance.isDiscounted;
  val['tax_total'] = instance.taxTotal;
  val['fee_total'] = instance.feeTotal;
  val['is_before_sale_start_date'] = instance.isBeforeSaleStartDate;
  val['is_after_sale_end_date'] = instance.isAfterSaleEndDate;
  val['is_available'] = instance.isAvailable;
  val['is_sold_out'] = instance.isSoldOut;
  val['quantity_remaining'] = instance.quantityRemaining;
  return val;
}
