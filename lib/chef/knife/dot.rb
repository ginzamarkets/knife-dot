require 'chef/knife'

module KnifeDot
  class Dot < Chef::Knife
    banner "knife dot [dot options]"

    deps do
      require 'pathname'

      require 'erubis'
      require 'mixlib/shellout'

      class ::Object
        def graphviz_id
          name = self.respond_to?(:name) ? self.name : self
          "#{self.class}__#{name}".downcase.gsub(/[^a-z0-9_]+/, '_')
        end
      end
    end

    # We pass-through options, if any, to dot command
    def parse_options(argv)
      argv
    end

    def load_all(cls)
      cls.list.keys.sort.map(&cls.method(:load))
    end

    def run
      vars = { :nodes => load_all(Chef::Node),
        :roles => load_all(Chef::Role),
        :environments => load_all(Chef::Environment) }
      vars.values.each do |ary|
        class << ary
          def [](key)
            case key
            when ::Fixnum then super(key)
            when ::Regexp then self.select { |elt| elt.name =~ key }
            when ::String then self.find { |elt| elt.name == key }
            when ::Array then key.map { |v| self[v] }.flatten.compact
            when ::Proc then self.select(&key).compact
            end
          end
        end
      end

      dot_erb = Pathname.new(__FILE__).dirname.join('dot.erb').read
      dot_src = Erubis::Eruby.new(dot_erb).result(vars)

      if name_args.empty?
        puts dot_src
      else
        dot_cmd = [ 'dot' ] + name_args
        dot_cmd << { :input => dot_src }
        Mixlib::ShellOut.new(*dot_cmd).run_command.error!
      end
    end
  end
end
