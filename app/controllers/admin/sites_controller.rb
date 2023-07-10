class Admin::SitesController < ApplicationController
  layout 'admin'

  before_action :set_site

  def edit
    authorize(@site)
  end

  def update
    authorize(@site)

    binding.pry
    if @site.update(site_params)
      binding.pry
      redirect_to edit_admin_site_path
    else
      binding.pry
      render :edit
    end
  end

  private

  def site_params
    params.require(:site).permit(:name, :subtitle, :description, :favicon, :og_image, main_images: [])
  end

  def set_site
    @site = Site.find(current_site.id)
  end
end
