require 'spec_helper'

describe Store do
  before do
    @store = Store.new
  end

  after do
    @store.delete_all
  end

  describe '#add' do
    it 'valid' do
      assert { @store.add('POST/hook_1', 'https://example.com?a=c') }
    end

    it 'invalid method' do
      assert { @store.add('HOO/hook', 'https://example.com') == false }
    end

    it 'invalid url' do
      assert { @store.add('POST/hook', 'https:||a') == false }
    end

    it 'invalid url' do
      assert { @store.add('POST/hook', 'https') == false }
    end
  end

  describe '#get' do
    before do
      @store.add('POST/hook/1', 'https://a.example.com?b=c')
      @store.add('POST/hook/1', 'https://x.example.com?y=z')
      @store.add('POST/hook/2', 'https://1.example.com?2=3')
    end

    it 'include urls' do
      assert { @store.get('POST/hook/1').include?('https://a.example.com?b=c') }
      assert { @store.get('POST/hook/1').include?('https://x.example.com?y=z') }
      assert { @store.get('POST/hook/1').include?('https://1.example.com?2=3') == false }
    end

    it 'not exists' do
      assert { @store.get('POST/hook/3') == [] }
    end
  end

  describe '#del' do
    before do
      @store.add('POST/hook1', 'https://a.example.com?b=c')
    end

    it 'valid' do
      assert { @store.del('POST/hook1') }
    end
  end

  describe '.all' do
    before do
      @store.add('POST/hook1', 'https://a.example.com?b=c')
      @store.add('POST/hook1', 'https://x.example.com?y=z')
      @store.add('POST/hook2', 'https://1.example.com?2=3')
    end

    it 'have 2' do
      assert { Store.all.count == 2 }
    end
  end
end
