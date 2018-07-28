require 'thor'
require 'thor/group'

module Fcoin
  module Generators
    class Locale < Thor::Group
      include Thor::Actions

      def self.source_root
        File.dirname(__FILE__) + '/templates/locale'
      end

      def copy_files
        directory '.'
      end
    end
  end
end
