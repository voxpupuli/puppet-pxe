Puppet::Parser::Functions::newfunction(:resource_permute) do |args|
  Puppet::Parser::Functions.autoloader.loadall

  require 'erb'

  #raise ArgumentError, ("resource_permute(): wrong number of arguments (#{args.length}; must be 2)") if args.length != 2

  # First arg: the resource type that you will be adding
  # Second arg: the hash of permutable resourece
  # Third arg: Common resources that will get added to each resource addition

  rec_type    = args[0]
  hash        = args[1]
  common_hash = args[2]

  # Class borrowed from:
  # https://github.com/lucasdicioccio/laborantin/blob/master/lib/laborantin/core/parameter_hash.rb
  class ParameterHash < Hash
    # Recursively yields all the possible configurations of parameters (a new hash).
    # No order is supported on the recursion, and it is not planned to.
    def each_config(remaining=self.keys, cfg={}, &blk)
      key = remaining.pop
      if key
        self[key].each do |val|
          cfg[key] = val
          each_config(remaining.dup, cfg, &blk)
        end
      else
        yield cfg
      end
    end

    def to_s
      keys.inject(''){|s,k| s + "\t- #{k}: #{self[k]}.\n"}
    end
  end

  params = ParameterHash.new.replace(hash)
  params.each_config do |cfg|
    #title = "#{cfg["os"]} #{cfg["ver"]} #{cfg["arch"]}"
    title = cfg
    if common_hash.is_a?(Hash)
      common_hash.keys.each do |key|
        cfg["#{key}"] = common_hash["#{key}"]
      end
    end
    blag = {}
    blag["#{title}"] = cfg
    function_create_resources([rec_type,blag])
  end

end

