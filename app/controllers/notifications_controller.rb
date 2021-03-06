class NotificationsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_notification, only: [:show, :edit, :update, :destroy]

  # GET /notifications
  def index
    @notifications = Notification.all
    @page_title = "All Notifications"
  end

  # GET /notifications/1
  def show
    @event = @notification.event
  end

  # GET /notifications/new
  def new
    @notification = Notification.new
    # @statuses = @notification.available_statuses
    @statuses = ["Active"]
    @notification.status = "Active"
  end

  # GET /notifications/1/edit
  def edit
    @statuses = @notification.available_statuses + [@notification.status]
  end

  # POST /notifications
  def create
    @notification = Notification.new(notification_params)
    if @notification.save
      redirect_to @notification, notice: 'Notification was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /notifications/1
  def update
    if @notification.update(notification_params)
      redirect_to @notification, notice: 'Notification was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /notifications/1
  def destroy
    @notification.destroy
    redirect_to notifications_url, notice: 'Notification was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_notification
      @notification = Notification.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def notification_params
      params.require(:notification).permit(:subject, :body, :event_id, :author_id, :status,
         :time_to_live, :interval, :iterations_to_escalation, :groups,
         :scheduled_start_time, :start_time, :channels, :divisions, :department_ids => [])
    end
end
