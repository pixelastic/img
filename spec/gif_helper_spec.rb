require 'spec_helper'

describe(GifHelper) do
  let(:test_instance) { Class.new { include ImageHelper }.new }
  let(:gif_still) { fixture('gif/still.gif') }
  let(:gif_capitalize) { fixture('gif/CAPITALIZE.GIF') }
  let(:gif_animated) { fixture('gif/animated.gif') }
  let(:gif_loop_once) { fixture('gif/loop-once.gif') }
  let(:gif_loop_five) { fixture('gif/loop-5.gif') }
  let(:jpg) { fixture('jpg/tomb.jpg') }

  describe 'gif?' do
    it 'returns true if file is a gif' do
      # Given
      input = gif_still

      # When
      actual = test_instance.gif?(input)

      # Then
      expect(actual).to eq true
    end

    it 'works with capitalized names' do
      # Given
      input = gif_capitalize

      # When
      actual = test_instance.gif?(input)

      # Then
      expect(actual).to eq true
    end

    it 'returns false if file is not a gif' do
      # Given
      input = jpg

      # When
      actual = test_instance.gif?(input)

      # Then
      expect(actual).to eq false
    end
  end

  describe 'animated_gif?' do
    it 'should return true for animated gif' do
      # Given
      input = gif_animated

      # When
      actual = test_instance.animated_gif?(input)

      # Then
      expect(actual).to eq true
    end

    it 'should return true for animated gif without loop' do
      # Given
      input = gif_loop_once

      # When
      actual = test_instance.animated_gif?(input)

      # Then
      expect(actual).to eq true
    end

    it 'should return false for still gif' do
      # Given
      input = gif_still

      # When
      actual = test_instance.animated_gif?(input)

      # Then
      expect(actual).to eq false
    end

    it 'should return false for jpg' do
      # Given
      input = jpg

      # When
      actual = test_instance.animated_gif?(input)

      # Then
      expect(actual).to eq false
    end
  end

  describe 'looped_gif?' do
    it 'should return true for infinite loop gif' do
      # Given
      input = gif_animated

      # When
      actual = test_instance.looped_gif?(input)

      # Then
      expect(actual).to eq true
    end

    it 'should return false for still gif' do
      # Given
      input = gif_still

      # When
      actual = test_instance.looped_gif?(input)

      # Then
      expect(actual).to eq false
    end

    it 'should return false for only one loop' do
      # Given
      input = gif_loop_once

      # When
      actual = test_instance.looped_gif?(input)

      # Then
      expect(actual).to eq false
    end

    it 'should return false for more than one loop but not infinite' do
      # Given
      input = gif_loop_five

      # When
      actual = test_instance.looped_gif?(input)

      # Then
      expect(actual).to eq false
    end
  end
end
