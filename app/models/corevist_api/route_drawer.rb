module CorevistAPI
  class RouteDrawer
    include Singleton
    include CorevistAPI::Managers::Download

    attr_accessor :ctx

    BLANK = ''.freeze
    SEPARATOR = '::'.freeze

    def self.set_context(ctx)
      instance.tap { |i| i.ctx = ctx }
    end

    def draw_routes
      apply_on.each do |params|
        method, name, klass = params
        namespaces = split_namespace(klass)
        resource = make_resource(name, method, namespaces.pop)
        namespaces.reverse.inject(resource) { |lambda, kind| make_namespace(lambda, kind) }.call
      end
    end

    def make_resource(name, method, resource)
      -> { ctx.instance_eval { resources(resource) { collection { send(method, name, to: "#{resource}##{name}") } } } }
    end

    def make_namespace(lambda, name)
      -> { ctx.instance_eval { namespace(name) { lambda.call } } }
    end

    def split_namespace(base)
      base.name.gsub(/CorevistAPI|Controller/, BLANK).split(SEPARATOR).reject(&:blank?).map(&:underscore).map(&:to_sym)
    end
  end
end
