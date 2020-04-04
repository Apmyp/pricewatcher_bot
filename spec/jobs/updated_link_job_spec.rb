require 'rails_helper'

RSpec.describe UpdatedLinkJob, type: :job do
  include ActiveJob::TestHelper

  subject(:job) { described_class.perform_later(link) }

  let(:link) { create(:link) }

  it 'queues the job' do
    expect { job }.to have_enqueued_job(described_class).with(link)
  end

  it 'executes perform' do
    expect(Telegram::MakeMessageForUpdatedLink).to receive(:call).with(link).and_return('test')
    expect(NotifyTelegramUser).to receive(:call).with(link.telegram_user, 'test')

    perform_enqueued_jobs { job }
  end
end
