class BackgroundSerializer
  include FastJsonapi::ObjectSerializer
  attributes :location, :url, :credit
end
