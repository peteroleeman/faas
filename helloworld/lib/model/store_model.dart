

import 'package:firedart/firedart.dart';
import 'package:helloworld/constant.dart';
import 'package:helloworld/model/bell_model.dart';
import 'package:helloworld/model/cashout_model.dart';
import 'package:helloworld/model/kds_status_model.dart';
//import 'package:helloworld/model/store_filter_model.dart';
import 'package:helloworld/util_datetime.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const kStoreModelId = 'id';
const kStoreModelGatewayId = "gatewayid";
const kStoreModelCompanyId = "companyid";
const kStoreModelCompanyGatewayId = "companygatewayid";
const kStoreModelImg = "img";
const kStoreModelLogo = "logo";
const kStoreModelTitle = "title";
const kStoreModelSmallTitle = "smalltitle";
const kStoreModelAddress = "address";
const kStoreModelBusinessHour = "businesshour";
const kStoreModelSmallAddress = "smalladdress";
const kStoreModelCountry = "country";
const kStoreModelRating = "rating";
const kStoreModelCat = "cat";
const kStoreModelSmallCat = "smallcat";
const KStoreModeIsOpen = "isopen";
const kStoreModelShowLogo = "showlogo";
const kStoreModelIsStartQ = "isstartq";
const kStoreModelStartQDateTime = "startqdatetime";
const kStoreModelTimeStep = "timestep";
const kStoreModelTimeSlots = "timeslots";
const kStoreModelCounter = "storecounter";
const kStoreModelFilter = "filter";
const kStoreModelInitial = "initial";
const kStoreModelMode = "mode";
const kStoreModelIsDebug = "isdebug";
const kStoreModelPassword = "password";
const kStoreModelCurrency = "currency";
const kStoreModelQuickOrder = "quickorder";
const kStoreModelHasStudentDelivery = "hasstudentdelivery";
const kStoreModelHasKDS = "haskds";
const kStoreModelHasSignage = "hassignage";
const kStoreModelHasQManager = "hasqmanager";
const kStoreModelHasQSignage = "hasqsignage";
const kStoreModelHasFC = "hasfc"; //food collection
const kStoreModelKDSShowPrice = "kdsshowprice";
const kStoreModelOpenDate = "opendate";
const kStoreModelOpenTime = "opentime";
const kStoreModelCloseDate = "closedate";
const kStoreModelCloseTime = "closetime";

//payment type
const kStoreModelHasIPay = "hasipay";
const kStoreModelHasRazerPay = "hasrazerpay";
const kStoreModelHasCash = "hascash";
const kStoreModelCashButtons = "cashbuttons";
const kStoreModelHasPayAtCounter = "haspayatcounter";

//QManager related
const kStoreModelQCounter = "qcounter";

//landing related
const kStoreModelLanding_Active = "landing_active";
const kStoreModelLanding_ContactUS = "landing_contactus";
const kStoreModelLanding_Facebook = "landing_facebook";
const kStoreModelLanding_Instagram = "landing_instagram";
const kStoreModelLanding_FooterBackColor = "landing_footerbackcolor";
const kStoreModelLanding_FooterTextColor = "landing_footertextcolor";
const kStoreModelLanding_SupportContact = "landing_supportcontact";
const kStoreModelLanding_SupportEmail = "landing_supportemail";
const kStoreModelLanding_BannerMessage = "landing_bannermessage";
const kStoreModelLanding_BannerImage = "landing_bannerimage";
const kStoreModelLanding_StoreBrief = "landing_storebrief";
const kStoreModelLanding_HighlightImage = "landing_highlightimage";
const kStoreModelLanding_MapLat = "landing_maplat";
const kStoreModelLanding_MapLng = "landing_maplng";
const kStoreModelLanding_CatHighlight = "landing_cathighlight";
const kStoreModelLanding_IsCatHighlight = "landing_iscathighlight";

//advance setting
const kStoreModelAdvanceSetting_Enable = "advancesetting_enable";

//multi kds setting
const kStoreModelTerminalId = "terminalid";

//bell setting
const kStoreModelBells = "bells";
const kStoreModelHasBell = "hasbell";

//store filter
const kStoreModelStoreFilters = "storefilters";

//gst, sst service charge
const kStoreModelServiceCharge = "servicecharge";
const kStoreModelTax = "tax";
const kStoreModelTaxType = "taxtype"; //0: inclusive 1: exclusive
const kStoreModelIsTaxEnabled = "istaxenabled";
const kStoreModelIsServiceChargeEnabled = "isservicechargeenabled";
const kStoreModelIsRoundingForCashOnly = "isroundingforcashonly";

//open float
const kStoreModelOpenFloat = "openfloat";
//audit cash
const kStoreModelAuditCash = "auditcash";
//audit cash drawer button
const kStoreModelAuditButtons = "auditbuttons";
//one page related
const kStoreModelOnePageCounter = "onepagecounter";
//cash out summary
const kStoreModelCashOutHistory = "cashouthistory";
//receipt related
const kStoreModelReceiptHeaderText = "receiptheadertext";
const kStoreModelReceiptFooterText = "receiptfootertext";
//theme related
const kStoreModelThemeSelected = "themeselected";

//banner
const kStoreModelLanding_BannerBackColor = "landing_bannerbackcolor";
const kStoreModelLanding_BannerTextColor = "landing_bannertextcolor";
//kds with collector
const kStoreModelIsKDSWithCollector = "iskdswithcollector";

//watsapp key
const kStoreModelWatsappKey = "watsappkey";

//esl
const kStoreModelMerchantKey = "eslmerchantkey";
const kStoreModelMerchantId = "eslmerchantid";

//store initial
const kStoreModelCounterInitial = "storecounterinitial";

//ipay
const kStoreModelIPayMerchantId = "ipaymerchantid";
const kStoreModelIPayMerchantKey = "ipaymerchantkey";

