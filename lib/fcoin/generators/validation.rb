require 'thor'
require 'thor/group'

module Fcoin
  module Generators
    class Validation < Thor::Group
      include Thor::Actions

      def self.source_root
        File.dirname(__FILE__) + '/templates/validation'
      end

      def copy_files
        directory '.'
      end
    end
  end
end
