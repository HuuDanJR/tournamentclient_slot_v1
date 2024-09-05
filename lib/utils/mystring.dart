import 'package:flutter/foundation.dart';

class MyString {
  static const int DEFAULTNUMBER = 111111;
  static const String DEFAULT_USERNAME = 'admin';
  static const String DEFAULTP_PASS = 'vegas123456';

  static const String APP_NAME = "TNM SLOT V1";

  static const String ADRESS_SERVER = "localhost";
  // static const String ADRESS_SERVER = "10.20.10.36";
  // static const String ADRESS_SERVER = "192.168.101.58";
  static const String BASE = 'http://$ADRESS_SERVER:8096/api/';
  static const String BASEURL = 'http://$ADRESS_SERVER:8096/';
  static const String API_KEY = '';

  static const String list_ranking = '${BASE}list_ranking';
  static const String list_ranking_data = '${BASE}list_ranking_data';
  static const String export_round = '${BASE}export_round';
  static const String export_round_realtime = '${BASE}export_round_realtime';
  static String downloadround(name) {
    String url = '${BASE}download_excel/$name';
    debugPrint(url);
    return url;
  }

  static const String list_round = '${BASE}list_round';
  static const String list_round_realtime =
      '${BASE}list_ranking_realtime_group';
  static const String create_round = '${BASE}create_round';
  static const String create_round_realtime = '${BASE}save_list_station';
  static const String create_round_input = '${BASE}create_round_input';
  static const String create_ranking = '${BASE}add_ranking';
  static const String update_ranking = '${BASE}update_ranking';
  static const String update_ranking_by_id = '${BASE}update_ranking_id';
  static const String delete_ranking = '${BASE}delete_ranking';
  static String delete_ranking_byid(id) {
    final url = '${BASE}delete_ranking_id/$id';
    debugPrint('delete_ranking_byid url : $url');
    return url;
  }

  static const String delete_ranking_all_and_add =
      '${BASE}delete_ranking_all_create_default';

  static const String list_station = '${BASE}list_station';
  static const String update_member_station = '${BASE}update_member';
  static const String create_station = '${BASE}create_station';
  static const String delete_station = '${BASE}delete_station';
  static const String update_station_status = '${BASE}update_station';
  static const String add_ranking_realtime = '${BASE}add_ranking_realtime';
  //DEFAULT PADDING IN SETTING
  static const double TOP_PADDING_TOPRAKINGREALTIME = 18.0;

  //DISPLAY
  static String update_display(id) {
    return '${BASE}update_display/$id';
  }

  //DISPLAY REALTOP
  static String update_display_realtop(id) {
    return '${BASE}update_display_realtop/$id';
  }

  //DISPLAY
  static String list_display = '${BASE}list_display';

  static String list_data_station = '${BASE}find_data';
  //LOGIN
  static String login = '${BASE}login';

  //default column in settting server
  static const String DEFAULT_COLUMN = '9';

  static const double DEFAULT_HEIGHT_LINE = kIsWeb ? 50.5 : 36.5;
  // static const double DEFAULT_HEIGHT_LINE = kIsWeb ? 36.5 : 36.5;
  static const double DEFAULT_ROW = 10;
  static const double DEFAULT_SPACING_LING = kIsWeb ? 34.5 : 18.5;
  // static const double DEFAULT_SPACING_LING = kIsWeb ? 34 : 18.5;
  static const double DEFAULT_OFFSETX = 4.25;
  static const double DEFAULT_OFFSETX_TEXT = 2.25;
  static const double DEFAULT_OFFSETX_TITLE = 2.25;
  static const double DEFAULT_TEXTSIZE = 24.0;
  static const double DEFAULT_TEXTSIZE_WEB = 43.5;
  static const double DEFAULT_TEXTSIZE_DRAWLINE = 13.0;
  static const double DEFAULT_TEXTSIZE_DRAWLINE_WEB = 18.0;

  // static const double DEFAULT_HEIGHT_LINE = kIsWeb ? 48 : 48;
  // static const double DEFAULT_ROW = 10;
  // static const double DEFAULT_SPACING_LING = kIsWeb ? 34 : 34;
  // static const double DEFAULT_OFFSETX = 5;
  // static const double DEFAULT_OFFSETX_TEXT = 3.5;
  // static const double DEFAULT_OFFSETX_TITLE = 3.5;

  static const double padding08 = 08.0;
  static const double padding16 = 16.0;
  static const double padding12 = 12.0;
  static const double padding14 = 14.0;
  static const double padding20 = 20.0;
  static const double padding24 = 24.0;
  static const double padding18 = 18.0;
  static const double padding36 = 36.0;
  static const double padding42 = 42.0;
  static const double padding56 = 56.0;
  static const String fontFamily = 'Poppins';
  //22 line spacing
  //44
}
