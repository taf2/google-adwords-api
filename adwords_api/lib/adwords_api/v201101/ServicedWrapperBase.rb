module AdwordsApi
  module V201101
    class ServerWrapperBase
      #
      # Args:
      # - object: the object being modified
      # - property: the property being set
      # - value: the value it's being set to
      #
      def set_object_property(object, property, value)
        begin
          # this is the part we added to always camel_case with the first character being lowercase
          if !object.respond_to?(property.to_s + '=')
            property = camel_case(property) if property.match(/_/)
          end
          object.send(property.to_s + '=', value)
        rescue
          object_class = object.class.name.split('::').last
          error = AdsCommon::Errors::MissingPropertyError.new(
              property, object_class)
          message = "'Missing property `" + property.to_s +
              "' for object class `" + object_class + "'"
          raise(error, message)
        end
      end
    end
  end
end
