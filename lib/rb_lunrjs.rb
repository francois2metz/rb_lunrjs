require "rb_lunrjs/version"
require 'v8'
require 'json'
require 'zlib'
require 'coffee_script'

module RbLunrjs
  def self.dump(options)
    s = Index.new options
    s.dump
  end

  class Index
    def initialize(options)
      @lunr_options = options.fetch(:lunr).fetch(:options)
      @lunr_documents = options.fetch(:lunr).fetch(:documents)
      @out_file = options.fetch(:out_file)
      @gzip = options.fetch(:gzip, false)
      @debug = options.fetch(:debug, false)
    end

    def debug_mode(ctx)
      ctx['console'] = STDOUT
      def STDOUT.debug(*a)
        puts sprintf(*a.map(&:to_s))
      end
    end

    def dump
      compile_coffee
      V8::Context.new do |ctx|
        debug_mode(ctx) if @debug
        ctx.load(File.join(dir, '..', 'js/lunr.min.js'))
        ctx.load(File.join(dir, '..', 'js/app.js'))
        json = ctx.eval <<-JS
            search = new Search(#{JSON.dump(@lunr_options)}, #{JSON.dump(@lunr_documents)});
            search.toJSON();
        JS
        if @gzip
          Zlib::GzipWriter.open("#{@out_file}.gz") do |gz|
            gz.write json
          end
        else
          File.open("#{@out_file}", 'w') do |f|
            f << json
          end
        end
      end
      true
    end

    def compile_coffee
      code = File.read(File.join(dir, '..', 'js/app.js.coffee'))
      File.open(File.join(dir, '..', 'js/app.js'), 'w') do |f|
        f << CoffeeScript.compile(code)
      end
      code
    end

    def dir
      @dir ||= File.dirname(__FILE__)
    end
  end
end