//arkmind setting
const kStoreModelEnable_ArkMind = "arkmind_enable";

class StoreModel {
  String id;
  String gatewayId;
  String companyId;
  String companyGatewayId;
  String img;
  String logo;
  String title;
  String smallTitle;
  String address;
  String smallAddress;
  String businessHour;
  String country;
  String rating;
  final String cat;
  final String smallCat;
  bool isOpen;
  bool isStartQ;
  bool showLogo;
  String startQDateTime;
  int timeStep;
  String timeSlots;
  int storeCounter;
  String filter;
  String initial;
  int mode;
  String isDebug;
  String password;
  //QManager related
  int qCounter;
  String currency;
  bool quickOrder;

  String hasStudentDelivery;
  String hasKDS;
  String hasSignage;
  String hasQManager;
  String hasQSignage;
  String hasFC;
  bool kdsShowPrice;

  //payment type
  String hasIPay;
  String hasRazerPay;
  String hasCash;
  String hasPayAtCounter;
  String cashButtons;

  String openDate;
  String openTime;
  String closeDate;
  String closeTime;

  //landing related
  bool landingIsActive;
  String landingContactUS;
  String landingFacebook;
  String landingInstagram;
  String landingFooterBackColor;
  String landingFooterTextColor;
  String landingSupportContact;
  String landingSupportEmail;
  String landingBannerMessage;
  String landingBannerImage;
  String landingStoreBrief;
  String landingHighlightImage;
  double landingMapLat;
  double landingMapLng;
  String landingCatHighlight;
  bool islandingCatHighlight;

  //advance setting
  bool enableAdvanceSetting;

  //bell setting
  bool hasBell;
  List<dynamic> bells = [];

  //multi kds setting
  String terminalId;
 // List<dynamic> filterList = [];

  //gst sst service charge
  double serviceCharge;
  double tax;
  int taxType;
  bool isTaxEnabled;
  bool isServiceChargeEnabled;
  bool isRoundingForCashOnly;

  //open float
  double openFloat;
  //audit cash
  double auditCash;
  //audit button
  String auditButtons;

  int onePageCounter;

  //cash out history
  List<dynamic> cashOutHistoryList = [];
  //receipt
  String receiptHeaderText;
  String receiptFooterText;

  //theme
  String themeSelected;
  //banner
  String landingBannerBackColor;
  String landingBannerTextColor;
  //iskdswithcollector
  bool isKDSWithCollector;

  //watsapp key
  String watsappKey;

  //esl
  String merchantKey;
  String merchantId;

  //store counter initial
  String storeCounterInitial;

  //ipay
  String iPayMerchantId;
  String iPayMerchantKey;

  //arkmind enable
  bool enableArkMind;

  StoreModel({
    required this.id,
    required this.gatewayId,
    required this.companyId,
    required  this.companyGatewayId,
    required  this.img,
    required  this.logo,
    required  this.title,
    required  this.smallTitle,
    required  this.address,
    required  this.smallAddress,
    required  this.country,
    required  this.businessHour,
    required  this.rating,
    required  this.cat,
    required  this.smallCat,
    required  this.isOpen,
    required  this.isStartQ,
    required  this.showLogo,
    required  this.startQDateTime,
    required  this.timeStep,
    required  this.timeSlots,
    required this.storeCounter,
    required this.filter,
    required  this.initial,
    required  this.mode,
    required  this.password,
    //QManager related
    required  this.qCounter,
    required  this.currency,
    required this.isDebug,
    required  this.quickOrder,
    required  this.hasStudentDelivery,
    required this.hasKDS,
    required  this.hasSignage,
    required  this.hasQManager,
    required   this.hasQSignage,
    required  this.hasFC,
    required  this.kdsShowPrice,
    //payment type
    required  this.hasIPay,
    required this.hasRazerPay,
    required this.hasCash,
    required this.hasPayAtCounter,
    required this.cashButtons,
    required this.openDate,
    required this.openTime,
    required this.closeDate,
    required this.closeTime,

    //landing page
    required this.landingIsActive,
    required this.landingContactUS,
    required this.landingFacebook,
    required this.landingInstagram,
    required this.landingFooterBackColor,
    required this.landingFooterTextColor,
    required this.landingSupportContact,
    required this.landingSupportEmail,
    required this.landingBannerMessage,
    required  this.landingBannerImage,
    required this.landingStoreBrief,
    required this.landingHighlightImage,
    required this.landingMapLat,
    required this.landingMapLng,
    required this.landingCatHighlight,
    required this.islandingCatHighlight,
    required this.enableAdvanceSetting,

    //bell setting
    required  this.hasBell,
    required  this.bells,

    //multi kds setting
    required  this.terminalId,
    //this.filterList,

    //gst sst service charge
    required this.serviceCharge,
    required this.tax,
    required this.taxType,
    required this.isTaxEnabled,
    required this.isServiceChargeEnabled,
    required this.isRoundingForCashOnly,

    //open float
    required  this.openFloat,
    //audit cash
    required this.auditCash,
    //audit cash drawer button
    required  this.auditButtons,
    required this.onePageCounter,

    //cash out history
    required this.cashOutHistoryList,
    //receipt related
    required this.receiptHeaderText,
    required this.receiptFooterText,

    //theme related
    required  this.themeSelected,
    //banner
    required this.landingBannerTextColor,
    required  this.landingBannerBackColor,

    //kds with collector
    required  this.isKDSWithCollector,

    //watsapp key
    required this.watsappKey,

    //else
    required this.merchantKey,
    required this.merchantId,

    //store counter initial
    required  this.storeCounterInitial,
    //ipay
    required  this.iPayMerchantKey,
    required  this.iPayMerchantId,

    //enable arkmind
    required this.enableArkMind,
  });

  void openStore() {
    isOpen = true;
    storeCounter = 0;
  }

