

class Sale {
  int? _saleId;
  DateTime? _saleDateTime;
  int? _serviceId;
  int?_empId;
  int? _userId;
  int? _amount;
  int?_cusId;

  Sale(this._amount, this._cusId, this._empId, this._saleId, this._serviceId,
      this._userId, this._saleDateTime);

  Sale.map(dynamic obj) {
    this._saleId = obj['saleId'];
    this._saleDateTime=obj['saleDateTime'];
    this._serviceId = obj['serviceId'];

    this._empId = obj['empId'];

    this._userId = obj['userId'];

    this._amount = obj['amount'];
  }

  int? get saleId => _saleId;
  
  int? get serviceId => _serviceId;
  int? get empId => _empId;
  int? get userId=> _userId;
  int? get amount=>_amount;
  int? get cusId=> _cusId;

  Map<String,dynamic> toMap(){
    var map=new Map<String,dynamic>();
    map['saleId']=_saleId;
    map['serviceId']=_serviceId;
    map['empId']=_empId;
    map['userId']=_userId;
    map['amount']=_amount;
    map['cusId']=_cusId;
    return map;
  }
}
