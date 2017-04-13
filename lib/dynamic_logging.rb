module DynamicLogging
  def add_logging(methods_to_redefine)
    methods_to_redefine = [methods_to_redefine] if methods_to_redefine.class != Array
    methods_to_redefine.map(&:to_s).each do |m|
      alias_method m + '_orig', m
      define_method(m) do |*args|
        puts "Method called: #{self.class}:#{m}(#{args.join(', ')})"
        send(m + '_orig', *args)
      end
    end
  end
end