# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ParseLinkJob, type: :job do
  include ActiveJob::TestHelper

  subject(:job) { described_class.perform_later(link) }

  let(:link) { create(:link) }
  let(:link_item) { create(:link_item) }

  it 'queues the job' do
    expect { job }.to have_enqueued_job(described_class).with(link)
  end

  it 'executes perform and updated link when changes parsed' do
    expect(Links::PerformLink).to receive(:call).with(link).and_return([link_item, nil])
    expect(UpdatedLinkJob).to receive(:perform_later).with(link)

    perform_enqueued_jobs { job }
  end

  it 'executes only perform when no changes parsed' do
    expect(Links::PerformLink).to receive(:call).with(link).and_return([nil, nil])
    expect(UpdatedLinkJob).to_not receive(:perform_later).with(link)

    perform_enqueued_jobs { job }
  end
end
