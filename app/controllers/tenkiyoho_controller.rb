require 'net/http'
class TenkiyohoController < ApplicationController
  def index
    @prefecture = Prefecture.all
    if params[:prefecture_code].present?
       @initial_value = params[:prefecture_code]
       call_api(params[:prefecture_code])
    else
      @initial_value = nil
    end
  end
  private
  def call_api(prefecture_code)
    api_url = "https://www.jma.go.jp/bosai/forecast/data/overview_forecast/" + prefecture_code + ".json"
    url = URI.parse(api_url)
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true # HTTPSを使用する場合はtrueに設定
    request = Net::HTTP::Get.new(url.request_uri)
    # request['Authorization'] = 'Bearer YOUR_ACCESS_TOKEN' # APIキーなどの認証情報をヘッダーに追加する場合
    puts "api request  : #{api_url}"
    response = http.request(request)
    if response.code == '200'
      result = JSON.parse(response.body)
      puts "api response : #{result}"
      @publishing_office = result["publishingOffice"]
      @report_datetime   = DateTime.parse(result["reportDatetime"]).strftime('%Y年%m月%d日 %H時%M分')
      @target_area       = result["targetArea"]
      @headline_text     = result["headlineText"]
      @text              = result["text"].gsub("\n\n", "<br>")     
    end
  end
end
