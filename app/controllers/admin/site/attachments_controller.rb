class Admin::Site::AttachmentsController < ApplicationController
  def destroy
    binding.pry
    image = ActiveStorage::Attachment.find(params[:id])
    image.purge
    redirect_to edit_admin_site_path
  end
end