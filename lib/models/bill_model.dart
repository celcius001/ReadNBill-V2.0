class BillModel {
  // ---- SQLite-only fields (not part of the API payload) ----
  final int? id;
  final bool isUploaded;

  final String? servicePeriodEnd;
  final String? accountNumber;
  final double? powerPreviousReading;
  final double? powerPresentReading;
  final double? demandPreviousReading;
  final double? demandPresentReading;
  final double? additionalKWH;
  final double? additionalKWDemand;
  final double? powerKWH;
  final double? kwhAmount;
  final double? demandKW;
  final double? kwAmount;
  final double? charges;
  final double? deductions;
  final double? netAmount;
  final double? powerRate;
  final double? demandRate;
  final DateTime? billingDate;
  final DateTime? serviceDateFrom;
  final DateTime? serviceDateTo;
  final DateTime? dueDate;
  final String? billNumber;
  final String? remarks;
  final double? averageKWH;
  final double? averageKWDemand;
  final double? coreLoss;
  final String? meter;
  final String? pr;
  final String? sdw;
  final String? others;
  final double? ppa;
  final double? ppaAmount;
  final double? basicAmount;
  final double? praDiscount;
  final double? praAmount;
  final double? fppca;
  final double? fppcaAmount;
  final double? ucAmount;
  final double? ucAmountEC;
  final String? meterNumber;
  final String? consumerType;
  final String? billType;
  final double? qcAmount;
  final double? epAmount;
  final double? pcAmount;
  final double? wacAmount;
  final double? lcAmount;
  final String? billingPeriod;
  final String? keyForSelection;
  final String? orNumber;
  final DateTime? orDate;
  final double? genSysAmt;
  final double? fbhcAmt;
  final double? fpcaAdjAmt;
  final double? iceraAmt;
  final double? transDemAmt;
  final double? transSysAmt;
  final double? sysLossAmt;
  final double? distribDemAmt;
  final double? distribSysAmt;
  final double? supRetCusAmt;
  final double? supSysAmt;
  final double? metRetCusAmt;
  final double? metSysAmt;
  final double? iccsAmt;
  final double? lifelineSubsidyAmt;
  final String? unbundledTag;
  final double? defAcctgAdjAmt;
  final double? vatGenAmt;
  final double? vatTransAmt;
  final double? vatSLAmt;
  final double? vatDistAmt;
  final double? vatOthersAmt;
  final double? seniorCitizenAmt;
  final double? seniorCitizenSubsidy;
  final double? strandedCostAmt;
  final double? bcAmount;
  final double? fitAllAmt;
  final double? ogaAmt;
  final double? otcaDemAmt;
  final double? otcaSysAmt;
  final double? oslaAmt;
  final double? olraAmt;
  final double? npcsd;
  final double? meredci;
  final double? ogaCurr;
  final double? otcaSysCurr;
  final double? otcaDemCurr;
  final double? oslaCurr;
  final double? olraCurr;
  final double? osrRA;
  final double? oga3;
  final double? otcaSys3;
  final double? otcaDem3;
  final double? osla3;
  final double? olra3;
  final double? franchiseTax;
  final String? rowguid;

  BillModel({
    this.id,
    this.isUploaded = false,
    this.servicePeriodEnd,
    this.accountNumber,
    this.powerPreviousReading,
    this.powerPresentReading,
    this.demandPreviousReading,
    this.demandPresentReading,
    this.additionalKWH,
    this.additionalKWDemand,
    this.powerKWH,
    this.kwhAmount,
    this.demandKW,
    this.kwAmount,
    this.charges,
    this.deductions,
    this.netAmount,
    this.powerRate,
    this.demandRate,
    this.billingDate,
    this.serviceDateFrom,
    this.serviceDateTo,
    this.dueDate,
    this.billNumber,
    this.remarks,
    this.averageKWH,
    this.averageKWDemand,
    this.coreLoss,
    this.meter,
    this.pr,
    this.sdw,
    this.others,
    this.ppa,
    this.ppaAmount,
    this.basicAmount,
    this.praDiscount,
    this.praAmount,
    this.fppca,
    this.fppcaAmount,
    this.ucAmount,
    this.ucAmountEC,
    this.meterNumber,
    this.consumerType,
    this.billType,
    this.qcAmount,
    this.epAmount,
    this.pcAmount,
    this.wacAmount,
    this.lcAmount,
    this.billingPeriod,
    this.keyForSelection,
    this.orNumber,
    this.orDate,
    this.genSysAmt,
    this.fbhcAmt,
    this.fpcaAdjAmt,
    this.iceraAmt,
    this.transDemAmt,
    this.transSysAmt,
    this.sysLossAmt,
    this.distribDemAmt,
    this.distribSysAmt,
    this.supRetCusAmt,
    this.supSysAmt,
    this.metRetCusAmt,
    this.metSysAmt,
    this.iccsAmt,
    this.lifelineSubsidyAmt,
    this.unbundledTag,
    this.defAcctgAdjAmt,
    this.vatGenAmt,
    this.vatTransAmt,
    this.vatSLAmt,
    this.vatDistAmt,
    this.vatOthersAmt,
    this.seniorCitizenAmt,
    this.seniorCitizenSubsidy,
    this.strandedCostAmt,
    this.bcAmount,
    this.fitAllAmt,
    this.ogaAmt,
    this.otcaDemAmt,
    this.otcaSysAmt,
    this.oslaAmt,
    this.olraAmt,
    this.npcsd,
    this.meredci,
    this.ogaCurr,
    this.otcaSysCurr,
    this.otcaDemCurr,
    this.oslaCurr,
    this.olraCurr,
    this.osrRA,
    this.oga3,
    this.otcaSys3,
    this.otcaDem3,
    this.osla3,
    this.olra3,
    this.franchiseTax,
    this.rowguid,
  });

  // Used by API
  factory BillModel.fromJson(Map<String, dynamic> json) {
    return BillModel(
      servicePeriodEnd: json['ServicePeriodEnd']?.toString() ?? '',
      accountNumber: json['AccountNumber']?.toString(),
      powerPreviousReading: (json['PowerPreviousReading'] as num?)?.toDouble(),
      powerPresentReading: (json['PowerPresentReading'] as num?)?.toDouble(),
      demandPreviousReading:
          (json['DemandPreviousReading'] as num?)?.toDouble(),
      demandPresentReading: (json['DemandPresentReading'] as num?)?.toDouble(),
      additionalKWH: (json['AdditionalKWH'] as num?)?.toDouble(),
      additionalKWDemand: (json['AdditionalKWDemand'] as num?)?.toDouble(),
      powerKWH: (json['PowerKWH'] as num?)?.toDouble(),
      kwhAmount: (json['KWHAmount'] as num?)?.toDouble(),
      demandKW: (json['DemandKW'] as num?)?.toDouble(),
      kwAmount: (json['KWAmount'] as num?)?.toDouble(),
      charges: (json['Charges'] as num?)?.toDouble(),
      deductions: (json['Deductions'] as num?)?.toDouble(),
      netAmount: (json['NetAmount'] as num?)?.toDouble(),
      powerRate: (json['PowerRate'] as num?)?.toDouble(),
      demandRate: (json['DemandRate'] as num?)?.toDouble(),
      billingDate: DateTime.tryParse(json['BillingDate'].toString()),
      serviceDateFrom: DateTime.tryParse(json['ServiceDateFrom'].toString()),
      serviceDateTo: DateTime.tryParse(json['ServiceDateTo'].toString()),
      dueDate: DateTime.tryParse(json['DueDate'].toString()),
      billNumber: json['BillNumber']?.toString(),
      remarks: json['Remarks']?.toString(),
      averageKWH: (json['AverageKWH'] as num?)?.toDouble(),
      averageKWDemand: (json['AverageKWDemand'] as num?)?.toDouble(),
      coreLoss: (json['CoreLoss'] as num?)?.toDouble(),
      meter: json['Meter']?.toString(),
      pr: json['PR']?.toString(),
      sdw: json['SDW']?.toString(),
      others: json['Others']?.toString(),
      ppa: (json['PPA'] as num?)?.toDouble(),
      ppaAmount: (json['PPAAmount'] as num?)?.toDouble(),
      basicAmount: (json['BasicAmount'] as num?)?.toDouble(),
      praDiscount: (json['PRADiscount'] as num?)?.toDouble(),
      praAmount: (json['PRAAmount'] as num?)?.toDouble(),
      fppca: (json['FPPCA'] as num?)?.toDouble(),
      fppcaAmount: (json['FPPCAAmount'] as num?)?.toDouble(),
      ucAmount: (json['UCAmount'] as num?)?.toDouble(),
      ucAmountEC: (json['UCAmountEC'] as num?)?.toDouble(),
      meterNumber: json['MeterNumber']?.toString(),
      consumerType: json['ConsumerType']?.toString(),
      billType: json['BillType']?.toString(),
      qcAmount: (json['QCAmount'] as num?)?.toDouble(),
      epAmount: (json['EPAmount'] as num?)?.toDouble(),
      pcAmount: (json['PCAmount'] as num?)?.toDouble(),
      wacAmount: (json['WACAmount'] as num?)?.toDouble(),
      lcAmount: (json['LCAmount'] as num?)?.toDouble(),
      billingPeriod: json['BillingPeriod']?.toString(),
      keyForSelection: json['KeyForSelection']?.toString(),
      orNumber: json['ORNumber']?.toString(),
      orDate: DateTime.tryParse(json['ORDate'].toString()),
      genSysAmt: (json['GenSysAmt'] as num?)?.toDouble(),
      fbhcAmt: (json['FBHCAmt'] as num?)?.toDouble(),
      fpcaAdjAmt: (json['FPCAAdjAmt'] as num?)?.toDouble(),
      iceraAmt: (json['ICERAAmt'] as num?)?.toDouble(),
      transDemAmt: (json['TransDemAmt'] as num?)?.toDouble(),
      transSysAmt: (json['TransSysAmt'] as num?)?.toDouble(),
      sysLossAmt: (json['SysLossAmt'] as num?)?.toDouble(),
      distribDemAmt: (json['DistribDemAmt'] as num?)?.toDouble(),
      distribSysAmt: (json['DistribSysAmt'] as num?)?.toDouble(),
      supRetCusAmt: (json['SupRetCusAmt'] as num?)?.toDouble(),
      supSysAmt: (json['SupSysAmt'] as num?)?.toDouble(),
      metRetCusAmt: (json['MetRetCusAmt'] as num?)?.toDouble(),
      metSysAmt: (json['MetSysAmt'] as num?)?.toDouble(),
      iccsAmt: (json['ICCSAmt'] as num?)?.toDouble(),
      lifelineSubsidyAmt: (json['LifelineSubsidyAmt'] as num?)?.toDouble(),
      unbundledTag: json['UnbundledTag']?.toString(),
      defAcctgAdjAmt: (json['DefAcctgAdjAmt'] as num?)?.toDouble(),
      vatGenAmt: (json['VATGenAmt'] as num?)?.toDouble(),
      vatTransAmt: (json['VATTransAmt'] as num?)?.toDouble(),
      vatSLAmt: (json['VATSLAmt'] as num?)?.toDouble(),
      vatDistAmt: (json['VATDistAmt'] as num?)?.toDouble(),
      vatOthersAmt: (json['VATOthersAmt'] as num?)?.toDouble(),
      seniorCitizenAmt: (json['SeniorCitizenAmt'] as num?)?.toDouble(),
      seniorCitizenSubsidy: (json['SeniorCitizenSubsidy'] as num?)?.toDouble(),
      strandedCostAmt: (json['StrandedCostAmt'] as num?)?.toDouble(),
      bcAmount: (json['BCAmount'] as num?)?.toDouble(),
      fitAllAmt: (json['FITAllAmt'] as num?)?.toDouble(),
      ogaAmt: (json['OGAAmt'] as num?)?.toDouble(),
      otcaDemAmt: (json['OTCADemAmt'] as num?)?.toDouble(),
      otcaSysAmt: (json['OTCASysAmt'] as num?)?.toDouble(),
      oslaAmt: (json['OSLAAmt'] as num?)?.toDouble(),
      olraAmt: (json['OLRAAmt'] as num?)?.toDouble(),
      npcsd: (json['NPCSD'] as num?)?.toDouble(),
      meredci: (json['MEREDCI'] as num?)?.toDouble(),
      ogaCurr: (json['OGACurr'] as num?)?.toDouble(),
      otcaSysCurr: (json['OTCASysCurr'] as num?)?.toDouble(),
      otcaDemCurr: (json['OTCADemCurr'] as num?)?.toDouble(),
      oslaCurr: (json['OSLACurr'] as num?)?.toDouble(),
      olraCurr: (json['OLRACurr'] as num?)?.toDouble(),
      osrRA: (json['OSRRA'] as num?)?.toDouble(),
      oga3: (json['OGA3'] as num?)?.toDouble(),
      otcaSys3: (json['OTCASys3'] as num?)?.toDouble(),
      otcaDem3: (json['OTCADem3'] as num?)?.toDouble(),
      osla3: (json['OSLA3'] as num?)?.toDouble(),
      olra3: (json['OLRA3'] as num?)?.toDouble(),
      franchiseTax: (json['FranchiseTax'] as num?)?.toDouble(),
      rowguid: json['rowguid']?.toString(),
    );
  }

  // Used by SQLite
  factory BillModel.fromMap(Map<String, dynamic> map) {
    return BillModel(
      id: map['id'] as int?,
      isUploaded: (map['is_uploaded'] as int?) == 1,
      servicePeriodEnd: map['ServicePeriodEnd']?.toString(),
      accountNumber: map['AccountNumber']?.toString(),
      powerPreviousReading: (map['PowerPreviousReading'] as num?)?.toDouble(),
      powerPresentReading: (map['PowerPresentReading'] as num?)?.toDouble(),
      demandPreviousReading: (map['DemandPreviousReading'] as num?)?.toDouble(),
      demandPresentReading: (map['DemandPresentReading'] as num?)?.toDouble(),
      additionalKWH: (map['AdditionalKWH'] as num?)?.toDouble(),
      additionalKWDemand: (map['AdditionalKWDemand'] as num?)?.toDouble(),
      powerKWH: (map['PowerKWH'] as num?)?.toDouble(),
      kwhAmount: (map['KWHAmount'] as num?)?.toDouble(),
      demandKW: (map['DemandKW'] as num?)?.toDouble(),
      kwAmount: (map['KWAmount'] as num?)?.toDouble(),
      charges: (map['Charges'] as num?)?.toDouble(),
      deductions: (map['Deductions'] as num?)?.toDouble(),
      netAmount: (map['NetAmount'] as num?)?.toDouble(),
      powerRate: (map['PowerRate'] as num?)?.toDouble(),
      demandRate: (map['DemandRate'] as num?)?.toDouble(),
      billingDate: DateTime.tryParse(map['BillingDate'].toString()),
      serviceDateFrom: DateTime.tryParse(map['ServiceDateFrom'].toString()),
      serviceDateTo: DateTime.tryParse(map['ServiceDateTo'].toString()),
      dueDate: DateTime.tryParse(map['DueDate'].toString()),
      billNumber: map['BillNumber']?.toString(),
      remarks: map['Remarks']?.toString(),
      averageKWH: (map['AverageKWH'] as num?)?.toDouble(),
      averageKWDemand: (map['AverageKWDemand'] as num?)?.toDouble(),
      coreLoss: (map['CoreLoss'] as num?)?.toDouble(),
      meter: map['Meter']?.toString(),
      pr: map['PR']?.toString(),
      sdw: map['SDW']?.toString(),
      others: map['Others']?.toString(),
      ppa: (map['PPA'] as num?)?.toDouble(),
      ppaAmount: (map['PPAAmount'] as num?)?.toDouble(),
      basicAmount: (map['BasicAmount'] as num?)?.toDouble(),
      praDiscount: (map['PRADiscount'] as num?)?.toDouble(),
      praAmount: (map['PRAAmount'] as num?)?.toDouble(),
      fppca: (map['FPPCA'] as num?)?.toDouble(),
      fppcaAmount: (map['FPPCAAmount'] as num?)?.toDouble(),
      ucAmount: (map['UCAmount'] as num?)?.toDouble(),
      ucAmountEC: (map['UCAmountEC'] as num?)?.toDouble(),
      meterNumber: map['MeterNumber']?.toString(),
      consumerType: map['ConsumerType']?.toString(),
      billType: map['BillType']?.toString(),
      qcAmount: (map['QCAmount'] as num?)?.toDouble(),
      epAmount: (map['EPAmount'] as num?)?.toDouble(),
      pcAmount: (map['PCAmount'] as num?)?.toDouble(),
      wacAmount: (map['WACAmount'] as num?)?.toDouble(),
      lcAmount: (map['LCAmount'] as num?)?.toDouble(),
      billingPeriod: map['BillingPeriod']?.toString(),
      keyForSelection: map['KeyForSelection']?.toString(),
      orNumber: map['ORNumber']?.toString(),
      orDate: DateTime.tryParse(map['ORDate'].toString()),
      genSysAmt: (map['GenSysAmt'] as num?)?.toDouble(),
      fbhcAmt: (map['FBHCAmt'] as num?)?.toDouble(),
      fpcaAdjAmt: (map['FPCAAdjAmt'] as num?)?.toDouble(),
      iceraAmt: (map['ICERAAmt'] as num?)?.toDouble(),
      transDemAmt: (map['TransDemAmt'] as num?)?.toDouble(),
      transSysAmt: (map['TransSysAmt'] as num?)?.toDouble(),
      sysLossAmt: (map['SysLossAmt'] as num?)?.toDouble(),
      distribDemAmt: (map['DistribDemAmt'] as num?)?.toDouble(),
      distribSysAmt: (map['DistribSysAmt'] as num?)?.toDouble(),
      supRetCusAmt: (map['SupRetCusAmt'] as num?)?.toDouble(),
      supSysAmt: (map['SupSysAmt'] as num?)?.toDouble(),
      metRetCusAmt: (map['MetRetCusAmt'] as num?)?.toDouble(),
      metSysAmt: (map['MetSysAmt'] as num?)?.toDouble(),
      iccsAmt: (map['ICCSAmt'] as num?)?.toDouble(),
      lifelineSubsidyAmt: (map['LifelineSubsidyAmt'] as num?)?.toDouble(),
      unbundledTag: map['UnbundledTag']?.toString(),
      defAcctgAdjAmt: (map['DefAcctgAdjAmt'] as num?)?.toDouble(),
      vatGenAmt: (map['VATGenAmt'] as num?)?.toDouble(),
      vatTransAmt: (map['VATTransAmt'] as num?)?.toDouble(),
      vatSLAmt: (map['VATSLAmt'] as num?)?.toDouble(),
      vatDistAmt: (map['VATDistAmt'] as num?)?.toDouble(),
      vatOthersAmt: (map['VATOthersAmt'] as num?)?.toDouble(),
      seniorCitizenAmt: (map['SeniorCitizenAmt'] as num?)?.toDouble(),
      seniorCitizenSubsidy: (map['SeniorCitizenSubsidy'] as num?)?.toDouble(),
      strandedCostAmt: (map['StrandedCostAmt'] as num?)?.toDouble(),
      bcAmount: (map['BCAmount'] as num?)?.toDouble(),
      fitAllAmt: (map['FITAllAmt'] as num?)?.toDouble(),
      ogaAmt: (map['OGAAmt'] as num?)?.toDouble(),
      otcaDemAmt: (map['OTCADemAmt'] as num?)?.toDouble(),
      otcaSysAmt: (map['OTCASysAmt'] as num?)?.toDouble(),
      oslaAmt: (map['OSLAAmt'] as num?)?.toDouble(),
      olraAmt: (map['OLRAAmt'] as num?)?.toDouble(),
      npcsd: (map['NPCSD'] as num?)?.toDouble(),
      meredci: (map['MEREDCI'] as num?)?.toDouble(),
      ogaCurr: (map['OGACurr'] as num?)?.toDouble(),
      otcaSysCurr: (map['OTCASysCurr'] as num?)?.toDouble(),
      otcaDemCurr: (map['OTCADemCurr'] as num?)?.toDouble(),
      oslaCurr: (map['OSLACurr'] as num?)?.toDouble(),
      olraCurr: (map['OLRACurr'] as num?)?.toDouble(),
      osrRA: (map['OSRRA'] as num?)?.toDouble(),
      oga3: (map['OGA3'] as num?)?.toDouble(),
      otcaSys3: (map['OTCASys3'] as num?)?.toDouble(),
      otcaDem3: (map['OTCADem3'] as num?)?.toDouble(),
      osla3: (map['OSLA3'] as num?)?.toDouble(),
      olra3: (map['OLRA3'] as num?)?.toDouble(),
      franchiseTax: (map['FranchiseTax'] as num?)?.toDouble(),
      rowguid: map['rowguid']?.toString(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      // Don't set 'id' when inserting a new row — leave it out so SQLite
      // auto-increments. It's included here so updates/copies can carry it.
      if (id != null) 'id': id,
      'is_uploaded': isUploaded ? 1 : 0,
      'ServicePeriodEnd': servicePeriodEnd,
      'AccountNumber': accountNumber,
      'PowerPreviousReading': powerPreviousReading,
      'PowerPresentReading': powerPresentReading,
      'DemandPreviousReading': demandPreviousReading,
      'DemandPresentReading': demandPresentReading,
      'AdditionalKWH': additionalKWH,
      'AdditionalKWDemand': additionalKWDemand,
      'PowerKWH': powerKWH,
      'KWHAmount': kwhAmount,
      'DemandKW': demandKW,
      'KWAmount': kwAmount,
      'Charges': charges,
      'Deductions': deductions,
      'NetAmount': netAmount,
      'PowerRate': powerRate,
      'DemandRate': demandRate,
      'BillingDate': billingDate?.toIso8601String(),
      'ServiceDateFrom': serviceDateFrom?.toIso8601String(),
      'ServiceDateTo': serviceDateTo?.toIso8601String(),
      'DueDate': dueDate?.toIso8601String(),
      'BillNumber': billNumber,
      'Remarks': remarks,
      'AverageKWH': averageKWH,
      'AverageKWDemand': averageKWDemand,
      'CoreLoss': coreLoss,
      'Meter': meter,
      'PR': pr,
      'SDW': sdw,
      'Others': others,
      'PPA': ppa,
      'PPAAmount': ppaAmount,
      'BasicAmount': basicAmount,
      'PRADiscount': praDiscount,
      'PRAAmount': praAmount,
      'FPPCA': fppca,
      'FPPCAAmount': fppcaAmount,
      'UCAmount': ucAmount,
      'UCAmountEC': ucAmountEC,
      'MeterNumber': meterNumber,
      'ConsumerType': consumerType,
      'BillType': billType,
      'QCAmount': qcAmount,
      'EPAmount': epAmount,
      'PCAmount': pcAmount,
      'WACAmount': wacAmount,
      'LCAmount': lcAmount,
      'BillingPeriod': billingPeriod,
      'KeyForSelection': keyForSelection,
      'ORNumber': orNumber,
      'ORDate': orDate?.toIso8601String(),
      'GenSysAmt': genSysAmt,
      'FBHCAmt': fbhcAmt,
      'FPCAAdjAmt': fpcaAdjAmt,
      'ICERAAmt': iceraAmt,
      'TransDemAmt': transDemAmt,
      'TransSysAmt': transSysAmt,
      'SysLossAmt': sysLossAmt,
      'DistribDemAmt': distribDemAmt,
      'DistribSysAmt': distribSysAmt,
      'SupRetCusAmt': supRetCusAmt,
      'SupSysAmt': supSysAmt,
      'MetRetCusAmt': metRetCusAmt,
      'MetSysAmt': metSysAmt,
      'ICCSAmt': iccsAmt,
      'LifelineSubsidyAmt': lifelineSubsidyAmt,
      'UnbundledTag': unbundledTag,
      'DefAcctgAdjAmt': defAcctgAdjAmt,
      'VATGenAmt': vatGenAmt,
      'VATTransAmt': vatTransAmt,
      'VATSLAmt': vatSLAmt,
      'VATDistAmt': vatDistAmt,
      'VATOthersAmt': vatOthersAmt,
      'SeniorCitizenAmt': seniorCitizenAmt,
      'SeniorCitizenSubsidy': seniorCitizenSubsidy,
      'StrandedCostAmt': strandedCostAmt,
      'BCAmount': bcAmount,
      'FITAllAmt': fitAllAmt,
      'OGAAmt': ogaAmt,
      'OTCADemAmt': otcaDemAmt,
      'OTCASysAmt': otcaSysAmt,
      'OSLAAmt': oslaAmt,
      'OLRAAmt': olraAmt,
      'NPCSD': npcsd,
      'MEREDCI': meredci,
      'OGACurr': ogaCurr,
      'OTCASysCurr': otcaSysCurr,
      'OTCADemCurr': otcaDemCurr,
      'OSLACurr': oslaCurr,
      'OLRACurr': olraCurr,
      'OSRRA': osrRA,
      'OGA3': oga3,
      'OTCASys3': otcaSys3,
      'OTCADem3': otcaDem3,
      'OSLA3': osla3,
      'OLRA3': olra3,
      'FranchiseTax': franchiseTax,
      'rowguid': rowguid,
    };
  }

  /// Map used specifically for uploading to the API — excludes the
  /// SQLite-only id/is_uploaded fields.
  Map<String, dynamic> toJson() {
    final map = toMap();
    map.remove('id');
    map.remove('is_uploaded');
    return map;
  }
}
