require 'spec_helper'

describe(ColorHelper) do
  let(:t) { Class.new { include ImageHelper }.new }
  let(:jpg) { fixture('jpg/game.jpg') }

  describe 'rgb2hex' do
    it 'should convert an rgb value to an hex code' do
      # Given
      input = 'rgb(0,174,255)'

      # When
      actual = t.rgb2hex(input)

      # Then
      expect(actual).to eq '#00AEFF'
    end

    it 'should accept spaces in the rgb value' do
      # Given
      input = 'rgb(0, 174, 255)'

      # When
      actual = t.rgb2hex(input)

      # Then
      expect(actual).to eq '#00AEFF'
    end

    it 'should accept srgb values (coming from convert)' do
      # Given
      input = 'srgb(0, 174, 255)'

      # When
      actual = t.rgb2hex(input)

      # Then
      expect(actual).to eq '#00AEFF'
    end

    it 'should accept rgba values' do
      # Given
      input = 'rgba(0, 174, 255, 5)'

      # When
      actual = t.rgb2hex(input)

      # Then
      expect(actual).to eq '#00AEFF'
    end
  end
end
