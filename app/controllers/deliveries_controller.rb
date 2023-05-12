class DeliveriesController < ApplicationController
  def index
    deliveries = Delivery.all

    @list_of_deliveries = deliveries.order({ :created_at => :desc })

    render({ :template => "deliveries/index.html.erb" })
  end

  def create
    the_delivery = Delivery.new
    the_delivery.description = params.fetch("description")
    the_delivery.status = params.fetch("query_status")
    the_delivery.user_id = session.fetch(:ser_id)
    the_delivery.details = params.fetch("details")
    the_delivery.arrive_on = params.fetch("arrive_on")
    the_delivery.save

      redirect_to("/", { :notice => "Added to list" })
   
  end

  def update
    the_delivery = Delivery.find(params[:path_id])

    current_status = params.fetch("query_status")
    the_delivery.status = current_status
    the_delivery.save
      redirect_to("/")
    
  end

  def destroy
    the_id = params.fetch("path_id")
    the_delivery_to_delete = Delivery.where({ :id => delivery_id }).at(0)

    the_delivery_to_delete.destroy

    redirect_to("/")
  end
end
