class AccountUser {
  String _imageUrl;
  String _name;
  String _mail;
  bool _status;

  AccountUser(this._imageUrl, this._name, this._mail, this._status);
  
  String get image => _imageUrl;
  String get name => _name;
  String get mail => _mail;
  bool get status => _status;

  set image(String value) => _imageUrl = value;
  set name(String value) => _name = value;
  set mail(String value) => _mail = value;
  set status(bool value) => _status = value;
}