  void closeStore() {
    isOpen = false;
    storeCounter = 0;
    closeDate = UtilDateTime.getCurrentDate();
    closeTime = UtilDateTime.getCurrentTime();
    cashOutHistoryList.clear(); //clear all cash history
  }

  String getTicket(bool isOnePagePos) {
    if (isOnePagePos == true) {
      final ticket =
          "${(initial ?? "")}${(storeCounterInitial ?? "")}${this.onePageCounter.toString().padLeft(4, '0')}";
      return ticket;
    }

    return (initial ?? "") + this.storeCounter.toString().padLeft(4, '0');
  }

  String showMeNextTicket(bool isOnePagePos) {
    if (isOnePagePos) {
      var currentCount = this.onePageCounter;
      currentCount++;
      if (currentCount >= getTicketMax()) {
        currentCount = 1;
      }
      return (initial ?? "") +
          (storeCounterInitial ?? "") +
          currentCount.toString().padLeft(4, '0');
    }

    var currentCount = this.storeCounter;
    currentCount++;
    if (currentCount >= getTicketMax()) {
      currentCount = 1;
    }
    return (initial ?? "") + currentCount.toString().padLeft(4, '0');
  }

  bool isTicketMax(bool isOnePagePos) {
    if (isOnePagePos) {
      if (onePageCounter >= 99999999) {
        return true;
      } else {
        return false;
      }
    }

    if (storeCounter >= 99999999) {
      return true;
    } else {
      return false;
    }
  }

  int getTicketMax() {
    return 99999998;
  }

