# frozen_string_literal: true

require 'rails_helper'

describe ArtistsController, type: :controller do
  render_views

  let(:artist) { create :artist }
  let(:build_artist) { build :artist }

  let(:valid_create_params) { build_artist.attributes }
  let(:invalid_create_params) { { name: nil } } # name is place holder fill in something that will raise a validation error

  let(:valid_update_params) { build_artist.attributes }
  let(:invalid_update_params) { { name: nil } } # name is place holder fill in something that will raise a validation error

  describe 'GET #index' do
    subject { get :index }
    it { expect(subject).to be_success }
    it { expect(subject).to render_template :index }
  end

  describe 'GET #show' do
    subject { get :show, params: { id: artist.id } }
    it { expect(subject).to be_success }
    it { expect(subject).to render_template :show }
  end

  describe 'GET #new' do
    subject { get :new }
    it { expect(subject).to be_success }
    it { expect(subject).to render_template :new }
  end
  describe 'GET #edit' do
    subject { get :edit, params: { id: artist.id } }
    it { expect(subject).to be_success }
    it { expect(subject).to render_template :edit }
  end

  describe 'POST #create' do
    context 'with valid params' do
      subject { post :create, params: { artist: valid_create_params } }
      it { expect { subject }.to change(Artist, :count).by(1) }
      it { expect(subject).to redirect_to(assigns(:artist)) }
    end

    context 'with invalid params' do
      subject { post :create, params: { artist: invalid_create_params } }
      it { expect(subject).to render_template :new }
    end
  end

  describe 'PUT #update' do
    before { artist } # create record to update
    context 'with valid params' do
      subject { put :update, params: { id: artist.id, artist: valid_update_params } }
      it { expect(subject).to redirect_to(artist) }
      it { expect(subject).to_not render_template :edit }
    end
    context 'with invalid params' do
      subject { put :update, params: { id: artist.id, artist: invalid_update_params } }
      it { expect(subject).to render_template :edit }
    end
  end

  describe 'DELETE #destroy' do
    before { artist } # create record to destroy first
    subject { delete :destroy, params: { id: artist.id } }
    it { expect(subject).to redirect_to(Artist) }
    it { expect { subject }.to change(Artist, :count).by(-1) }
  end
end
