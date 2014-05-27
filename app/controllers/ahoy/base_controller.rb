module Ahoy
  class BaseController < ApplicationController
    # skip all filters
    skip_filter *_process_action_callbacks.map(&:filter)

    before_filter :load_authlogic

    before_filter :halt_bots

    protected

    def browser
      @browser ||= Browser.new(ua: request.user_agent)
    end

    def halt_bots
      if !Ahoy.track_bots and browser.bot?
        render json: {}
      end
    end

    def load_authlogic
      Authlogic::Session::Base.controller = Authlogic::ControllerAdapters::RailsAdapter.new(self)
    end

  end
end
