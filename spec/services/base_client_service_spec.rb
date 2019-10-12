require 'rails_helper'

RSpec.describe BaseClientService, type: :service do
  describe '#login' do
    context 'apiのレスポンスが正常(status:200)な場合' do
      before :each do
        request_object = HTTParty::Request.new Net::HTTP::Post, ''
        response_object = Net::HTTPOK.new('1.1', 200, 'OK')
        allow(response_object).to receive_messages(body: '')
        parsed_response = HTTParty::Response.new(request_object, response_object, -> { response_body })
        allow(BaseClientService).to receive(:post).and_return(parsed_response)
      end

      let(:response_body) do
        {
          "access_token" => "vfsgaergwa821435w4yw4",
          "token_type" => "bearer",
          "expires_in" => 3600,
          "refresh_token"=>"fsehtre32qroq3e345bsdgarj"
        }
      end

      let!(:base_client) { create(:base_client) }

      it 'アクセス・トークンが保存される' do
        BaseClientService.new(base_client).login
        expect(base_client.reload.access_token).to eq response_body['access_token']
      end
    end

    context 'apiのレスポンスが不正(status:400)な場合' do
      before :each do
        request_object = HTTParty::Request.new Net::HTTP::Post, ''
        allow(response_object).to receive_messages(body: '')
        parsed_response = HTTParty::Response.new(request_object, response_object, -> { response_body })
        allow(BaseClientService).to receive(:post).and_return(parsed_response)
      end
      let(:response_object) { Net::HTTPResponse.new("1.1", 400, '') }
      let(:response_body) do
        {
          "error" => "invalid_request",
          "error_description" => "認可コードの有効期限が切れています。"
        }
      end

      it '例外を投げる' do
        expect{
          BaseClientService.new(base_client).login
        }.to raise_error(StandardError)
      end
    end
  end
end
