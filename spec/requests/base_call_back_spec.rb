require 'rails_helper'

RSpec.describe BaseCallbackController, type: :request do
  describe '#callback' do
    let!(:user){ create(:user) }
    let!(:base_client) { create(:base_client, user: user) }

    subject do
      get base_callback_path, params: params
    end

    context '未ログイン時' do
      let(:params) {{}}

      it 'ログイン画面にリダイレクトされる' do
        subject
        expect(response).to redirect_to(sign_in_path)
      end
    end

    context 'ログイン時' do
      let!(:registered_user) do
        create :registered_user,
               user: user,
               mail_address: 'hoge@example.com',
               password: 'password'
      end

      before :each do
        login_params = {
          registered_user: {
            mail_address: 'hoge@example.com',
            password: 'password',
          }
        }
        post sign_in_path, params: login_params
      end

      context 'codeの値が空' do
        let(:params) do
          { state: base_client.auth_state }
        end

        it 'TOP画面にリダイレクトされる' do
          subject
          expect(response).to redirect_to(root_path)
        end
      end

      context 'stateの値が空' do
        let(:params) do
          { code: 'fr89ea12grwa53gr1aet560k' }
        end

        it 'TOP画面にリダイレクトされる' do
          subject
          expect(response).to redirect_to(root_path)
        end
      end

      context 'stateの値が不正' do
        let(:params) do
          { code: 'fr89ea12grwa53gr1aet560k', state: 'invalidstate' }
        end

        it 'TOP画面にリダイレクトされる' do
          subject
          expect(response).to redirect_to(root_path)
        end
      end

      context 'stateとcodeが正常' do
        let(:response_body) do
          {
            "access_token" => "vfsgaergwa821435w4yw4",
            "token_type" => "bearer",
            "expires_in" => 3600,
            "refresh_token"=>"fsehtre32qroq3e345bsdgarj"
          }
        end

        let(:params) do
          { code: 'fr89ea12grwa53gr1aet560k', state: base_client.auth_state }
        end

        before :each do
          request_object = HTTParty::Request.new Net::HTTP::Post, ''
          response_object = Net::HTTPOK.new('1.1', 200, 'OK')
          allow(response_object).to receive_messages(body: '')
          parsed_response = HTTParty::Response.new(request_object, response_object, -> { response_body })
          allow(BaseClientService).to receive(:post).and_return(parsed_response)
        end

        it 'access_tokenが保存され、TOP画面へリダイレクトされる' do
          subject
          expect(response).to redirect_to(root_path)
          expect(base_client.reload.code).to eq params[:code]
        end
      end
    end
  end
end
