class RateModel {
  final String consumerType;
  final DateTime servicePeriodEnd;
  final double? lifelineLevel;
  final double genSysCharge;
  final double? fbhcCharge;
  final double? fpcaAdjCharge;
  final double? icera;
  final double? ogaCharge;
  final double? ogaCurrCharge;
  final double sysLossCharge;
  final double? oslaCharge;
  final double? oslaCurrCharge;
  final double? transDemCharge;
  final double? otcaDemCharge;
  final double? otcaDemCurrCharge;
  final double transSysCharge;
  final double otcaSysCharge;
  final double? otcaSysCurrCharge;
  final double? distribDemCharge;
  final double distribSysCharge;
  final double supplyRetCusCharge;
  final double? supplySysCharge;
  final double metRetCusCharge;
  final double? metSysCharge;
  final double? par;
  final double loanCondonation;
  final double lifeLineRateSubsidy;
  final double? olraCharge;
  final double? olraCurrCharge;
  final double seniorCitizenSubsidy;
  final double? osrRACharge;
  final double? iccsCharge;
  final double vatGen;
  final double vatTrans;
  final double vatSL;
  final double vatDist;
  final double vatOthers;
  final double ucMissElecCharge;
  final double meredciCharge;
  final double ucEnvCharge;
  final double? strandedCost;
  final double npcsdCharge;
  final double fitAllCharge;
  final double? defAcctgAdj;
  final double? ppaCharge;
  final double? oga3Charge;
  final double? otcaSys3Charge;
  final double? otcaDem3Charge;
  final double? osla3Charge;
  final double? olra3Charge;
  final double? realPropertyTax;
  final double? franchiseTax;

  RateModel({
    required this.consumerType,
    required this.servicePeriodEnd,
    this.lifelineLevel,
    required this.genSysCharge,
    this.fbhcCharge,
    this.fpcaAdjCharge,
    this.icera,
    this.ogaCharge,
    this.ogaCurrCharge,
    required this.sysLossCharge,
    this.oslaCharge,
    this.oslaCurrCharge,
    this.transDemCharge,
    this.otcaDemCharge,
    this.otcaDemCurrCharge,
    required this.transSysCharge,
    required this.otcaSysCharge,
    this.otcaSysCurrCharge,
    this.distribDemCharge,
    required this.distribSysCharge,
    required this.supplyRetCusCharge,
    this.supplySysCharge,
    required this.metRetCusCharge,
    this.metSysCharge,
    this.par,
    required this.loanCondonation,
    required this.lifeLineRateSubsidy,
    this.olraCharge,
    this.olraCurrCharge,
    required this.seniorCitizenSubsidy,
    this.osrRACharge,
    this.iccsCharge,
    required this.vatGen,
    required this.vatTrans,
    required this.vatSL,
    required this.vatDist,
    required this.vatOthers,
    required this.ucMissElecCharge,
    required this.meredciCharge,
    required this.ucEnvCharge,
    this.strandedCost,
    required this.npcsdCharge,
    required this.fitAllCharge,
    this.defAcctgAdj,
    this.ppaCharge,
    this.oga3Charge,
    this.otcaSys3Charge,
    this.otcaDem3Charge,
    this.osla3Charge,
    this.olra3Charge,
    this.realPropertyTax,
    this.franchiseTax,
  });

