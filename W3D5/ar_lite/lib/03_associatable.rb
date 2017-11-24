require_relative '02_searchable'
require 'active_support/inflector'

# Phase IIIa
class AssocOptions
  attr_accessor(
    :foreign_key,
    :class_name,
    :primary_key
  )

  def model_class
    class_name.singularize.constantize
  end

  def table_name
    # class_name.tableize
    class_name.underscore + "s"
  end
end

class BelongsToOptions < AssocOptions
  def initialize(name, options = {})
    # method name
    @name = name
    
    # foreign_key
    if options.key?(:foreign_key)
      @foreign_key = options[:foreign_key]
    else
      @foreign_key = "#{name}_id".to_sym
    end
    
    # primary_key
    if options.key?(:primary_key)
      @primary_key = options[:primary_key]
    else
      @primary_key = :id
    end
    
    # class_name
    if options.key?(:class_name)
      @class_name = options[:class_name]
    else
      @class_name = name.to_s.camelcase
    end
  end
end

class HasManyOptions < AssocOptions
  def initialize(name, self_class_name, options = {})
    # method name
    @name = name
    
    # foreign_key
    if options.key?(:foreign_key)
      @foreign_key = options[:foreign_key]
    else
      @foreign_key = "#{self_class_name.underscore}_id".to_sym
    end
    
    # primary_key
    if options.key?(:primary_key)
      @primary_key = options[:primary_key]
    else
      @primary_key = :id
    end
    
    # class_name
    if options.key?(:class_name)
      @class_name = options[:class_name]
    else
      @class_name = name.to_s.camelcase.singularize
    end
  end
end

module Associatable
  # Phase IIIb
  def belongs_to(name, options = {})
    options = BelongsToOptions.new(name, options)
    self.assoc_options[name] = options
    
    define_method(name) do
      foreign_key = self.send(options.foreign_key)
      options.model_class.where(options.primary_key => foreign_key).first
    end
  end

  def has_many(name, options = {})
    options = HasManyOptions.new(name, self.to_s, options)
    
    define_method(name) do
      primary_key = self.send(options.primary_key)
      options.model_class.where(options.foreign_key => primary_key)
    end
  end

  def assoc_options
    assoc_options = {}
  end
end

class SQLObject
  extend Associatable
end
