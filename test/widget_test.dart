import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:myportofolio_mobile/models/experience.dart';
import 'package:myportofolio_mobile/services/api_client.dart';

const _sample = {
  'id': '11111111-1111-1111-1111-111111111111',
  'title': 'Backend Intern',
  'description': 'Built APIs',
  'category': 'internship',
  'category_display': 'Internship',
  'thumbnail': null,
  'started_at': '2026-01-01T00:00:00Z',
  'ended_at': null,
  'is_ongoing': true,
  'star_count': 2,
};

void main() {
  test('Experience.fromJson maps snake_case keys and null thumbnail', () {
    final e = Experience.fromJson(_sample);
    expect(e.title, 'Backend Intern');
    expect(e.categoryDisplay, 'Internship');
    expect(e.thumbnail, '');
    expect(e.isOngoing, isTrue);
    expect(e.starCount, 2);
  });

  test('Experience.toJson omits server-generated fields', () {
    final json = Experience.fromJson(_sample).toJson();
    expect(json.containsKey('id'), isFalse);
    expect(json.containsKey('started_at'), isFalse);
    expect(json['title'], 'Backend Intern');
  });

  test('ApiClient.getExperiences parses the list response', () async {
    final client = MockClient((request) async {
      expect(request.url.path, '/api/v1/experiences/');
      return http.Response(
        jsonEncode([_sample]),
        200,
        headers: {'content-type': 'application/json'},
      );
    });
    final api = ApiClient(client: client, baseUrl: 'http://test');
    final result = await api.getExperiences();
    expect(result, hasLength(1));
    expect(result.first.title, 'Backend Intern');
  });

  test('ApiClient throws ApiException on non-2xx', () async {
    final client = MockClient((_) async => http.Response('nope', 401));
    final api = ApiClient(client: client, baseUrl: 'http://test');
    expect(
      () => api.obtainToken('a', 'b'),
      throwsA(isA<ApiException>()),
    );
  });
}