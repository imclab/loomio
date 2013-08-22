class AttachmentsController < ApplicationController
  before_filter :authenticate_user!

  def create
    attachment = Attachment.new(params[:attachment])
    attachment.user = current_user

    if attachment.save
      render json: {
        saved: true,
        attachment_id: attachment.id
      }
    else
      render json: {
        saved: false
      }
    end
  end

end