  factory StoreModel.formDocument(Document doc) {
    var id = "";
    try {
      id = doc[kStoreModelId] ?? "";
    } catch (ex) {}

    var gatewayId = "";
    try {
      gatewayId = doc[kStoreModelGatewayId] ?? "";
    } catch (ex) {}

    var companyId = "";
    try {
      companyId = doc[kStoreModelCompanyId] ?? "";
    } catch (ex) {}

    var companyGatewayId = "";
    try {
      companyGatewayId = doc[kStoreModelCompanyGatewayId] ?? "";
    } catch (ex) {}

    var img = "";
    try {
      img = doc[kStoreModelImg] ?? "";
    } catch (ex) {}

    var logo = "";
    try {
      logo = doc[kStoreModelLogo] ?? "";
    } catch (ex) {}

    var title = "";
    try {
      title = doc[kStoreModelTitle] ?? "";
    } catch (ex) {}

    var smallTitle = "";
    try {
      smallTitle = doc[kStoreModelSmallTitle] ?? "";
    } catch (ex) {}

    var address = "";
    try {
      address = doc[kStoreModelAddress] ?? "";
    } catch (ex) {}

    var smallAddress = "";
    try {
      smallAddress = doc[kStoreModelSmallAddress] ?? "";
    } catch (ex) {}

    var businessHour = "";
    try {
      businessHour = doc[kStoreModelBusinessHour] ?? "";
    } catch (ex) {}

    var country = "";
    try {
      country = doc[kStoreModelCountry] ?? "";
    } catch (ex) {}

    var rating = "";
    try {
      rating = doc[kStoreModelRating] ?? "";
    } catch (ex) {}

    var cat = "";
    try {
      cat = doc[kStoreModelCat] ?? "";
    } catch (ex) {}

    var smallCat = "";
    try {
      smallCat = doc[kStoreModelSmallCat] ?? "";
    } catch (ex) {}

    var isOpen = false;
    try {
      isOpen = doc[KStoreModeIsOpen] ?? false;
    } catch (ex) {}

    var isStartQ = false;
    try {
      isStartQ = doc[kStoreModelIsStartQ] ?? false;
    } catch (ex) {}

    var showLogo = true;
    try {
      showLogo = doc[kStoreModelShowLogo] ?? true;
    } catch (ex) {}

    var startQDateTime = "";
    try {
      startQDateTime = doc[kStoreModelStartQDateTime] ?? "";
    } catch (ex) {}

    var timeStep = 0;
    try {
      timeStep = doc[kStoreModelTimeStep] ?? 0;
    } catch (ex) {}

    var timeSlots = "";
    try {
      timeSlots = doc[kStoreModelTimeSlots] ?? "";
    } catch (ex) {}

    var storeCounter = 0;
    try {
      storeCounter = doc[kStoreModelCounter] ?? 0;
    } catch (ex) {}

    var filter = "";
    try {
      filter = doc[kStoreModelFilter] ?? "";
    } catch (ex) {}

    var initial = "";
    try {
      initial = doc[kStoreModelInitial] ?? "";
    } catch (ex) {}

    var mode = kStoreAllMode;
    try {
      mode = doc[kStoreModelMode] ?? kStoreAllMode;
    } catch (ex) {}

    var qCounter = 0;
    try {
      qCounter = doc[kStoreModelQCounter] ?? 0;
    } catch (ex) {}

    var isDebug = "0";
    try {
      isDebug = doc[kStoreModelIsDebug] ?? "0";
    } catch (ex) {}

    var password = "";
    try {
      password = doc[kStoreModelPassword] ?? "";
    } catch (ex) {}

    var currency = "RM";
    try {
      currency = doc[kStoreModelCurrency] ?? "RM";
    } catch (ex) {}

    var quickOrder = false;
    try {
      quickOrder = doc[kStoreModelQuickOrder] ?? false;
    } catch (ex) {}

    var hasKDS = "0";
    try {
      hasKDS = doc[kStoreModelHasKDS] ?? "0";
    } catch (ex) {}

    var hasStudentDelivery = "0";
    try {
      hasStudentDelivery = doc[kStoreModelHasStudentDelivery] ?? "0";
    } catch (ex) {}

    var hasSignage = "0";
    try {
      hasSignage = doc[kStoreModelHasSignage] ?? "0";
    } catch (ex) {}

    var hasQManager = "0";
    try {
      hasQManager = doc[kStoreModelHasQManager] ?? "0";
    } catch (ex) {}

    var hasQSignage = "0";
    try {
      hasQSignage = doc[kStoreModelHasQSignage] ?? "0";
    } catch (ex) {}

    var hasFC = "0";
    try {
      hasFC = doc[kStoreModelHasFC] ?? "0";
    } catch (ex) {}

    var kdsShowPrice = true;
    try {
      kdsShowPrice = doc[kStoreModelKDSShowPrice] ?? true;
    } catch (ex) {}

    //payment type
    var hasIPay = "1";
    try {
      hasIPay = doc[kStoreModelHasIPay] ?? "1";
    } catch (ex) {}

    var hasRazerPay = "1";
    try {
      hasRazerPay = doc[kStoreModelHasRazerPay] ?? "1";
    } catch (ex) {}

    var hasCash = "1";
    try {
      hasCash = doc[kStoreModelHasCash] ?? "1";
    } catch (ex) {}

    var hasPayAtCounter = "1";
    try {
      hasPayAtCounter = doc[kStoreModelHasPayAtCounter] ?? "1";
    } catch (ex) {}

    var cashButtons = "";
    try {
      cashButtons = doc[kStoreModelCashButtons] ?? "";
    } catch (ex) {}

    var openDate = "";
    try {
      openDate = doc[kStoreModelOpenDate] ?? "";
    } catch (ex) {}

    var openTime = "";
    try {
      openTime = doc[kStoreModelOpenTime] ?? "";
    } catch (ex) {}

    var closeDate = "";
    try {
      closeDate = doc[kStoreModelCloseDate] ?? "";
    } catch (ex) {}

    var closeTime = "";
    try {
      closeTime = doc[kStoreModelCloseTime] ?? "";
    } catch (ex) {}

    //landing page
    var landingIsActive = false;
    try {
      landingIsActive = doc[kStoreModelLanding_Active] ?? false;
    } catch (ex) {}

    var landingContactUS = "";
    try {
      landingContactUS = doc[kStoreModelLanding_ContactUS] ?? "";
    } catch (ex) {}

    var landingFacebook = "";
    try {
      landingFacebook = doc[kStoreModelLanding_Facebook] ?? "";
    } catch (ex) {}

    var landingInstagram = "";
    try {
      landingInstagram = doc[kStoreModelLanding_Instagram] ?? "";
    } catch (ex) {}

    var landingFooterBackColor = "";
    try {
      landingFooterBackColor = doc[kStoreModelLanding_FooterBackColor] ?? "";
    } catch (ex) {}

    var landingFooterTextColor = "";
    try {
      landingFooterTextColor = doc[kStoreModelLanding_FooterTextColor] ?? "";
    } catch (ex) {}

    var landingSupportContact = "";
    try {
      landingSupportContact = doc[kStoreModelLanding_SupportContact] ?? "";
    } catch (ex) {}

    var landingSupportEmail = "";
    try {
      landingSupportEmail = doc[kStoreModelLanding_SupportEmail] ?? "";
    } catch (ex) {}

    var landingBannerMessage = "";
    try {
      landingBannerMessage = doc[kStoreModelLanding_BannerMessage] ?? "";
    } catch (ex) {}

    var landingBannerImage = "";
    try {
      landingBannerImage = doc[kStoreModelLanding_BannerImage] ?? "";
    } catch (ex) {}

    var landingStoreBrief = "";
    try {
      landingStoreBrief = doc[kStoreModelLanding_StoreBrief] ?? "";
    } catch (ex) {}

    var landingHighlightImage = "";
    try {
      landingHighlightImage = doc[kStoreModelLanding_HighlightImage] ?? "";
    } catch (ex) {}

    //landingMapLat: .doc[kStoreModelLanding_MapLat] ?? 0.0,
    var landingMapLat = 0.0;
    try {
      landingMapLat = double.tryParse(
              doc[kStoreModelLanding_MapLat]?.toString() ?? "0.0") ??
          0.0;
    } catch (ex) {}

    //landingMapLng: .doc[kStoreModelLanding_MapLng] ?? 0.0,
    var landingMapLng = 0.0;
    try {
      landingMapLng = double.tryParse(
              doc[kStoreModelLanding_MapLng]?.toString() ?? "0.0") ??
          0.0;
    } catch (ex) {}

    var landingCatHighlight = "";
    try {
      landingCatHighlight = doc[kStoreModelLanding_CatHighlight] ?? "";
    } catch (ex) {}

    var islandingCatHighlight = false;
    try {
      islandingCatHighlight = doc[kStoreModelLanding_IsCatHighlight] ?? false;
    } catch (ex) {}

    //advance setting
    var enableAdvanceSetting = false;
    try {
      enableAdvanceSetting = doc[kStoreModelAdvanceSetting_Enable] ?? false;
    } catch (ex) {}

    //bell setting
    var hasBell = false;
    try {
      hasBell = doc[kStoreModelHasBell] ?? false;
    } catch (ex) {}

    var bells = [];
    try {
      bells = (doc[kStoreModelBells] != null)
          ? doc[kStoreModelBells].map((set) {
              return BellModel.fromMap(set);
            }).toList()
          : [];
    } catch (ex) {}

    //multi kds setting
    var terminalId = "";
    try {
      terminalId = doc[kStoreModelTerminalId] ?? "";
    } catch (ex) {}

    // var filterList = [];
    // try {
    //   filterList = (doc[kStoreModelStoreFilters] != null)
    //       ? doc[kStoreModelStoreFilters].map((set) {
    //           return StoreFilterModel.fromMap(set);
    //         }).toList()
    //       : [];
    // } catch (ex) {}

    var taxType = kTaxInclusive;
    try {
      taxType = doc[kStoreModelTaxType] ?? kTaxInclusive;
    } catch (ex) {}

    var isTaxEnabled = false;
    try {
      isTaxEnabled = doc[kStoreModelIsTaxEnabled] ?? false;
    } catch (ex) {}

    var isServiceChargeEnabled = false;
    try {
      isServiceChargeEnabled = doc[kStoreModelIsServiceChargeEnabled] ?? false;
    } catch (ex) {}

    var isRoundingForCashOnly = false;
    try {
      isRoundingForCashOnly = doc[kStoreModelIsRoundingForCashOnly] ?? false;
    } catch (ex) {}

    var auditButtons = "";
    try {
      auditButtons = doc[kStoreModelAuditButtons] ?? "";
    } catch (ex) {}

    var onePageCounter = 0;
    try {
      onePageCounter = doc[kStoreModelOnePageCounter] ?? 0;
    } catch (ex) {}

    var serviceCharge = 0.0;
    try {
      serviceCharge =
          double.tryParse(doc[kStoreModelServiceCharge]?.toString() ?? "0.0") ??
              0.0;
    } catch (ex) {}

    var tax = 0.0;
    try {
      tax = double.tryParse(doc[kStoreModelTax]?.toString() ?? "0.0") ?? 0.0;
    } catch (ex) {}

    var openFloat = 0.0;
    try {
      openFloat =
          double.tryParse(doc[kStoreModelOpenFloat]?.toString() ?? "0.0") ??
              0.0;
    } catch (ex) {}

    var auditCash = 0.0;
    try {
      auditCash =
          double.tryParse(doc[kStoreModelAuditCash]?.toString() ?? "0.0") ??
              0.0;
    } catch (ex) {}

    //cash out history
    var cashOutHistoryList = [];
    try {
      cashOutHistoryList = (doc[kStoreModelCashOutHistory] != null)
          ? doc[kStoreModelCashOutHistory].map((set) {
              return CashOutModel.fromMap(set);
            }).toList()
          : [];
    } catch (ex) {}

    //receipt related
    var receiptHeaderText = "";
    try {
      receiptHeaderText = doc[kStoreModelReceiptHeaderText] ?? "";
    } catch (ex) {}

    var receiptFooterText = "";
    try {
      receiptFooterText = doc[kStoreModelReceiptFooterText] ?? "";
    } catch (ex) {}

    //theme related
    var themeSelected = "";
    try {
      themeSelected = doc[kStoreModelThemeSelected] ?? "";
    } catch (ex) {}
    //banner
    var landingBannerBackColor = "";
    try {
      landingBannerBackColor = doc[kStoreModelLanding_BannerBackColor] ?? "";
    } catch (ex) {}

    var landingBannerTextColor = "";
    try {
      landingBannerTextColor = doc[kStoreModelLanding_BannerTextColor] ?? "";
    } catch (ex) {}

    //is kds with collector
    var isKDSWithCollector = false;
    try {
      isKDSWithCollector = doc[kStoreModelIsKDSWithCollector] ?? false;
    } catch (ex) {}

    //watsapp key
    var watsappKey = "";
    try {
      watsappKey = doc[kStoreModelWatsappKey] ?? "";
    } catch (ex) {}

    //esl
    var merchantKey = "";
    try {
      merchantKey = doc[kStoreModelMerchantKey] ?? "";
    } catch (ex) {}

    var merchantId = "";
    try {
      merchantId = doc[kStoreModelMerchantId] ?? "";
    } catch (ex) {}

    //store counter initial
    var storeCounterInitial = "";
    try {
      storeCounterInitial = doc[kStoreModelCounterInitial] ?? "";
    } catch (ex) {}

    //ipay
    var iPayMerchantKey = "";
    try {
      iPayMerchantKey = doc[kStoreModelIPayMerchantKey] ?? "";
    } catch (ex) {}

    var iPayMerchantId = "";
    try {
      iPayMerchantId = doc[kStoreModelIPayMerchantId] ?? "";
    } catch (ex) {}

    //is arkmind enabled
    var enableArkMind = false;
    try {
      enableArkMind = doc[kStoreModelEnable_ArkMind] ?? false;
    } catch (ex) {}

    return StoreModel(
      id: id,
      gatewayId: gatewayId,
      companyId: companyId,
      companyGatewayId: companyGatewayId,
      img: img,
      logo: logo,
      title: title,
      smallTitle: smallTitle,

      address: address,
      smallAddress: smallAddress,
      businessHour: businessHour,
      country: country,
      rating: rating,
      cat: cat,
      smallCat: smallCat,
      isOpen: isOpen,
      isStartQ: isStartQ,
      showLogo: showLogo,

      startQDateTime: startQDateTime,
      timeStep: timeStep,
      timeSlots: timeSlots,
      storeCounter: storeCounter,
      filter: filter,
      initial: initial,
      mode: mode,

      qCounter: qCounter,
      isDebug: isDebug,
      password: password,
      currency: currency,
      quickOrder: quickOrder,
      hasKDS: hasKDS,
      hasStudentDelivery: hasStudentDelivery,
      hasSignage: hasSignage,
      hasQManager: hasQManager,
      hasQSignage: hasQSignage,
      hasFC: hasFC,
      kdsShowPrice: kdsShowPrice,

      //payment type
      hasIPay: hasIPay,
      hasRazerPay: hasRazerPay,
      hasCash: hasCash,
      hasPayAtCounter: hasPayAtCounter,
      cashButtons: cashButtons,

      openDate: openDate,
      openTime: openTime,
      closeDate: closeDate,
      closeTime: closeTime,

      //landing page
      landingIsActive: landingIsActive,
      landingContactUS: landingContactUS,
      landingFacebook: landingFacebook,
      landingInstagram: landingInstagram,
      landingFooterBackColor: landingFooterBackColor,
      landingFooterTextColor: landingFooterTextColor,
      landingSupportContact: landingSupportContact,
      landingSupportEmail: landingSupportEmail,
      landingBannerMessage: landingBannerMessage,
      landingBannerImage: landingBannerImage,
      landingStoreBrief: landingStoreBrief,
      landingHighlightImage: landingHighlightImage,
      //landingMapLat: .doc[kStoreModelLanding_MapLat] ?? 0.0,
      landingMapLat: landingMapLat,
      //landingMapLng: .doc[kStoreModelLanding_MapLng] ?? 0.0,
      landingMapLng: landingMapLng,
      landingCatHighlight: landingCatHighlight,
      islandingCatHighlight: islandingCatHighlight,

      //advance setting
      enableAdvanceSetting: enableAdvanceSetting,

      //bell setting
      hasBell: hasBell,
      bells: bells,

      //multi kds setting
      terminalId: terminalId,
      //filterList: filterList,

      taxType: taxType,
      isTaxEnabled: isTaxEnabled,
      isServiceChargeEnabled: isServiceChargeEnabled,
      isRoundingForCashOnly: isRoundingForCashOnly,
      auditButtons: auditButtons,
      onePageCounter: onePageCounter,
      serviceCharge: serviceCharge,
      tax: tax,
      openFloat: openFloat,
      auditCash: auditCash,
      //cash out history
      cashOutHistoryList: cashOutHistoryList,
      //receipt related
      receiptHeaderText: receiptHeaderText,
      receiptFooterText: receiptFooterText,

      //theme related
      themeSelected: themeSelected,
      //banner
      landingBannerBackColor: landingBannerBackColor,
      landingBannerTextColor: landingBannerTextColor,
      //is kds with collector
      isKDSWithCollector: isKDSWithCollector,

      //watsapp key
      watsappKey: watsappKey,

      //esl
      merchantKey: merchantKey,
      merchantId: merchantId,

      //store counter initial
      storeCounterInitial: storeCounterInitial,

      //ipay
      iPayMerchantKey: iPayMerchantKey,
      iPayMerchantId: iPayMerchantId,

      //is arkmind enabled
      enableArkMind: enableArkMind,
    );
  }

