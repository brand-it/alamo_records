require 'rails_helper'

<% module_namespacing do -%>
describe <%= controller_class_name %>Controller, <%= type_metatag(:controller) %> do
  render_views

  let(:<%= file_name %>) { create :<%= file_name %> }
  let(:build_<%= file_name %>) { build :<%= file_name %> }

  let(:valid_create_params) { build_<%= file_name %>.attributes }
  let(:invalid_create_params) { { name: nil } } # name is place holder fill in something that will raise a validation error

  let(:valid_update_params) { build_<%= file_name %>.attributes }
  let(:invalid_update_params) { { name: nil } } # name is place holder fill in something that will raise a validation error

<% unless options[:singleton] -%>
  describe 'GET #index' do
    subject { get :index }
    it { expect(subject).to be_success }
    it { expect(subject).to render_template :index }
  end
<% end -%>

  describe 'GET #show' do
    subject { get :show, params: { id: <%= file_name %>.id } }
    it { expect(subject).to be_success }
    it { expect(subject).to render_template :show }
  end

  describe 'GET #new' do
    subject { get :new }
    it { expect(subject).to be_success }
    it { expect(subject).to render_template :new }
  end
  describe 'GET #edit' do
    subject { get :edit, params: { id: <%= file_name %>.id } }
    it { expect(subject).to be_success }
    it { expect(subject).to render_template :edit }
  end

  describe 'POST #create' do
    context 'with valid params' do
      subject { post :create, params: { <%= file_name %>: valid_create_params } }
      it { expect { subject }.to change(<%= class_name %>, :count).by(1) }
      it { expect(subject).to redirect_to(assigns(:<%= file_name %>)) }
    end

    context 'with invalid params' do
      subject { post :create, params: { <%= file_name %>: invalid_create_params } }
      it { expect(subject).to render_template :new }
    end
  end

  describe 'PUT #update' do
    before { <%= file_name %> } # create record to update
    context 'with valid params' do
      subject { put :update, params: { id: <%= file_name %>.id, <%= file_name %>: valid_update_params } }
      it { expect(subject).to redirect_to(<%= file_name %>) }
      it { expect(subject).to_not render_template :edit }
    end
    context 'with invalid params' do
      subject { put :update, params: { id: <%= file_name %>.id, <%= file_name %>: invalid_update_params } }
      it { expect(subject).to render_template :edit }
    end
  end

  describe 'DELETE #destroy' do
    before { <%= file_name %> } # create record to destroy first
    subject { delete :destroy, params: { id: <%= file_name %>.id } }
    it { expect(subject).to redirect_to(<%= class_name %>) }
    it { expect { subject }.to change(<%= class_name %>, :count).by(-1) }
  end
end
<% end -%>