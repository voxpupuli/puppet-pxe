Puppet::Parser::Functions::newfunction(:hashme) do |args|

  Puppet::Parser::Functions.autoloader.loadall

  raise ArgumentError, ("myfunction(): wrong number of arguments (#{args.length}; must be 2)") if args.length != 2

  rec_type = args[0]
  hash = args[1]

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
    title = "#{cfg["os"]} #{cfg["ver"]} #{cfg["arch"]}"
    blag = {}
    blag["#{title}"] = cfg
    function_create_resources(rec_type,blag)
  end

end