  StoreModel.fromMap(Map<dynamic, dynamic> map)
      : id = map[kStoreModelId],
        gatewayId = map[kStoreModelGatewayId] ?? "",
        companyId = map[kStoreModelCompanyId] ?? "",
        companyGatewayId = map[kStoreModelCompanyGatewayId] ?? "",
        img = map[kStoreModelImg],
        logo = map[kStoreModelLogo],
        title = map[kStoreModelTitle],
        smallTitle = map[kStoreModelSmallTitle],
        address = map[kStoreModelAddress],
        smallAddress = map[kStoreModelSmallAddress],
        businessHour = map[kStoreModelBusinessHour] ?? "",
        country = map[kStoreModelCountry] ?? "",
        rating = map[kStoreModelRating],
        cat = map[kStoreModelCat],
        smallCat = map[kStoreModelSmallCat],
        isOpen = map[KStoreModeIsOpen],
        isStartQ = map[kStoreModelIsStartQ],
        showLogo = map[kStoreModelShowLogo] ?? true,
        startQDateTime = map[kStoreModelStartQDateTime],
        timeStep = map[kStoreModelTimeStep],
        timeSlots = map[kStoreModelTimeSlots],
        storeCounter = map[kStoreModelCounter] ?? 0,
        filter = map[kStoreModelFilter],
        initial = map[kStoreModelInitial],
        mode = map[kStoreModelMode] ?? kStoreAllMode,
        qCounter = map[kStoreModelQCounter] ?? 0,
        isDebug = map[kStoreModelIsDebug] ?? "0",
        password = map[kStoreModelPassword] ?? "",
        currency = map[kStoreModelCurrency] ?? "RM",
        quickOrder = map[kStoreModelQuickOrder] ?? false,
        hasKDS = map[kStoreModelHasKDS] ?? "0",
        hasStudentDelivery = map[kStoreModelHasStudentDelivery] ?? "0",
        hasSignage = map[kStoreModelHasSignage] ?? "0",
        hasQManager = map[kStoreModelHasQManager] ?? "0",
        hasQSignage = map[kStoreModelHasQSignage] ?? "0",
        hasFC = map[kStoreModelHasFC] ?? "0",
        kdsShowPrice = map[kStoreModelKDSShowPrice] ?? true,

