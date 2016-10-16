require 'spec_helper'

describe(JpgHelper) do
  let(:test_instance) { Class.new { include ImageHelper }.new }
  let(:jpg) { fixture('jpg/game.jpg') }
  let(:jpeg) { fixture('jpg/game.jpeg') }

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

  describe 'compress_jpg' do
    it 'should compress JPG files into smaller files' do
      # Given
      input = copy(jpg)
      before = test_instance.filesize(input)

      # When
      test_instance.compress_jpg(input)
      after = test_instance.filesize(input)

      # Then
      expect(after).to be < before
    end

    it 'should compress more when a smaller quality is given' do
      # Given
      input = copy(jpg)

      # When
      test_instance.compress_jpg(input, 80)
      filesize80 = test_instance.filesize(input)

      input = copy(jpg)
      test_instance.compress_jpg(input, 20)
      filesize20 = test_instance.filesize(input)

      # Then
      expect(filesize20).to be < filesize80
    end

    it 'should allow specifying an output file' do
      # Given
      input = copy(jpg)
      before = test_instance.filesize(input)
      output_path = File.join(File.dirname(input), 'output.jpg')

      # When
      actual = test_instance.compress_jpg(input, 80, output_path)
      after = test_instance.filesize(actual)

      # Then
      expect(after).to be < before
    end
  end
end
