Puppet::Parser::Functions::newfunction(:pxe_expand, :doc => '
') do |args|
  raise ArgumentError, ("create_resources(): wrong number of arguments (#{args.length}; must be 2)") if args.length != 2
  #raise ArgumentError, 'requires resource type and param hash' if args.size < 2
  # figure out what kind of resource we are
  Puppet.notice "args[1] is #{args[1]} #{args[1].class}"

  hash = args[1]
  expanded_hashes = {}
  matrix = []
  matrix_keys
  globals = {}
  hash.each do |k, v|
    if v.is_a(Array)
      matrix_keys(k)
      matrix.push(v)
    elsif v.is_a(String)
      globals[k]=v
    else
      raise ArgumentError, 'we only support strings and arrays'
    end
  end

  newarray = []
  matrix.each do |row|
    newarray.product(row)
  end
  newarray.flatten

  newarray.each_with_index do |index, elemement|
  end

#  class ParameterHash < Hash
#    # Recursively yields all the possible configurations of parameters (a new hash).
#    # No order is supported on the recursion, and it is not planned to.
#    def each_config(remaining=self.keys, cfg={}, &blk)
#      key = remaining.pop
#      if key
#        self[key].each do |val|
#          cfg[key] = val
#          each_config(remaining.dup, cfg, &blk)
#        end
#      else
#        yield cfg
#      end
#    end
#
#    def to_s
#      keys.inject(''){|s,k| s + "\t- #{k}: #{self[k]}.\n"}
#    end
#  end
#
#  params = ParameterHash.new.replace(args[1])
#  params.each_config do |cfg|
#    p cfg
#    name = cfg.values.flatten.join('')
#    p name
#    Puppet.notice cfg
#  end

end


