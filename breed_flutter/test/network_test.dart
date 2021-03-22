import 'package:test/test.dart';
import 'package:http/http.dart' as http;

void main() {
  test('test dog ceo API', () async {
    var url = Uri.parse('https://dog.ceo/api/breeds/list/all');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
  });
}
