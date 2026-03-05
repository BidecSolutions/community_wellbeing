import 'dart:ui';
import 'package:get/get.dart';

class CultureCommunityController extends GetxController {
  final List<Map<String, dynamic>> events = [
    {
      "type": "Seminar",
      "title": "Yami Sounz Summit",
      "date": "04 May.",
      "time": "14:00 - 15:00",
      "color": const Color.fromARGB(255, 252, 159, 190),
    },
    {
      "type": "Event",
      "title": "Matariki Celebrations",
      "date": "25 May.",
      "time": "14:00 - 15:00",
      "color": const Color.fromARGB(255, 177, 223, 243),
    },
    {
      "type": "Seminar",
      "title": "Yami Sounz Summit",
      "date": "8 May.",
      "time": "14:00 - 15:00",
      "color": const Color.fromARGB(255, 255, 233, 124),
    },
  ];
  final List<Map<String, dynamic>> thumbnails = [
    {
      'id': '1',
      'url':
          'https://avatars.mds.yandex.net/i?id=0cd93fd3eb0b2cedf8158d8d50be6fe185b85ad9-5673903-images-thumbs&n=13',
    },
    {
      'id': '2',
      'url':
          'https://assets.weforum.org/article/image/tjQZR3Y61W8xyuI806llgkE0-pNFwsWNWXYHktY12ds.jpg',
    },
    {
      'id': '3',
      'url':
          'https://avatars.mds.yandex.net/i?id=76c5593113660f4b638111c691da1eacbd2ec397-12314646-images-thumbs&n=13',
    },
    {
      'id': '4',
      'url':
          'https://m.media-amazon.com/images/G/31/amazonservices/Blog/12_Profitable_product_to_sell_online_Blog-05.jpg',
    },
  ];

  final List<String> videoIds = ['ElVw2WE1PR8', '5rhHm6WWOIs', 'xfOT2elC2Ok'];
}
