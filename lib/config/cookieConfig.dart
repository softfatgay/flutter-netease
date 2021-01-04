
class CookieConfig {
  // static var cookie = 'yx_stat_seqList=v_d830d99be9%7Cv_0141428c1b%3B-1%3Bv_c76637a2b6%3B-1%3Bv_283ebb6fb5%3B-1%3Bv_d830d99be9%3B-1; yx_userid=26223682442; yx_username=yd.aee4554d25ca414ab%40163.com; yx_sid=11d37bc9-b887-494a-9826-67d814d1bed8; YX_SUPPORT_WEBP=0; yx_s_device=b9ae8dd-7ed8-a78d-db40-2b9fc9b155; yx_s_tid=tid_web_9ebe630b5f604a3db243720ff364f1f1_82866a93b_1; yx_but_id=10a4a980acd04324acc548db5b631afd9ba092089d404bbd_v1_nl; mail_psc_fingerprint=e399a5330814d32fac16861bdafaf0f6; NTES_YD_SESS=Kku3jZBuAQ3dtKtkqGCTs4wUHEHuE.NHsI.k9DQA112cUGQvUZBPoCDQlTe73eecP1._wWAoSLR3hL2ZqkJojufOPV0x4HLbWHVt8jHTDmf6zaSiT2j0Wxpt3lMlahQwAKBvVatw1oVWvNTCBXsXqPJ_KGrxp17eeXXApw04NswfSmrbUkXqsx4sk69jStKrbBoH7F2gfTU4tjXdkD2t2UBSL91MH.Fktfteg6hE8SQRj; P_INFO=13262941389|1606792297|1|yanxuan_web|00&99|null&null&null#shh&null#10#0|&0|null|13262941389; S_INFO=1606792297|0|3&80##|13262941389; yx_csrf=a9329797fd4c517c001e50e0052ac3a2; yx_aui=33eb4320-02d2-4733-a2b2-7d209248a4e1; _ntes_nuid=7ee646da0cae8014df6cab4d0038326e';
  static var cookie = '';

  static String get token  {
    return cookieMap['yx_csrf'];
  }

  static String get P_INFO  {
    return cookieMap['P_INFO'];
  }

  static String get NTES_YD_SESS  {
    return cookieMap['NTES_YD_SESS'];
  }

  static Map<String, String> get cookieMap  {
    Map<String, String> map =  Map<String, String>();
    List<String> list = cookie.split('; ');
    for( var i = 0 ; i < list.length; i++ ) {
      final item = list[i];
      final kvPair = item.split('=');
      final name = kvPair.first;
      final value = kvPair.last;
      map[name] = value;
    }
    return map;
  }
}