        //payment type
        hasIPay = map[kStoreModelHasIPay] ?? "1",
        hasRazerPay = map[kStoreModelHasRazerPay] ?? "1",
        hasCash = map[kStoreModelHasCash] ?? "1",
        hasPayAtCounter = map[kStoreModelHasPayAtCounter] ?? "1",
        cashButtons = map[kStoreModelCashButtons] ?? "",
        openDate = map[kStoreModelOpenDate] ?? "",
        openTime = map[kStoreModelOpenTime] ?? "",
        closeDate = map[kStoreModelCloseDate] ?? "",
        closeTime = map[kStoreModelCloseTime] ?? "",

        //landing page
        landingIsActive = map[kStoreModelLanding_Active] ?? false,
        landingContactUS = map[kStoreModelLanding_ContactUS] ?? "",
        landingFacebook = map[kStoreModelLanding_Facebook] ?? "",
        landingInstagram = map[kStoreModelLanding_Instagram] ?? "",
        landingFooterBackColor = map[kStoreModelLanding_FooterBackColor] ?? "",
        landingFooterTextColor = map[kStoreModelLanding_FooterTextColor] ?? "",
        landingSupportContact = map[kStoreModelLanding_SupportContact] ?? "",
        landingSupportEmail = map[kStoreModelLanding_SupportEmail] ?? "",
        landingBannerMessage = map[kStoreModelLanding_BannerMessage] ?? "",
        landingBannerImage = map[kStoreModelLanding_BannerImage] ?? "",
        landingStoreBrief = map[kStoreModelLanding_StoreBrief] ?? "",
        landingHighlightImage = map[kStoreModelLanding_HighlightImage] ?? "",
        landingMapLat = map[kStoreModelLanding_MapLat] ?? 0.0,
        landingMapLng = map[kStoreModelLanding_MapLng] ?? 0.0,
        landingCatHighlight = map[kStoreModelLanding_CatHighlight] ?? "",
        islandingCatHighlight = map[kStoreModelLanding_IsCatHighlight] ?? false,

