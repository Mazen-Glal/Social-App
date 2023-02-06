class MessageModel{
  late String? text;
  late String? senderId;
  late String? receiverId;
  late String? dateTime;

  MessageModel({
    this.text,
    this.senderId,
    this.receiverId,
    this.dateTime,
  });


  MessageModel.fromJson(Map<String,dynamic>? json){
    senderId = json!['senderId'];
    text = json['text'];
    receiverId = json['receiverId'];
    dateTime = json['dateTime'];
  }

  Map<String,dynamic> toMap(){
    return {
      'senderId'     :senderId,
      'text'      :text,
      'receiverId'     :receiverId,
      'dateTime'       :dateTime,
    };
  }
}