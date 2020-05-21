class Note{
  int _id;
  String _title;
  String _description;
  String _date;
  int _priority;

  Note(this._title,this._date,this._priority,[this._description]);
  Note.withId(this._title,this._date,this._priority,[this._description]);

  int get id=>_id;

  String get title=>_title;

  String get description=>_description;

  String get date=> _date;

  int get priority=> _priority;

  set title(String newTitle){
    if (newTitle.length<=255) {
      this._title = newTitle;
    }
    }
  set description(String newDescription){
    if (newDescription.length<=255) {
      this._description = newDescription;
    }
  }
  set priority(int newPriority){
    if (newPriority>=1 && newPriority<=2) {
      this._priority = newPriority;
    }
  }

  set date(String newDate){
    this._date=newDate;
  }
//Defining a function that converts it into map objects to be used by database
  Map<String, dynamic> toMap(){

    var map=Map<String, dynamic>();
    if(id!=null) {
      map['id'] = _id;
    }

    map['title']=_title;
    map['date']=_date;
    map['priority']=_priority;
    map['description']=_description;

    return map;

  }
  //extract not object
Note.fromMapObeject(Map<String>, dynamic>map){
    this._id=map['id'];
  this._priority=map['priority'];
  this._description=map['description'];
  this._priority=map['priority'];
  this._date=map['date'];
  }
  }
