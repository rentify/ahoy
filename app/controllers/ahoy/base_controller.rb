module Ahoy
  class BaseController < ApplicationController
    # skip all filters
    skip_filter :skip_filters

    def ahoy
      @ahoy ||= Ahoy::Tracker.new(controller: self, api: true)
    end

    private

    def exclude_filters
      []
    end

    def skip_filters
      BaseController._process_action_callbacks.map(&:filter).reject{ |filter| exclude_filters.include?(filter) }
    end

  end
end
