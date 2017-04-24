require "csv"

class WorldCupDSL
  attr_reader :conditions

  def initialize file_path
    @conditions = {}
    @data = CSV.read(file_path, headers: true, header_converters: :symbol, converters: :all).collect do |row|
      Hash[row.collect { |c, r| [c, r] }]
    end
  end

  def where property, expected
    @conditions[property] = expected
    self
  end

  alias_method 'y', 'where'
  alias_method 'dónde', 'where'

  def data
    results = @data.dup
    @conditions.each do |key, value|
      results = results.find_all do |row|
        row[key].to_s == value
      end
    end
    results
  end

  def flush
    @conditions = {}
  end

  def query &block
    instance_eval(&block)
    data
  end

  def method_missing(m, *args, &block)
    if args.size == 1
      where(m, args.first)
    end
    return m.to_s
  end

end