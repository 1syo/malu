require 'spec_helper'
require 'hashie'

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
      request = Hashie::Mash.new(request_method: 'GET', path: '/hook')
      route_set = RoutingSet.new(request: request)
      assert { route_set.routes.all? { |val| @routes.include?(val) } }
    end

    it 'not existing routes' do
      request = Hashie::Mash.new(request_method: 'GET', path: '/hook1')
      route_set = RoutingSet.new(request: request)
      assert { route_set.routes == [] }
    end
  end

  describe '#match' do
    before do
      @store.add 'GET/hook', 'http://example.com?bar=baz'
      @store.add 'POST/hook', 'http://example.com?key=val'
    end

    it 'valid' do
      request = Hashie::Mash.new(request_method: 'GET', path: '/hook')
      route_set = RoutingSet.new(request: request)
      assert { route_set.match? }
    end

    it 'invalid' do
      request = Hashie::Mash.new(request_method: 'HEAD', path: '/hook')
      route_set = RoutingSet.new(request: request)
      assert { route_set.match? == false }
    end
  end
end
