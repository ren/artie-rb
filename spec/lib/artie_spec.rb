require 'spec_helper'

describe Artie do
  let(:instructions_fixture_path) { 'spec/fixtures/artie_instructions.json' }
  let(:json) { File.read(instructions_fixture_path) }

  xit "export specified slices from JSON" do
    Artie.start([instructions_fixture_path], true)

    Artie.should_receive(:deliver_artwork).with('slice_1_name','/slice_1/destination')
    Artie.should_receive(:deliver_artwork).with('slice_2_name','/slice_2/destination')
  end
end
