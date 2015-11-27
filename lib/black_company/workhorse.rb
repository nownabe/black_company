module BlackCompany
  class Workhorse
    attr_reader :options

    def initialize(queue, exeption_handlers: [], options: {})
      @queue = queue
      @active = true
      @thread = Thread.new { work }
      @exeption_handlers = [*exeption_handlers]
      @options = options
    end

    def alive?
      @thread && @thread.alive?
    end

    def join
      @thread.join
    end

    def on_exeption(&block)
      @exeption_handlers << block
    end

    private

    def handle(event)
      case event.type
      when :terminate
        @active = false
        event.data.push(self)
      when :perform
        perform(event.data)
      end
    end

    def handle_exeption(e)
      @exeption_handlers.each { |h| h.call(e) }
    end

    def perform(task)
      serve(task.content, &task.proc)
    rescue => e
      handle_exeption(e)
    end

    def serve(content, &block)
      block.call(content)
    end

    def work
      while @active
        event = @queue.pop
        handle(event)
      end
    end
  end
end