        //advance setting
        enableAdvanceSetting = map[kStoreModelAdvanceSetting_Enable] ?? false,

        //bell setting
        hasBell = map[kStoreModelHasBell] ?? false,
        bells = (map[kStoreModelBells] != null)
            ? map[kStoreModelBells].map((set) {
                return BellModel.fromMap(set);
              }).toList()
            : [],

        //multi kds setting
        terminalId = map[kStoreModelTerminalId] ?? "",
        // filterList = (map[kStoreModelStoreFilters] != null)
        //     ? map[kStoreModelStoreFilters].map((set) {
        //         return StoreFilterModel.fromMap(set);
        //       }).toList()
        //     : [],
        taxType = map[kStoreModelTaxType] ?? kTaxInclusive,
        isTaxEnabled = map[kStoreModelIsTaxEnabled] ?? false,
        isServiceChargeEnabled =
            map[kStoreModelIsServiceChargeEnabled] ?? false,
        isRoundingForCashOnly = map[kStoreModelIsRoundingForCashOnly] ?? true,
        auditButtons = map[kStoreModelAuditButtons] ?? "",
        onePageCounter = map[kStoreModelOnePageCounter] ?? 0,
        serviceCharge = double.tryParse(
                map[kStoreModelServiceCharge]?.toString() ?? "0.0") ??
            0.0,
        tax = double.tryParse(map[kStoreModelTax]?.toString() ?? "0.0") ?? 0.0,
        openFloat =
            double.tryParse(map[kStoreModelOpenFloat]?.toString() ?? "0.0") ??
                0.0,
        auditCash =
            double.tryParse(map[kStoreModelAuditCash]?.toString() ?? "0.0") ??
                0.0,
        cashOutHistoryList = (map[kStoreModelCashOutHistory] != null)
            ? map[kStoreModelCashOutHistory].map((set) {
                return CashOutModel.fromMap(set);
              }).toList()
            : [],
        receiptHeaderText = map[kStoreModelReceiptHeaderText] ?? "",
        receiptFooterText = map[kStoreModelReceiptFooterText] ?? "",

        //theme related
        themeSelected = map[kStoreModelThemeSelected] ?? "",
        //banner
        landingBannerBackColor = map[kStoreModelLanding_BannerBackColor] ?? "",
        landingBannerTextColor = map[kStoreModelLanding_BannerTextColor] ?? "",
        isKDSWithCollector = map[kStoreModelIsKDSWithCollector] ?? false,
        watsappKey = map[kStoreModelWatsappKey] ?? "",
        merchantKey = map[kStoreModelMerchantKey] ?? "",
        merchantId = map[kStoreModelMerchantId] ?? "",
        storeCounterInitial = map[kStoreModelCounterInitial] ?? "",
        iPayMerchantKey = map[kStoreModelIPayMerchantKey] ?? "",
        iPayMerchantId = map[kStoreModelIPayMerchantId] ?? "",
        enableArkMind = map[kStoreModelEnable_ArkMind] ?? false;

