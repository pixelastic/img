require 'spec_helper'

describe(PngHelper) do
  let(:test_instance) { Class.new { include ImageHelper }.new }
  let(:png) { fixture('png/dices.png') }

  describe 'png?' do
    it 'returns true if file is a png' do
      # Given
      input = png

      # When
      actual = test_instance.png?(input)

      # Then
      expect(actual).to eq true
    end
  end
end
