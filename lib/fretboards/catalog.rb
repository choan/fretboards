module Fretboards
  
  def self.add(*ns, &block)
    catalog = self.get_catalog
    catalog.add(*ns, &block)
  end
  
  def self.get_catalog
    @catalog ||= Catalog.new
  end
  
  def self.[](name)
    self.get_catalog[name]
  end
  
  def self.toc
    self.get_catalog.toc
  end
  
  class Catalog
    
    def initialize
      @data = {}
    end
    
    def toc
      @data.keys
    end
    
    def add(*args, &block)
      # puts args
      @data[args.join("::")] = { :result => nil, :block => block }
    end

    def [](name)
      fb = @data[name]
      fb[:result] ||= fb[:block].call
      fb[:result]
    end
    
  end
  
  # include Catalog.new
end