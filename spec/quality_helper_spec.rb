require 'spec_helper'

describe(QualityHelper) do
  let(:test_instance) { Class.new { include ImageHelper }.new }
  let(:png) { fixture('png/tomb.png') }
  let(:png_compressed_20) { fixture('png/tomb_20.png') }
  let(:png_compressed_80) { fixture('png/tomb_80.png') }
  let(:jpg) { fixture('jpg/tomb.jpg') }
  let(:jpg_compressed_20) { fixture('jpg/tomb_20.jpg') }
  let(:jpg_compressed_80) { fixture('jpg/tomb_80.jpg') }

  describe 'dssim' do
    it 'should return 0 when comparing the same file' do
      # Given
      input = png
      compressed = input

      # When
      actual = test_instance.dssim(input, compressed)

      # Then
      expect(actual).to eq 0
    end

    it 'should return a value between 0 and 1' do
      # Given
      input = png
      compressed = png_compressed_20

      # When
      actual = test_instance.dssim(input, compressed)

      # Then
      expect(actual > 0).to be true
      expect(actual < 1).to be true
    end

    it 'should give higher score when the difference is higher' do
      # Given
      input = png

      # When
      low_compression = test_instance.dssim(input, png_compressed_80)
      high_compression = test_instance.dssim(input, png_compressed_20)

      # Then
      expect(high_compression > low_compression).to be true
    end

    it 'should work with jpg files' do
      # Given
      input = jpg
      compressed = jpg_compressed_20

      # When
      actual = test_instance.dssim(input, compressed)

      # Then
      expect(actual > 0).to be true
      expect(actual < 1).to be true
    end
  end

  describe 'temp_png' do
    it 'should give the filepath of a png' do
      # Given
      input = jpg

      # When
      actual = test_instance.temp_png(input)
      is_png = test_instance.png?(actual)

      # Then
      expect(is_png).to be true
    end

    it 'should return false if already a png' do
      # Given
      input = png

      # When
      actual = test_instance.temp_png(input)

      # Then
      expect(actual).to be false
    end
  end

  describe 'compress' do
  end

end