  Map<String, dynamic> toMap() {
    return {
      kStoreModelId: id,
      kStoreModelGatewayId: gatewayId ?? "",
      kStoreModelCompanyId: companyId ?? "",
      kStoreModelCompanyGatewayId: companyGatewayId ?? "",
      kStoreModelImg: img,
      kStoreModelLogo: logo,
      kStoreModelTitle: title,
      kStoreModelSmallTitle: smallTitle ?? title.toLowerCase(),
      kStoreModelAddress: address,
      kStoreModelSmallAddress: smallAddress ?? address.toLowerCase(),
      kStoreModelCountry: country,
      kStoreModelBusinessHour: businessHour ?? "",
      kStoreModelRating: rating,
      kStoreModelCat: cat,
      kStoreModelSmallCat: smallCat,
      KStoreModeIsOpen: isOpen,
      kStoreModelIsStartQ: isStartQ,
      kStoreModelShowLogo: showLogo,
      kStoreModelStartQDateTime: startQDateTime,
      kStoreModelTimeStep: timeStep,
      kStoreModelTimeSlots: timeSlots,
      kStoreModelCounter: storeCounter ?? 0,
      kStoreModelFilter: filter,
      kStoreModelInitial: initial,
      kStoreModelMode: mode ?? kStoreAllMode,
      kStoreModelQCounter: qCounter,
      kStoreModelIsDebug: isDebug ?? "0",
      kStoreModelPassword: password ?? "",
      kStoreModelCurrency: currency ?? "RM",
      kStoreModelQuickOrder: quickOrder ?? false,
      kStoreModelHasStudentDelivery: hasStudentDelivery ?? "0",
      kStoreModelHasKDS: hasKDS ?? "0",
      kStoreModelHasSignage: hasSignage ?? "0",
      kStoreModelHasQManager: hasQManager ?? "0",
      kStoreModelHasQSignage: hasQSignage ?? "0",
      kStoreModelHasFC: hasFC ?? "0",
      kStoreModelKDSShowPrice: kdsShowPrice ?? true,

      //payment type
      kStoreModelHasIPay: hasIPay ?? "0",
      kStoreModelHasRazerPay: hasRazerPay ?? "0",
      kStoreModelHasCash: hasCash ?? "0",
      kStoreModelHasPayAtCounter: hasPayAtCounter ?? "0",
      kStoreModelCashButtons: cashButtons ?? "",

      kStoreModelOpenDate: openDate,
      kStoreModelOpenTime: openTime,
      kStoreModelCloseDate: closeDate,
      kStoreModelCloseTime: closeTime,

      //landing page
      kStoreModelLanding_Active: landingIsActive ?? false,
      kStoreModelLanding_ContactUS: landingContactUS ?? "",
      kStoreModelLanding_Facebook: landingFacebook ?? "",
      kStoreModelLanding_Instagram: landingInstagram ?? "",
      kStoreModelLanding_FooterBackColor: landingFooterBackColor ?? "",
      kStoreModelLanding_FooterTextColor: landingFooterTextColor ?? "",
      kStoreModelLanding_SupportContact: landingSupportContact ?? "",
      kStoreModelLanding_SupportEmail: landingSupportEmail ?? "",
      kStoreModelLanding_BannerMessage: landingBannerMessage ?? "",
      kStoreModelLanding_BannerImage: landingBannerImage ?? "",
      kStoreModelLanding_StoreBrief: landingStoreBrief ?? "",
      kStoreModelLanding_HighlightImage: landingHighlightImage ?? "",
      kStoreModelLanding_MapLat: landingMapLat ?? 0.0,
      kStoreModelLanding_MapLng: landingMapLng ?? 0.0,
      kStoreModelLanding_CatHighlight: landingCatHighlight ?? "",
      kStoreModelLanding_IsCatHighlight: islandingCatHighlight ?? false,

      //advance setting
      kStoreModelAdvanceSetting_Enable: enableAdvanceSetting ?? false,

      //bell setting
      kStoreModelBells: firestoreSets(),
      kStoreModelHasBell: hasBell ?? false,

      //multi kds setting
      kStoreModelTerminalId: terminalId ?? "",
      //kStoreModelStoreFilters: firestoreFilterSets(),

      //gst sst service charge
      kStoreModelServiceCharge: serviceCharge ?? 0.0,
      kStoreModelTax: tax ?? 0.0,
      kStoreModelTaxType: taxType ?? kTaxInclusive,
      kStoreModelIsTaxEnabled: isTaxEnabled ?? false,
      kStoreModelIsServiceChargeEnabled: isServiceChargeEnabled ?? false,
      kStoreModelIsRoundingForCashOnly: isRoundingForCashOnly ?? false,
      //open float
      kStoreModelOpenFloat: openFloat ?? 0.0,
      //audit cash
      kStoreModelAuditCash: auditCash ?? 0.0,
      //audit cash drawer button
      kStoreModelAuditButtons: auditButtons ?? "",

      kStoreModelOnePageCounter: onePageCounter ?? 0,

      //cash out history
      kStoreModelCashOutHistory: firestoreCashOutHistory(),

      //receipt related
      kStoreModelReceiptHeaderText: receiptHeaderText ?? "",
      kStoreModelReceiptFooterText: receiptFooterText ?? "",

      //theme related
      kStoreModelThemeSelected: themeSelected ?? "",

      //banner
      kStoreModelLanding_BannerBackColor: landingBannerBackColor ?? "",
      kStoreModelLanding_BannerTextColor: landingBannerTextColor ?? "",

      //is kds with collector
      kStoreModelIsKDSWithCollector: isKDSWithCollector ?? false,

      //watsapp key
      kStoreModelWatsappKey: watsappKey ?? "",

      //esl
      kStoreModelMerchantKey: merchantKey ?? "",
      kStoreModelMerchantId: merchantId ?? "",

      //store counter initial
      kStoreModelCounterInitial: storeCounterInitial ?? "",

      //ipay
      kStoreModelIPayMerchantKey: iPayMerchantKey ?? "",
      kStoreModelIPayMerchantId: iPayMerchantId ?? "",

      //enable arkmind
      kStoreModelEnable_ArkMind: enableArkMind ?? false,
    };
  }

  List<Map<String, dynamic>> firestoreSets() {
    List<Map<String, dynamic>> convertedSets = [];
    bells ??= [];
    for (var set in bells) {
      //OrderItemModel thisSet = set as OrderItemModel;
      convertedSets.add(set.toMap());
    }
    return convertedSets;
  }

  // List<Map<String, dynamic>> firestoreFilterSets() {
  //   List<Map<String, dynamic>> convertedSets = [];
  //   filterList ??= [];
  //   for (var set in filterList) {
  //     //OrderItemModel thisSet = set as OrderItemModel;
  //     convertedSets.add(set.toMap());
  //   }
  //   return convertedSets;
  // }

  double getTaxPercentage() {
    if ((isTaxEnabled ?? false) == false) {
      return 0.0;
    }

    return tax ?? 0.0;
  }

  double getServicChargePercentage() {
    if ((isServiceChargeEnabled ?? false) == false) {
      return 0.0;
    }

    return serviceCharge ?? 0.0;
  }

  String getQTicket() {
    return this.qCounter.toString().padLeft(4, '0');
  }

  bool isQTicketMax() {
    if (this.qCounter >= 99999999) {
      return true;
    } else
      return false;
  }

  int getQTicketMax() {
    return 99999998;
  }

  //cash out history
  addCashOut(CashOutModel cashModel) {
    cashOutHistoryList.add(cashModel);
  }

  double getTotalCashOut() {
    double dTotal = 0.0;
    for (var model in cashOutHistoryList) {
      try {
        final cashModel = model as CashOutModel;
        dTotal = dTotal + cashModel.cashOut;
      } catch (ex) {
        print(ex.toString());
      }
    }

    return dTotal;
  }

  List<Map<String, dynamic>> firestoreCashOutHistory() {
    List<Map<String, dynamic>> convertedSets = [];
    cashOutHistoryList ??= [];
    for (var set in cashOutHistoryList) {
      //OrderItemModel thisSet = set as OrderItemModel;
      convertedSets.add(set.toMap());
    }
    return convertedSets;
  }
}
