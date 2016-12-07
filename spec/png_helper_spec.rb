require 'spec_helper'

describe(PngHelper) do
  let(:t) { Class.new { include ImageHelper }.new }
  let(:png) { fixture('png/dices.png') }
  let(:aasimar) { fixture('png/aasimar.png') }
  let(:grayscale) { fixture('png/tomb-grayscale.png') }

  describe 'png?' do
    it 'returns true if file is a png' do
      # Given
      input = png

      # When
      actual = t.png?(input)

      # Then
      expect(actual).to eq true
    end
  end

  describe 'trim' do
    it 'should remove whitespace around the image' do
      # Given
      input = copy(aasimar)
      before_width = t.width(input)
      before_height = t.height(input)

      # When
      t.trim(input)
      after_width = t.width(input)
      after_height = t.height(input)

      # Then
      expect(before_width).to be > after_width
      expect(before_height).to be > after_height
    end
  end
end
