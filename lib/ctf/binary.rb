F=0xF

class String
  def i2; to_i(2) ; end
  def i8; to_i(8) ; end
  def i ; to_i    ; end
  def if; to_i(F) ; end

  def rj(n,c); rjust(n,c); end
  def rj2;?0*(2-(size%2))+self; end
  def rj4;?0*(4-(size%4))+self; end
  def rj8;?0*(8-(size%8))+self; end
  def rjf;?0*(F-(size%F))+self; end
  def rj0(n);rj(n, ?0); end
end

class Integer
  def s2; to_s(2); end
  def s8; to_s(8); end
  def s ; to_s   ; end
  def sf; to_s(F); end
  def exchange_endian; to_s(32).reverse.to_i(32); end
end

module Enumerable
  def ei; each_with_index; end
  def each2; each_slice(2); end
  def each4; each_slice(4); end
  def each8; each_slice(8); end
  def eachf; each_slice(F); end
  def map2(&b);  each2.map(&b); end
  def map4(&b);  each2.map(&b); end
  def map8(&b);  each2.map(&b); end
  def mapf(&b);  each2.map(&b); end
  def unbytes; pack("C*"); end
  def ^(other)
    self.zip(other).map{|x,y| x^y}
  end
end
