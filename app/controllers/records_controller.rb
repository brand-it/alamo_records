# frozen_string_literal: true

class RecordsController < ApplicationController
  before_action :set_record, only: %i[show edit update destroy]
  before_action :set_records, only: :index
  respond_to :js, only: [:index]

  # GET /records
  def index
    respond_with @records
  end

  # GET /records/1
  def show; end

  # GET /records/new
  def new
    @record = Record.new
    respond_with @record
  end

  # GET /records/1/edit
  def edit; end

  # POST /records
  def create
    @record = Record.new(record_params)
    @record.save
    respond_with @record
  end

  # PATCH/PUT /records/1
  def update
    @record.update(record_params)
    respond_with @record
  end

  # DELETE /records/1
  def destroy
    @record.destroy
    respond_with @record
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_record
    @record = Record.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def record_params
    params.require(:record).permit(:title, :year, :condition, :artist_id)
  end

  def set_records # rubocop:disable AbcSize
    term = params[:search][:term] if params[:search]
    @records = if term.present?
                 Record.search(term)
               else
                 Record.all
               end
    @records = @records.includes(:artist).page(params[:page])
    @records = @records.order(params[:order][:column] => params[:order][:direction]) if params[:order]
  end
end
