require 'artie/version'
require 'json'

module Artie

  # Usage
  # $ artie [json file]
  #
  # Artie then:
  #   1. Parses JSON (ensure)
  #   2. Retrieves list of slices for specified artwork file(s)
  #   3. Exports that slice to the json specified destination

  def self.start(args, debug)
    puts "Artie the robot is powering up!"
    puts "Using instruction set: #{args.first}"

    instruction_set = self.parse_instructions File.read(args.first)

    self.slice_from_instructions(instruction_set)
  end

  def self.parse_instructions(json)
    JSON.parse(json)
  end

  def self.slice_from_instructions(instruction_set)
    instruction_set['slices'].each do |slice|
      self.deliver_artwork(slice['doc_path'], slice['name'], slice['destination_path'])
    end
  end

  # To export slices or artboards:
  #
  # > sketchtool export slices <doc.sketch> --output=<folder> --items=<names-or-ids> --scales="1.0, 2.0" --formats="png,pdf,eps,jpg"
  #
  # > sketchtool export artboards <doc.sketch> --output=<folder> --items=<names-or-ids> --scales="1.0, 2.0" --formats="png,pdf,eps,jpg"

  def self.deliver_artwork(doc_path, slice_name, destination_path, scales="2.0", formats="png")
    puts "Preparing export: #{doc_path}, #{slice_name}"

    output = `sketchtool/sketchtool export slices #{doc_path} --output=#{destination_path} --items=#{slice_name} --scales="#{scales}" --formats="#{formats}"`
    puts output
  end


  # To list slices or artboards:
  #
  # > sketchtool list slices <doc.sketch>
  # > sketchtool list artboards <doc.sketch>

  # def self.slices_for(file)
  #   # result = JSON.parse `./sketchtool/sketchtool list slices #{file}`
  #   # result['pages'][0]['slices'].map { |slice| slice['name'] }
  # end

end


# Additional sketchtool documentation
#
# To export arbitrary rectangles from pages at 1.0 and 2.0 scales, as jpgs:
#
# > sketchtool export pages <doc.sketch> --output=<folder> --items=<page-names-or-ids> --bounds="0,0,256,256" --scales="1.0, 2.0" --formats="jpg"
#
#
# ## Specifying Scales and Formats
#
# By default, we export a layer using the options specified for it in the document.
#
# However, specifying --scales, --formats, or both will override all the size/type export settings.
#
# If --formats is specified but not --scales, the default scale "1.0" is used.
#
# If --scales is specified but not --formats, the default format "png" is used.
#
# If neither is specified, we use the size settings in the document itself.
#
# If both are used, we export all combinations. For example --formats="png,eps" --scales="1.0,2.0" will produce four combinations.
#
#
# ## Defaults
#
# All --options can be ommitted. The defaults are:
#
# --formats=
# --scales=
# --items=(all slices, artboards, pages)
# --bounds=(all content on the page)
# --output=(current working directory)
