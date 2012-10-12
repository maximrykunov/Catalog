object false

# create a "places" node
node :categories do
  # setup a { place : { ...data... } } json array
  @categories.map { |data| { :category => data } }
end