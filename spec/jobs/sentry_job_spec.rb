# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SentryJob, type: :job do
  include ActiveJob::TestHelper

  subject(:job) { described_class.perform_later(1) }

  it 'queues the job' do
    expect { job }.to have_enqueued_job(described_class)
  end

  it 'executes perform' do
    expect(Raven).to receive(:send_event)

    perform_enqueued_jobs { job }
  end
end
