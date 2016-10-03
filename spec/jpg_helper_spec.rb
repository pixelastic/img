require 'spec_helper'

describe(JpgHelper) do
  let(:test_instance) { Class.new { include ImageHelper }.new }
  let(:jpg) { fixture('jpg/tomb.jpg') }
  let(:jpeg) { fixture('jpg/tomb.jpeg') }

  describe 'jpg?' do
    it 'returns true if file is a jpg' do
      # Given
      input = jpg

      # When
      actual = test_instance.jpg?(input)

      # Then
      expect(actual).to eq true
    end

    it 'returns true if file is a jpeg' do
      # Given
      input = jpeg

      # When
      actual = test_instance.jpg?(input)

      # Then
      expect(actual).to eq true
    end
  end
end
