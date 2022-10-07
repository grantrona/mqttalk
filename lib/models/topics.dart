/// List of topics a MQTT client can subscribe to
class Topics {

  List<String> topics= ["General", "News", "Music", "Movies", "Books", "Travel"];

  void setTopics(List<String> topics) {
    this.topics = topics;
  }

  List<String> getTopics() {
    return topics;
  }
}