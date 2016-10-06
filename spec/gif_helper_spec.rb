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

  describe 'animated?' do
    it 'should return true for animated gif' do
      # Given
      input = gif_animated

      # When
      actual = test_instance.animated?(input)

      # Then
      expect(actual).to eq true
    end

    it 'should return true for animated gif without loop' do
      # Given
      input = gif_loop_once

      # When
      actual = test_instance.animated?(input)

      # Then
      expect(actual).to eq true
    end

    it 'should return false for still gif' do
      # Given
      input = gif_still

      # When
      actual = test_instance.animated?(input)

      # Then
      expect(actual).to eq false
    end

    it 'should return false for jpg' do
      # Given
      input = jpg

      # When
      actual = test_instance.animated?(input)

      # Then
      expect(actual).to eq false
    end
  end

  describe 'looped?' do
    it 'should return true for infinite loop gif' do
      # Given
      input = gif_animated

      # When
      actual = test_instance.looped?(input)

      # Then
      expect(actual).to eq true
    end

    it 'should return false for still gif' do
      # Given
      input = gif_still

      # When
      actual = test_instance.looped?(input)

      # Then
      expect(actual).to eq false
    end

    it 'should return false for only one loop' do
      # Given
      input = gif_loop_once

      # When
      actual = test_instance.looped?(input)

      # Then
      expect(actual).to eq false
    end

    it 'should return false for more than one loop but not infinite' do
      # Given
      input = gif_loop_five

      # When
      actual = test_instance.looped?(input)

      # Then
      expect(actual).to eq false
    end
  end

  describe 'resize_gif' do
    it 'should resize to the specified dimensions ' do
      # Given
      input = copy(gif_still)

      # When
      test_instance.resize_gif(input, '100x50')

      # Then
      width = test_instance.width(input)
      height = test_instance.height(input)
      expect(width).to eq 100
      expect(height).to eq 50
    end
  end

  describe 'unloop' do
    it 'should make a looped gif play only one' do
      # Given
      input = copy(gif_animated)

      # When
      test_instance.unloop(input)
      actual = test_instance.looped?(input)

      # Then
      expect(actual).to eq true
    end
  end

  describe 'make_loop' do
    it 'should make an unlooped gif loop' do
      # Given
      input = copy(gif_loop_once)

      # When
      test_instance.make_loop(input)
      actual = test_instance.looped?(input)

      # Then
      expect(actual).to eq true
    end
  end

  describe 'speed' do
    it 'should return a number explaining the speed of the animation' do
      # Given
      input = gif_animated

      # When
      actual = test_instance.speed(input)

      # Then
      expect(actual).to eq 10
    end

    it 'should return 0 for still files' do
      # Given
      input = gif_still

      # When
      actual = test_instance.speed(input)

      # Then
      expect(actual).to eq 0
    end
  end

  describe 'change_speed' do
    it 'should change the speed of the file' do
      # Given
      input = copy(gif_animated)
      speed = 15

      # When
      test_instance.set_speed(input, speed)
      actual = test_instance.speed(input)

      # Then
      expect(actual).to eq speed
    end
  end
end
