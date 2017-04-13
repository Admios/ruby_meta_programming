require 'rspec'
require_relative '../lib/dynamic_logging.rb'

class Calculator
  extend DynamicLogging

  def add arg1, arg2
    arg1 + arg2
  end

  def subtract arg1, arg2
    arg1 - arg2
  end

  add_logging(instance_methods(false))
end

describe DynamicLogging do
  it 'should add dynamic logging' do
    Calculator.new.add 4, 4
  end

  it 'should add dynamic logging to the subtract method' do
    Calculator.new.subtract 100, 4
  end
end