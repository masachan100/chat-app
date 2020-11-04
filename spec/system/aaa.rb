require "rails_helper"

RSpec.describe "messe-jitoukoukinou", type: :system do
  before do
    @room_user = FactoryBot.create(:room_user)
  end
  
  context "toukounisippaisitatoki" do
    it "okuruataigakara,sippai" do
      sign_in(@room_user.user)
      click_on(@room_user.room.name)
      expect{
        find("input[name='commit']").click_on
      }.not_to change {Message.count}
      expect(current_path).to eq room_messages_path(@room_user.room)
    end
  end context '投稿に成功したとき' do
    it 'テキストの投稿に成功すると、投稿一覧に遷移して、投稿した内容が表示されている' do
      # サインインする
      sign_in(@room_user.user)

      # 作成されたチャットルームへ遷移する
      click_on(@room_user.room.name)

      # 値をテキストフォームに入力する
      post = "test"
      fill_in "message_content", with: post

      # 送信した値がDBに保存されていることを確認する
      expect{
        find("input[name='commit']").click
      }.to change {Message.count}.by(1)

      # 投稿一覧画面に遷移していることを確認する
      expect(current_path).to eq room_messages_path(@room_user.room)

      # 送信した値がブラウザに表示されていることを確認する
      expect(page).to have_content(post)
    end


end