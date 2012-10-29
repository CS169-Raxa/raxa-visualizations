module ApplicationHelper
  class ActiveSupport::TimeWithZone
    # The default rails as_json method format isn't understood by the
    # browser. Use UNIX epoch time (in seconds) instead.
    #
    # Client-side JS should use `new Date(...)`
    def as_json(options = {})
      to_i
    end
  end
end
