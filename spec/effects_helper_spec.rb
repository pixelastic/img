require 'spec_helper'

describe(EffectsHelper) do
  let(:t) { Class.new { include ImageHelper }.new }
  let(:png) { fixture('png/dices.png') }

  fdescribe 'palette_size' do
    it 'should return the number of colors of the image' do
      # Given
      input = png

      # When
      actual = t.palette_size(input)

      # Then
      expect(actual).to eq 7770
    end
  end
end
