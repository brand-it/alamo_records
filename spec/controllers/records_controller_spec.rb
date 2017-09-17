# frozen_string_literal: true

require 'rails_helper'

describe RecordsController, type: :controller do
  render_views

  let(:record) { create :record }
  let(:build_record) { build :record }

  let(:valid_create_params) { build_record.attributes }
  let(:invalid_create_params) { { title: nil } } # name is place holder fill in something that will raise a validation error

  let(:valid_update_params) { build_record.attributes }
  let(:invalid_update_params) { { title: nil } } # name is place holder fill in something that will raise a validation error

  describe 'GET #index' do
    subject { get :index }
    it { expect(subject).to be_success }
    it { expect(subject).to render_template :index }
  end

  describe 'GET #show' do
    subject { get :show, params: { id: record.id } }
    it { expect(subject).to be_success }
    it { expect(subject).to render_template :show }
  end

  describe 'GET #new' do
    subject { get :new }
    it { expect(subject).to be_success }
    it { expect(subject).to render_template :new }
  end
  describe 'GET #edit' do
    subject { get :edit, params: { id: record.id } }
    it { expect(subject).to be_success }
    it { expect(subject).to render_template :edit }
  end

  describe 'POST #create' do
    context 'with valid params' do
      subject { post :create, params: { record: valid_create_params } }
      it { expect { subject }.to change(Record, :count).by(1) }
      it { expect(subject).to redirect_to(assigns(:record)) }
    end

    context 'with invalid params' do
      subject { post :create, params: { record: invalid_create_params } }
      it { expect(subject).to render_template :new }
    end
  end

  describe 'PUT #update' do
    before { record } # create record to update
    context 'with valid params' do
      subject { put :update, params: { id: record.id, record: valid_update_params } }
      it { expect(subject).to redirect_to(record) }
      it { expect(subject).to_not render_template :edit }
    end
    context 'with invalid params' do
      subject { put :update, params: { id: record.id, record: invalid_update_params } }
      it { expect(subject).to render_template :edit }
    end
  end

  describe 'DELETE #destroy' do
    before { record } # create record to destroy first
    subject { delete :destroy, params: { id: record.id } }
    it { expect(subject).to redirect_to(Record) }
    it { expect { subject }.to change(Record, :count).by(-1) }
  end
end
