class CalendarsController < ApplicationController


  def index
    get_week
    @plan = Plan.new
  end


  def create
    Plan.create(plan_params)
    redirect_to action: :index
  end

  private

  def plan_params
    params.require(:calendars).permit(:date, :plan)
  end

  def get_week
    wdays = ['(日)','(月)','(火)','(水)','(木)','(金)','(土)']
    @todays_date = Date.today
    @week_days = []
    @plans = Plan.where(date: @todays_date..@todays_date + 7)

    7.times do |x|
      plans = []
      plan = @plans.map do |plan|
        plans.push(plan.plan) if plan.date == @todays_date + x
      end
      days = { month:  (@todays_date + x).month, date: (@todays_date+x).day, plans: plans}
      @week_days.push(days)
    end
  end
end
