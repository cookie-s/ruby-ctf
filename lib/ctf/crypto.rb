module CTF
  module Crypto
    def gcd(x, y)
      x,y = [x,y].sort
      until x==0
        x,y = y % x, x
      end
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
      res=1
      until b==0
        res*=a if b.odd?
        a*=a
        b/=2
      end
      res
    end

    def mod_pow(a, b, m)
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
      series = args.map{|m| (m.rem * max * mod(max/m.mod, m).inv / m.mod)}
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
        raise 'not co-prime' unless tmp[2] == 1
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