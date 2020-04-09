require 'rails_helper'

RSpec.describe Upload, type: :model do
  let(:resource) { create(:user) }
  let(:upload) { Upload.new(resource) }

  describe '#url' do
    it 'returns the S3 bucket url for the resource' do
      expect(upload.url).to match(%r{\Ahttps\://s3\.amazonaws\.com/heartbit\z})
    end
  end

  describe '#key' do
    it 'returns the S3 key for the resource' do
      expect(upload.key).to match(%r{users/\w+})
    end
  end

  describe '#acl' do
    it 'returns the configured S3 ACL' do
      expect(upload.acl).to eq('public-read')
    end
  end

  describe '#algorithm' do
    it 'returns the configured AWS algorithm' do
      expect(upload.algorithm).to eq('AWS4-HMAC-SHA256')
    end
  end

  describe '#credential' do
    it 'returns a valid AWS credential' do
      expect(upload.credential).to match(%r{\A\w+/\d{8}/us-east-1/s3/aws4_request\z})
    end
  end

  describe '#date' do
    it 'returns a valid date' do
      expect(Date.strptime(upload.date, '%Y%jT%H%M%SZ')).to_not be_nil
    end
  end

  describe '#signature' do
    it 'returns a signature' do
      expect(upload.signature).to match(/\A\h{64}\z/)
    end
  end

  describe '#enconded_policy' do
    it 'returns a policy enconded as Base64' do
      regex = %r{^(?:[A-Za-z0-9+/]{4}\n?)*(?:[A-Za-z0-9+/]{2}==|[A-Za-z0-9+/]{3}=)?$}
      expect(upload.encoded_policy).to match(regex)
    end
  end
end
