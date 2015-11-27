module BlackCompany
  class Task
    attr_reader :content, :proc

    def initialize(content, &block)
      @content = content
      @proc = block
    end
  end
end
