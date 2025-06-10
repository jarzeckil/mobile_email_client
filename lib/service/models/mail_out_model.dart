class MailOutModel{

  final _title;
  final _body;
  final _to;

  MailOutModel(this._title, this._body, this._to);

  get to => _to;

  get body => _body;

  get title => _title;
}