  // Used by API
  factory RateModel.fromJson(Map<String, dynamic> json) {
    return RateModel(
      consumerType: json['ConsumerType']?.toString() ?? '',
      servicePeriodEnd:
          DateTime.tryParse(json['ServicePeriodEnd'].toString()) ??
          DateTime.now(),
      lifelineLevel: (json['LifelineLevel'] as num?)?.toDouble(),
      genSysCharge: (json['GenSysCharge'] as num?)?.toDouble() ?? 0.0,
      fbhcCharge: (json['FBHCCharge'] as num?)?.toDouble(),
      fpcaAdjCharge: (json['FPCAAdjCharge'] as num?)?.toDouble(),
      icera: (json['ICERA'] as num?)?.toDouble(),
      ogaCharge: (json['OGACharge'] as num?)?.toDouble(),
      ogaCurrCharge: (json['OGACurrCharge'] as num?)?.toDouble(),
      sysLossCharge: (json['SysLossCharge'] as num?)?.toDouble() ?? 0.0,
      oslaCharge: (json['OSLACharge'] as num?)?.toDouble(),
      oslaCurrCharge: (json['OSLACurrCharge'] as num?)?.toDouble(),
      transDemCharge: (json['TransDemCharge'] as num?)?.toDouble(),
      otcaDemCharge: (json['OTCADemCharge'] as num?)?.toDouble(),
      otcaDemCurrCharge: (json['OTCADemCurrCharge'] as num?)?.toDouble(),
      transSysCharge: (json['TransSysCharge'] as num?)?.toDouble() ?? 0.0,
      otcaSysCharge: (json['OTCASysCharge'] as num?)?.toDouble() ?? 0.0,
      otcaSysCurrCharge: (json['OTCASysCurrCharge'] as num?)?.toDouble(),
      distribDemCharge: (json['DistribDemCharge'] as num?)?.toDouble(),
      distribSysCharge: (json['DistribSysCharge'] as num?)?.toDouble() ?? 0.0,
      supplyRetCusCharge:
          (json['SupplyRetCusCharge'] as num?)?.toDouble() ?? 0.0,
      supplySysCharge: (json['SupplySysCharge'] as num?)?.toDouble(),
      metRetCusCharge: (json['MetRetCusCharge'] as num?)?.toDouble() ?? 0.0,
      metSysCharge: (json['MetSysCharge'] as num?)?.toDouble(),
      par: (json['PAR'] as num?)?.toDouble(),
      loanCondonation: (json['LoanCondonation'] as num?)?.toDouble() ?? 0.0,
      lifeLineRateSubsidy:
          (json['LifeLineRateSubsidy'] as num?)?.toDouble() ?? 0.0,
      olraCharge: (json['OLRACharge'] as num?)?.toDouble(),
      olraCurrCharge: (json['OLRACurrCharge'] as num?)?.toDouble(),
      seniorCitizenSubsidy:
          (json['SeniorCitizenSubsidy'] as num?)?.toDouble() ?? 0.0,
      osrRACharge: (json['OSrRACharge'] as num?)?.toDouble(),
      iccsCharge: (json['ICCSCharge'] as num?)?.toDouble(),
      vatGen: (json['VATGen'] as num?)?.toDouble() ?? 0.0,
      vatTrans: (json['VATTrans'] as num?)?.toDouble() ?? 0.0,
      vatSL: (json['VATSL'] as num?)?.toDouble() ?? 0.0,
      vatDist: (json['VATDist'] as num?)?.toDouble() ?? 0.0,
      vatOthers: (json['VATOthers'] as num?)?.toDouble() ?? 0.0,
      ucMissElecCharge: (json['UCMissElecCharge'] as num?)?.toDouble() ?? 0.0,
      meredciCharge: (json['MEREDCICharge'] as num?)?.toDouble() ?? 0.0,
      ucEnvCharge: (json['UCEnvCharge'] as num?)?.toDouble() ?? 0.0,
      strandedCost: (json['StrandedCost'] as num?)?.toDouble(),
      npcsdCharge: (json['NPCSDCharge'] as num?)?.toDouble() ?? 0.0,
      fitAllCharge: (json['FITAllCharge'] as num?)?.toDouble() ?? 0.0,
      defAcctgAdj: (json['DefAcctgAdj'] as num?)?.toDouble(),
      ppaCharge: (json['PPACharge'] as num?)?.toDouble(),
      oga3Charge: (json['OGA3Charge'] as num?)?.toDouble(),
      otcaSys3Charge: (json['OTCASys3Charge'] as num?)?.toDouble(),
      otcaDem3Charge: (json['OTCADem3Charge'] as num?)?.toDouble(),
      osla3Charge: (json['OSLA3Charge'] as num?)?.toDouble(),
      olra3Charge: (json['OLRA3Charge'] as num?)?.toDouble(),
      realPropertyTax: (json['RealPropertyTax'] as num?)?.toDouble(),
      franchiseTax: (json['FranchiseTax'] as num?)?.toDouble(),
    );
  }

