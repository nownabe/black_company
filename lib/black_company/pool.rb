require "black_company/event"
require "black_company/task"
require "black_company/workhorse"

module BlackCompany
  class Pool
    DEFAULT_POOL_SIZE = 20

    attr_reader :workhorse_class, :exeption_handlers, :options

    def initialize(
      pool_size: DEFAULT_POOL_SIZE,
      queue_size: nil,
      workhorse_class: Workhorse,
      exeption_handlers: [],
      options: {}
    )

      @queue = queue_size ? SizedQueue.new(queue_size) : Queue.new
      @fired_queue = Queue.new
      @workhorse_class = workhorse_class
      @exeption_handlers = exeption_handlers
      @options = options

      @workhorses = []
      hire(pool_size)
    end

    def count
      @workhorses.count
    end
    alias_method :size, :count

    def fire(count)
      count.times { @queue.push(Event.new(:terminate, @fired_queue)) }
      fired_count = 0
      while fired_count != count
        workhorse = @fired_queue.pop
        workhorse.join
        @workhorses.delete(workhorse)
        fired_count += 1
      end

      count
    end

    def hire(count)
      workhorses = Array.new(count) { hire_one }
      @workhorses.concat(workhorses)

      count
    end

    def inspect
      "#<#{self.class}:0x%014x " \
        "@count=#{count} " \
        "@workhorse_class=#{workhorse_class} " \
        "@queued_tasks_size=#{queued_tasks_size}>" % [object_id]
    end

    def on_exeption(&block)
      @exeption_handlers << block
      @workhorses.each { |w| w.on_exeption(&block) }

      nil
    end

    def receive(task_content = nil, &block)
      @queue.push(Event.new(:perform, Task.new(task_content, &block)))

      nil
    end

    def queued_tasks_size
      @queue.size
    end

    def quit
      fire(count)
    end

    private

    def hire_one
      workhorse_class.new(@queue, exeption_handlers: exeption_handlers, options: options)
    end
  end
end
