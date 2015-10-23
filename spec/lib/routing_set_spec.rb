require 'spec_helper'

describe RoutingSet do
  before do
    @store = Store.new
  end

  after do
    @store.delete_all
  end

  describe '#routes' do
    before do
      @routes = ['http://example.com?bar=baz', 'http://example.com?key=val']

      @routes.each do |route|
        @store.add 'GET/hook', route
      end

      @store.add 'POST/hook', 'https://example.com?page=2'
    end

    it 'existing routes' do
      values = RoutingSet.new.routes method: 'GET', path: '/hook'
      assert { values.all? { |val| @routes.include?(val) } }
    end

    it 'not existing routes' do
      values = RoutingSet.new.routes method: 'GET', path: '/hook1'
      assert { values == [] }
    end
  end
end
