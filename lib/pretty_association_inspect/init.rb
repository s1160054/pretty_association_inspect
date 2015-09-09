load "/Users/home/pretty_association_inspect/lib/pretty_association_inspect.rb"
PrettyAssociationInspect.all_models_define
module Kernel
  extend self

  if defined?(Pry)
    def to( obj = self )
      binding.pry obj
    end
  end

  def a
    load '/Users/home/pretty_association_inspect/lib/pretty_association_inspect.rb'
    "Models defined num is #{PrettyAssociationInspect.all_models_define.count}"
  end
end

Pry.editor = 'emacs' if defined?(Pry)

if defined?(PryByebug)
  Pry.commands.alias_command 'c', 'continue'
  Pry.commands.alias_command 's', 'step'
  Pry.commands.alias_command 'n', 'next'
  Pry.commands.alias_command 'f', 'finish'
end

if defined? Hirb
  Hirb::View.instance_eval do
    def enable_output_method
      @output_method = true
      @old_print = Pry.config.print
      Pry.config.print = proc do |*args|
        Hirb::View.view_or_page_output(args[1]) || @old_print.call(*args)
      end
    end

    def disable_output_method
      Pry.config.print = @old_print
      @output_method = nil
    end
  end

  Hirb.enable
end
