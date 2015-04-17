class ReportsController < ApplicationController
  load_and_authorize_resource
  # GET /reports
  # GET /reports.json
  def index
    @search = Report.ransack(params[:q])
    @user = current_user.id
    if User.find(@user).role_id
      @reports = @search.result
      @search.build_condition if @search.sorts.empty?
      @search.build_sort if @search.sorts.empty?
    else
    @reports = Report.where(:user_id => @user)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @reports }
    end
  end
  end

  # GET /reports/1
  # GET /reports/1.json
  def show
    @report = Report.find(params[:id])
     respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @report }
    end
  end

  # GET /reports/new
  # GET /reports/new.json
  def new
    @user = current_user.id
    @report = Report.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @report }
    end
  end

  # GET /reports/1/edit
  def edit
    @user = current_user.id
    @report = Report.find(params[:id])
  end

  # POST /reports
  # POST /reports.json
  def create
    @report = Report.new(params[:report])

    respond_to do |format|
      if @report.save
        format.html { redirect_to @report, notice: 'Report was successfully created.' }
        format.json { render json: @report, status: :created, location: @report }
      else
        format.html { render action: "new" }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /reports/1
  # PUT /reports/1.json
  def update
    @report = Report.find(params[:id])

    respond_to do |format|
      if @report.update_attributes(params[:report])
        format.html { redirect_to @report, notice: 'Report was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reports/1
  # DELETE /reports/1.json
  def destroy
    @report = Report.find(params[:id])
    @report.destroy

    respond_to do |format|
      format.html { redirect_to reports_url }
      format.json { head :no_content }
    end
  end

  def search

    @user=current_user.id
    start_date=params[:start]
    if params[:end]
    end_date=params[:end].to_date + 1
      end
    @result=Report.where(['user_id = ? AND created_at >= ? AND created_at <= ?', @user, start_date, end_date ]) 
  end
end
