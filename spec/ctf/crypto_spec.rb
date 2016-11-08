require 'spec_helper'

describe CTF::Crypto do
  let(:subject) { CTF::Crypto }

  it 'has method gcd' do
    expect( Object.new.extend(subject) ).to respond_to :gcd
  end

  it 'has singular method gcd' do
    expect( subject ).to respond_to :gcd
  end

  describe '.gcd' do
    example '(6, 9) => 3' do
      expect( subject.gcd(6, 9) ).to eq 3
    end
    example '(0, 10) => 10' do
      expect( subject.gcd(0, 10) ).to eq 10
    end
    example '(-5, 3) => 1' do
      expect( subject.gcd(-5, 3) ).to eq 1
    end
    example '(-5, -3) => 1' do
      expect( subject.gcd(-5, -3) ).to eq 1
    end
    example '(0, 0) => nil' do
      expect( subject.gcd(0, 0) ).to be nil
    end
  end

  describe '.lcm' do
    example '(6, 9) => 18' do 
      expect( subject.lcm(6, 9) ).to eq 18
    end
    example '(0, 10) => 0' do
      expect( subject.lcm(0, 10) ).to eq 0
    end
    example '(-5, 3) => 15' do
      expect( subject.lcm(-5, 3) ).to eq 15
    end
    example '(-5, -3) => 15' do
      expect( subject.lcm(-5, -3) ).to eq 15
    end
    example '(0, 0) => 0' do
      expect( subject.lcm(0, 0) ).to eq 0
    end
  end

  describe '.extgcd' do
    describe 'result gcd' do
      example '(6, 9) => 3' do
        _, _, g = subject.extgcd(6, 9)
        expect( g ).to eq 3
      end
      example '(0, 10) => 10' do
        _, _, g = subject.extgcd(0, 10)
        expect( g ).to eq 10
      end
      example '(-5, 3) => 1' do
        _, _, g = subject.extgcd(-5, 3)
        expect( g ).to eq 1
      end
      example '(-5, -3) => 1' do
        _, _, g = subject.extgcd(-5, -3)
        expect( g ).to eq 1
      end
      example '(0, 0) => nil' do
        _, _, g = subject.extgcd(0, 0)
        expect( g ).to be nil
      end
    end

    describe 'ax + by == g' do
      example '(3, 5)' do
        x, y, g = subject.extgcd(3, 5) 
        expect( 3*x + 5*y ).to eq g
      end
      example '(6, 9)' do
        x, y, g = subject.extgcd(6, 9) 
        expect( 6*x + 9*y ).to eq g
      end
      example '(4, 12)' do
        x, y, g = subject.extgcd(4, 12) 
        expect( 4*x + 12*y ).to eq g
      end
      example '(0, 5)' do
        x, y, g = subject.extgcd(0, 5) 
        expect( 0*x + 5*y ).to eq g
      end
      example '(0, 0)' do
        x, y, g = subject.extgcd(0, 0) 
        expect( 0*x + 0*y ).to eq g
      end
      example '(-3, 5)' do
        x, y, g = subject.extgcd(-3, 5) 
        expect( -3*x + 5*y ).to eq g
      end
      example '(-3, -5)' do
        x, y, g = subject.extgcd(-3, -5) 
        expect( -3*x + -5*y ).to eq g
      end
    end
  end

  describe '.pow' do
    example '(2, 100) => 2**100' do
      expect( subject.pow(2, 100) ).to eq 2**100
    end
    example '(10, 123456789) => (the integer whose size is 123456789+1)' do
      expect( subject.pow(10, 12345).to_s.size ).to eq (12345+1)
    end
    example '(1, 12345) => 1' do
      expect( subject.pow(1, 12345) ).to eq 1
    end
    example '(-1, 12345) => -1' do
      expect( subject.pow(-1, 12345) ).to eq (-1)
    end
    example '(-1, 12346) => 1' do
      expect( subject.pow(-1, 12346) ).to eq 1
    end
  end

  describe '.mod_pow' do
    example '(2, 100, 101)' do
      expect( subject.mod_pow(2, 100, 101) ).to eq (2**100 % 101)
    end
    example '(-2, 101, 331)' do
      expect( subject.mod_pow(-2, 101, 331) ).to eq ((-2)**101 % 331)
    end
  end

  describe '.chinese' do
    example '( (2,3), (3,5) )' do
      res = subject.chinese( subject.mod(2,3), subject.mod(3,5) )
      expect( (res.rem) % 3 ).to eq 2
      expect( (res.rem) % 5 ).to eq 3
    end
    example '( (2,3), (2,6) )' do
      res = subject.chinese( subject.mod(2,3), subject.mod(2,6) )
      expect( res.rem % 3 ).to eq 2
      expect( res.rem % 6 ).to eq 2
    end
    example '( (0,2), (2,4) )' do
      res = subject.chinese( subject.mod(0,2), subject.mod(2,4) )
      expect( res.rem % 2 ).to eq 0
      expect( res.rem % 4 ).to eq 2
    end
    example '( (2,3), (3,6) )' do
      res = subject.chinese( subject.mod(2,3), subject.mod(2,6) )
      expect( res ).to be nil
    end
  end

  describe '.mod' do
    example '(3, 5)' do
      expect( subject.mod(3, 5).rem ).to eq 3
      expect( subject.mod(3, 5).mod ).to eq 5
    end
  end
end
