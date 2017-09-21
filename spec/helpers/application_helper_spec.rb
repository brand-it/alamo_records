# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe '#export_csv' do
    subject { export_csv(Artist) }
    it { expect { subject }.to_not raise_error }
  end


  describe '#sortable_link_to' do
    before { allow(helper).to receive(:params).and_return(ActionController::Parameters.new(controller: 'artists')) }

    context 'sort direction should default to unsorted when it is not the order key' do
      subject { helper.sortable('Updated At', order_by_key: :updated_at, type: :alpha) }
      it { is_expected.to match(/sort/) }
      it { is_expected.to_not match(/sort-alpha/) }
      it { is_expected.to_not match(/sort-asc/) }
      it { is_expected.to_not match(/sort-desc/) }
    end
    context 'icon order_by with out type and no order' do
      subject { helper.sortable('Name', order_by_key: :name) }
      it { is_expected.to match(/Name/) }
      it { is_expected.to match(/sort/) }
      it { is_expected.to_not match(/sort-asc/) }
      it { is_expected.to_not match(/sort-desc/) }
    end

    context 'name' do
      subject { helper.sortable('Updated At', order_by_key: :updated_at) }
      it { is_expected.to match(/Updated At/) }
    end

    context 'order by asc' do
      subject { helper.sortable('Updated At', order_by_key: :updated_at, default_order: :asc) }
      it { is_expected.to match(/direction%5D=desc/) }
      it { is_expected.to match(/sort-asc/) }
    end

    context 'path as class object' do
      subject { helper.sortable('Updated At', order_by_key: :updated_at, default_order: :desc) }
      it { is_expected.to match(/direction%5D=asc/) }
    end
    context 'path is a object' do
      subject { helper.sortable('Updated At', order_by_key: :updated_at, default_order: :desc) }
      it { is_expected.to match(/direction%5D=asc/) }
    end

    context 'path as string' do
      subject { helper.sortable('Updated At', order_by_key: :updated_at, default_order: :desc) }
      it { is_expected.to match(/direction%5D=asc/) }
    end

    context 'path is a route method' do
      subject { helper.sortable('Updated At', order_by_key: :updated_at, default_order: :desc) }
      it { is_expected.to match(/direction%5D=asc/) }
    end

    context 'type' do
      subject { helper.sortable('Updated At', order_by_key: :updated_at, type: :numeric) }
      it { is_expected.to match(/sort/) }
      it { is_expected.to_not match(/sort-numeric/) }
      it { is_expected.to_not match(/sort-numeric-asc/) }
      it { is_expected.to_not match(/sort-numeric-desc/) }
    end
  end
end
