# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UpdatedLinkJob, type: :job do
  include ActiveJob::TestHelper

  subject(:job) { described_class.perform_later(link) }

  let(:link_item) { create(:link_item) }
  let(:link) { create(:link, link_items: [link_item]) }

  it 'queues the job' do
    expect { job }.to have_enqueued_job(described_class).with(link)
  end

  it 'executes perform' do
    expect(Telegram::MakeMessageForUpdatedLink).to receive(:call)
      .with(link)
      .and_return('test')

    expect(NotifyTelegramUser).to receive(:call).with(
      user: link.telegram_user,
      photo: link.active_link_item.image,
      raw_link: link.link,
      message: 'test'
    )

    perform_enqueued_jobs { job }
  end
end
