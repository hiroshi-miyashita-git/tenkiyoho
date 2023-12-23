require 'mongo'
class Prefecture
  #このクラスでMongoDBのコレクションに接続できるようにする定義
  def self.collection
    #@clientの定義が無い場合、Mongo::Clientオブジェクトを作成
    @client ||= Mongo::Client.new(ENV['MONGODB_URI'])
    #prefecturesコレクションに関連付け
    @client[:prefectures]
  end
  def self.all
    #特定のコレクションの全てのドキュメントを取得して配列に変換
    collection.find.to_a
  end
end
