require 'spec_helper'

describe(ArgumentsHelper) do
  let(:test_instance) { Class.new { include ImageHelper }.new }
  let(:gif) { fixture('gif/still.gif') }
  let(:jpg) { fixture('jpg/tomb.jpg') }
  let(:png) { fixture('png/dices.png') }
  let(:txt) { fixture('misc/txt.txt') }

  describe 'image?' do
    it 'should return true for gif files' do
      # Given
      input = gif

      # When
      actual = test_instance.image?(input)

      # Then
      expect(actual).to eq true
    end

    it 'should return true for jpg files' do
      # Given
      input = jpg

      # When
      actual = test_instance.image?(input)

      # Then
      expect(actual).to eq true
    end

    it 'should return true for png files' do
      # Given
      input = png

      # When
      actual = test_instance.image?(input)

      # Then
      expect(actual).to eq true
    end

    it 'should return false for non-image files' do
      # Given
      input = txt

      # When
      actual = test_instance.image?(input)

      # Then
      expect(actual).to eq false
    end

  end
end
