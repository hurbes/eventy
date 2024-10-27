enum DataSource { local, api }

enum DataStatus { loading, success, error }

class DataState<T> {
  final DataStatus status;
  final T? data;
  final String? errorMessage;
  final DataSource dataSource;
  final bool isLocalLoading;
  final bool isApiLoading;
  final PaginatedOption? pagination; // Added pagination info

  DataState._({
    required this.status,
    this.data,
    this.errorMessage,
    required this.dataSource,
    this.isLocalLoading = false,
    this.isApiLoading = false,
    this.pagination,
  });

  factory DataState.localLoading() => DataState._(
        status: DataStatus.loading,
        dataSource: DataSource.local,
        isLocalLoading: true,
      );

  factory DataState.apiLoading({T? data}) => DataState._(
        status: DataStatus.loading,
        dataSource: DataSource.api,
        isApiLoading: true,
        data: data,
      );

  factory DataState.success(T data, DataSource source,
          {PaginatedOption? pagination}) =>
      DataState._(
        status: DataStatus.success,
        data: data,
        dataSource: source,
        pagination: pagination,
      );

  factory DataState.error(String message, DataSource source, [T? data]) =>
      DataState._(
        status: DataStatus.error,
        errorMessage: message,
        dataSource: source,
        data: data,
      );
}

class PaginatedOption {
  final bool isEnabled;
  final int page;
  // ignore: non_constant_identifier_names
  final int perPage;
  final int totalPages;
  final int totalItems;

  const PaginatedOption({
    this.isEnabled = false,
    this.page = 1,
    this.perPage = 5,
    this.totalItems = 0,
    this.totalPages = 0,
  });

  PaginatedOption copyWith({
    bool? isEnabled,
    int? page,
    int? perPage,
    int? totalPages,
    int? totalItems,
  }) {
    return PaginatedOption(
      isEnabled: isEnabled ?? this.isEnabled,
      page: page ?? this.page,
      perPage: perPage ?? this.page,
      totalItems: totalItems ?? this.totalItems,
      totalPages: totalPages ?? this.totalPages,
    );
  }
}

class PaginatedData<T> {
  final List<T> items;
  final PaginatedOption pagination;

  const PaginatedData({
    required this.items,
    required this.pagination,
  });

  PaginatedData copyWith({List<T>? items, PaginatedOption? pagination}) {
    return PaginatedData(
      items: items ?? this.items,
      pagination: pagination ?? this.pagination,
    );
  }
}

class PersonalDetails {
  String? firstName;
  String? lastName;
  String? email;

  PersonalDetails({
    this.firstName,
    this.lastName,
    this.email,
  });

  bool get isValid {
    return firstName?.isNotEmpty == true &&
        lastName?.isNotEmpty == true &&
        isValidEmail(email ?? '');
  }

  Map<String, String> toMap() {
    return {
      'firstName': firstName ?? '',
      'lastName': lastName ?? '',
      'email': email ?? '',
    };
  }

  static bool isValidEmail(String email) {
    final emailRegExp = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
    return emailRegExp.hasMatch(email);
  }
}
