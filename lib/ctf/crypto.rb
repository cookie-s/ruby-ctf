module CTF
  module Crypto
    def gcd(x, y)
      x,y = [x,y].map(&:abs).sort
      until x==0
        x,y = y % x, x
      end

      return nil if y.zero?
      y
    end

    def extgcd(a, b)
      # return [x, y, gcd] such that ax + by = gcd
      if b.zero?
        [1, 0, a]
      else
        prev = extgcd(b, a % b)
        [prev[1], prev[0]-(a/b)*prev[1], prev[2]]
      end
    end

    def pow(a, b)
      a**b # original power is faster than binary-algorithm in ruby
    end

    def mod_pow(a, b, m)
      raise ArgumentError, 'b has to be non-negative' if b<0
      res=1
      until b==0
        res*=a if b.odd?
        res%=m
        a*=a
        a%=m
        b/=2
      end
      res%m
    end

    def chinese (*args)
      max = args.map(&:mod).inject(:*)
      series = args.map{|m| (m.rem * max * (mod(max/m.mod, m.mod).inv.rem) / m.mod)}
      mod(series.inject(&:+) % max, max)
    end

    def mod(a, m); Mod.new(a, m); end
    class Mod
      attr_reader :rem, :mod
      def initialize(a, m)
        @rem = a%m
        @mod = m
      end

      def inv
        tmp = Crypto.extgcd(@rem,@mod)
        raise ArgumentError, 'not co-prime' unless tmp[2] == 1
        Crypto.mod(tmp[0], @mod)
      end

      def ** (n)
        Crypto.mod(Crypto.mod_pow(@rem, n, @mod), @mod)
      end

    end

    class << self
      include Crypto
    end
  end
end
