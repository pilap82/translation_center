require_dependency "translation_center/application_controller"

module TranslationCenter
  class TranslationsController < ApplicationController
    before_filter :can_admin?, only: [ :destroy, :accept, :unaccept ]

    # POST /translations/1/vote
    def vote
      @translation = Translation.find(params[:translation_id])
      current_user.likes(@translation)
      respond_to do |format|
        format.js
      end
    end

    # POST /translations/1/unvote
    def unvote
      @translation = Translation.find(params[:translation_id])
      current_user.unlike @translation
      respond_to do |format|
        format.js
      end
    end

    # POST /translations/1/accept
    def accept
      @translation = Translation.find(params[:translation_id])
      @translation_already_accepted = @translation.key.accepted_in? session[:lang_to]
      @translation.accept
      respond_to do |format|
        format.js
      end
    end

    # POST /translations/1/accept
    def unaccept
      @translation = Translation.find(params[:translation_id])
      @translation.unaccept
      respond_to do |format|
        format.js
      end
    end
  
    # DELETE /translations/1
    # DELETE /translations/1.json
    def destroy
      @translation = Translation.find(params[:id])
      @translation_id = @translation.id
      @translation_key_before_status = @translation.key.status session[:lang_to]
      @translation_key_id = @translation.key.id
      @translation.destroy
      @translation_key_after_status = @translation.key.status session[:lang_to]

      respond_to do |format|
        format.js
      end
    end

  end
end
