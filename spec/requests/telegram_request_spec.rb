# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TelegramController, type: :request, telegram_bot: :rails do
  def reply
    bot.requests[:sendMessage].last
  end

  let(:user) { create(:telegram_user, external_id: from_id) }

  describe '#start!' do
    subject { -> { dispatch_command :start } }
    it { should respond_with_message(/Ценослед/) }
  end

  describe '#stats!' do
    context 'user' do
      subject { -> { dispatch_command :stats } }
      it { should respond_with_message(/Ценослед/) }
    end

    context 'admin' do
      let(:from_id) { 1337 }
      let!(:user) { create(:telegram_user, external_id: from_id, role: :admin) }

      subject { -> { dispatch_command :stats } }
      it { should respond_with_message(/Пользователей:\s/) }
    end
  end

  describe '#mylinks!' do
    context 'with links' do
      let!(:links) { create_list(:link, 2, telegram_user: user) }

      subject { -> { dispatch_command :mylinks } }

      it 'shows keyboard' do
        should respond_with_message(/Выбери ссылку/)
        expect(reply[:reply_markup]).to be_present
      end
    end

    context 'without links' do
      subject { -> { dispatch_command :mylinks } }

      it 'shows keyboard' do
        should respond_with_message(/Дружище, ссылок-то пока и нет/)
        expect(reply[:reply_markup]).to be_present
      end
    end

    context 'link clicked', :callback_query do
      let!(:link) { create(:link, telegram_user: user) }

      let(:data) { "link:#{link.id}" }
      it { should respond_with_message(/#{link.hash_id}/) }
    end
  end

  describe '#newlink!' do
    context 'no params' do
      subject { -> { dispatch_command :newlink } }
      it { should respond_with_message(/Отправь мне ссылку на товар/) }
    end

    context 'with link' do
      subject { -> { dispatch_command :newlink, 'https://example.com/path' } }
      it { should respond_with_message(/Я запомнил ссылку/) }
    end
  end

  describe 'callback_query:links', :callback_query do
    let(:data) { 'links' }

    it 'shows keyboard' do
      should respond_with_message(/Дружище, ссылок-то пока и нет/)
      expect(reply[:reply_markup]).to be_present
    end
  end

  describe 'callback_query:destroy_link', :callback_query do
    let!(:link) { create(:link, telegram_user: user) }

    let(:data) { "destroy_link:#{link.id}" }

    it 'shows keyboard' do
      should respond_with_message(/Одна ссылка — не предел/)
      expect(reply[:reply_markup]).to be_present
      expect(link.reload).to be_disabled
    end
  end

  describe 'callback_query:create_link', :callback_query do
    let(:data) { 'create_link' }

    it 'shows keyboard' do
      should respond_with_message(/Отправь мне ссылку на товар/)
    end
  end
end