  // Used by SQLite
  factory RateModel.fromMap(Map<String, dynamic> map) {
    return RateModel(
      consumerType: map['ConsumerType']?.toString() ?? '',
      servicePeriodEnd:
          DateTime.tryParse(map['ServicePeriodEnd'].toString()) ??
          DateTime.now(),
      lifelineLevel: (map['LifelineLevel'] as num?)?.toDouble(),
      genSysCharge: (map['GenSysCharge'] as num?)?.toDouble() ?? 0.0,
      fbhcCharge: (map['FBHCCharge'] as num?)?.toDouble(),
      fpcaAdjCharge: (map['FPCAAdjCharge'] as num?)?.toDouble(),
      icera: (map['ICERA'] as num?)?.toDouble(),
      ogaCharge: (map['OGACharge'] as num?)?.toDouble(),
      ogaCurrCharge: (map['OGACurrCharge'] as num?)?.toDouble(),
      sysLossCharge: (map['SysLossCharge'] as num?)?.toDouble() ?? 0.0,
      oslaCharge: (map['OSLACharge'] as num?)?.toDouble(),
      oslaCurrCharge: (map['OSLACurrCharge'] as num?)?.toDouble(),
      transDemCharge: (map['TransDemCharge'] as num?)?.toDouble(),
      otcaDemCharge: (map['OTCADemCharge'] as num?)?.toDouble(),
      otcaDemCurrCharge: (map['OTCADemCurrCharge'] as num?)?.toDouble(),
      transSysCharge: (map['TransSysCharge'] as num?)?.toDouble() ?? 0.0,
      otcaSysCharge: (map['OTCASysCharge'] as num?)?.toDouble() ?? 0.0,
      otcaSysCurrCharge: (map['OTCASysCurrCharge'] as num?)?.toDouble(),
      distribDemCharge: (map['DistribDemCharge'] as num?)?.toDouble(),
      distribSysCharge: (map['DistribSysCharge'] as num?)?.toDouble() ?? 0.0,
      supplyRetCusCharge:
          (map['SupplyRetCusCharge'] as num?)?.toDouble() ?? 0.0,
      supplySysCharge: (map['SupplySysCharge'] as num?)?.toDouble(),
      metRetCusCharge: (map['MetRetCusCharge'] as num?)?.toDouble() ?? 0.0,
      metSysCharge: (map['MetSysCharge'] as num?)?.toDouble(),
      par: (map['PAR'] as num?)?.toDouble(),
      loanCondonation: (map['LoanCondonation'] as num?)?.toDouble() ?? 0.0,
      lifeLineRateSubsidy:
          (map['LifeLineRateSubsidy'] as num?)?.toDouble() ?? 0.0,
      olraCharge: (map['OLRACharge'] as num?)?.toDouble(),
      olraCurrCharge: (map['OLRACurrCharge'] as num?)?.toDouble(),
      seniorCitizenSubsidy:
          (map['SeniorCitizenSubsidy'] as num?)?.toDouble() ?? 0.0,
      osrRACharge: (map['OSrRACharge'] as num?)?.toDouble(),
      iccsCharge: (map['ICCSCharge'] as num?)?.toDouble(),
      vatGen: (map['VATGen'] as num?)?.toDouble() ?? 0.0,
      vatTrans: (map['VATTrans'] as num?)?.toDouble() ?? 0.0,
      vatSL: (map['VATSL'] as num?)?.toDouble() ?? 0.0,
      vatDist: (map['VATDist'] as num?)?.toDouble() ?? 0.0,
      vatOthers: (map['VATOthers'] as num?)?.toDouble() ?? 0.0,
      ucMissElecCharge: (map['UCMissElecCharge'] as num?)?.toDouble() ?? 0.0,
      meredciCharge: (map['MEREDCICharge'] as num?)?.toDouble() ?? 0.0,
      ucEnvCharge: (map['UCEnvCharge'] as num?)?.toDouble() ?? 0.0,
      strandedCost: (map['StrandedCost'] as num?)?.toDouble(),
      npcsdCharge: (map['NPCSDCharge'] as num?)?.toDouble() ?? 0.0,
      fitAllCharge: (map['FITAllCharge'] as num?)?.toDouble() ?? 0.0,
      defAcctgAdj: (map['DefAcctgAdj'] as num?)?.toDouble(),
      ppaCharge: (map['PPACharge'] as num?)?.toDouble(),
      oga3Charge: (map['OGA3Charge'] as num?)?.toDouble(),
      otcaSys3Charge: (map['OTCASys3Charge'] as num?)?.toDouble(),
      otcaDem3Charge: (map['OTCADem3Charge'] as num?)?.toDouble(),
      osla3Charge: (map['OSLA3Charge'] as num?)?.toDouble(),
      olra3Charge: (map['OLRA3Charge'] as num?)?.toDouble(),
      realPropertyTax: (map['RealPropertyTax'] as num?)?.toDouble(),
      franchiseTax: (map['FranchiseTax'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'ConsumerType': consumerType,
      'ServicePeriodEnd': servicePeriodEnd.toIso8601String(),
      'LifelineLevel': lifelineLevel,
      'GenSysCharge': genSysCharge,
      'FBHCCharge': fbhcCharge,
      'FPCAAdjCharge': fpcaAdjCharge,
      'ICERA': icera,
      'OGACharge': ogaCharge,
      'OGACurrCharge': ogaCurrCharge,
      'SysLossCharge': sysLossCharge,
      'OSLACharge': oslaCharge,
      'OSLACurrCharge': oslaCurrCharge,
      'TransDemCharge': transDemCharge,
      'OTCADemCharge': otcaDemCharge,
      'OTCADemCurrCharge': otcaDemCurrCharge,
      'TransSysCharge': transSysCharge,
      'OTCASysCharge': otcaSysCharge,
      'OTCASysCurrCharge': otcaSysCurrCharge,
      'DistribDemCharge': distribDemCharge,
      'DistribSysCharge': distribSysCharge,
      'SupplyRetCusCharge': supplyRetCusCharge,
      'SupplySysCharge': supplySysCharge,
      'MetRetCusCharge': metRetCusCharge,
      'MetSysCharge': metSysCharge,
      'PAR': par,
      'LoanCondonation': loanCondonation,
      'LifeLineRateSubsidy': lifeLineRateSubsidy,
      'OLRACharge': olraCharge,
      'OLRACurrCharge': olraCurrCharge,
      'SeniorCitizenSubsidy': seniorCitizenSubsidy,
      'OSrRACharge': osrRACharge,
      'ICCSCharge': iccsCharge,
      'VATGen': vatGen,
      'VATTrans': vatTrans,
      'VATSL': vatSL,
      'VATDist': vatDist,
      'VATOthers': vatOthers,
      'UCMissElecCharge': ucMissElecCharge,
      'MEREDCICharge': meredciCharge,
      'UCEnvCharge': ucEnvCharge,
      'StrandedCost': strandedCost,
      'NPCSDCharge': npcsdCharge,
      'FITAllCharge': fitAllCharge,
      'DefAcctgAdj': defAcctgAdj,
      'PPACharge': ppaCharge,
      'OGA3Charge': oga3Charge,
      'OTCASys3Charge': otcaSys3Charge,
      'OTCADem3Charge': otcaDem3Charge,
      'OSLA3Charge': osla3Charge,
      'OLRA3Charge': olra3Charge,
      'RealPropertyTax': realPropertyTax,
      'FranchiseTax': franchiseTax,
    };
  }

  double get generationRate {
    return genSysCharge +
        (ogaCharge ?? 0.0) +
        (ogaCurrCharge ?? 0.0) +
        (oga3Charge ?? 0.0) +
        sysLossCharge +
        (oslaCharge ?? 0.0) +
        (oslaCurrCharge ?? 0.0) +
        (osla3Charge ?? 0.0) +
        (fbhcCharge ?? 0.0) +
        (otcaDemCharge ?? 0.0) +
        (otcaDemCurrCharge ?? 0.0) +
        (otcaDem3Charge ?? 0.0) +
        transSysCharge +
        otcaSysCharge +
        (otcaSysCurrCharge ?? 0.0) +
        (otcaSys3Charge ?? 0.0) +
        distribSysCharge +
        (supplySysCharge ?? 0.0) +
        (metSysCharge ?? 0.0) +
        (par ?? 0.0) +
        loanCondonation +
        lifeLineRateSubsidy +
        (olraCharge ?? 0.0) +
        (olraCurrCharge ?? 0.0) +
        (olra3Charge ?? 0.0) +
        seniorCitizenSubsidy +
        vatGen +
        vatTrans +
        vatSL +
        vatDist +
        vatOthers +
        ucMissElecCharge +
        meredciCharge +
        ucEnvCharge +
        (strandedCost ?? 0.0) +
        npcsdCharge +
        fitAllCharge +
        (realPropertyTax ?? 0.0) +
        (franchiseTax ?? 0.0);
  }
}
