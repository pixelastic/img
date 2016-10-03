require 'spec_helper'

describe(DimensionsHelper) do
  let(:test_instance) { Class.new { include ImageHelper }.new }
  let(:jpg_100_50) { fixture('jpg/100x50.jpg') }
  let(:gif_100_50) { fixture('gif/100x50.gif') }

  describe 'width' do
    it 'should return the width of a JPG' do
      # Given
      input = jpg_100_50

      # When
      actual = test_instance.width(input)

      # Then
      expect(actual).to eq 100
    end

    it 'should return the width of a GIF' do
      # Given
      input = gif_100_50

      # When
      actual = test_instance.width(input)

      # Then
      expect(actual).to eq 100
    end
  end

  describe 'height' do
    it 'should return the height of a JPG' do
      # Given
      input = jpg_100_50

      # When
      actual = test_instance.height(input)

      # Then
      expect(actual).to eq 50
    end

    it 'should return the height of a GIF' do
      # Given
      input = gif_100_50

      # When
      actual = test_instance.height(input)

      # Then
      expect(actual).to eq 50
    end
  end
end
