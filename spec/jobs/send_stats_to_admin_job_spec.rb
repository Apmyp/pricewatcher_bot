# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SendStatsToAdminJob, type: :job do
  include ActiveJob::TestHelper

  let(:user) { create(:telegram_user, role: :admin) }
  subject(:job) { described_class.perform_later(user) }

  it 'queues the job' do
    expect { job }.to have_enqueued_job(described_class)
  end

  it 'executes perform' do
    expect(NotifyTelegramUser).to receive(:call)

    perform_enqueued_jobs { job }
  end
end
