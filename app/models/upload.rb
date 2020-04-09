class Upload
  ALGORITHM = 'AWS4-HMAC-SHA256'.freeze
  MAX_UPLOAD_SIZE = 20.megabytes
  TTL = 1.hour
  ACL = 'public-read'.freeze

  def initialize(resource)
    @resource = resource
    @date = DateTime.now
  end

  def url
    "#{base_url}/#{bucket}"
  end

  def key
    resource_path
  end

  def algorithm
    ALGORITHM
  end

  def acl
    ACL
  end

  def credential
    "#{aws_access_key_id}/#{policy_date}/us-east-1/s3/aws4_request"
  end

  def date
    @date.utc.strftime('%Y%jT%H%M%SZ')
  end

  def signature
    OpenSSL::HMAC.hexdigest('sha256', signature_key, encoded_policy)
  end

  def encoded_policy
    @encoded_policy ||= Base64.encode64(
      {
        'expiration' => TTL.from_now.utc.xmlschema,
        'conditions' => [
          { 'bucket' => bucket },
          ['starts-with', '$key', resource_path],
          { 'acl' => ACL },
          ['starts-with', '$Content-Type', 'image'],
          { 'x-amz-algorithm' => ALGORITHM },
          { 'x-amz-credential' => aws_access_key_id },
          { 'x-amz-date' => date },
          ['content-length-range', 0, MAX_UPLOAD_SIZE]
        ]
      }.to_json
    ).gsub("\n", '')
  end

  private

  def policy_date
    @date.utc.strftime('%Y%m%d')
  end

  def resource_path
    @resource_path ||= "#{@resource.class.table_name}/#{@resource.to_sgid}"
  end

  def signature_key
    k_date = OpenSSL::HMAC.digest('sha256', 'AWS4' + aws_secret_access_key, policy_date)
    k_region = OpenSSL::HMAC.digest('sha256', k_date, aws_region)
    k_service = OpenSSL::HMAC.digest('sha256', k_region, 's3')
    k_signing = OpenSSL::HMAC.digest('sha256', k_service, 'aws4_request')
    k_signing
  end

  def base_url
    if aws_region == 'us-east-1'
      'https://s3.amazonaws.com'
    else
      "https://s3.#{aws_region}.amazonaws.com"
    end
  end

  def bucket
    Rails.application.credentials.aws[:bucket]
  end

  def aws_access_key_id
    Rails.application.credentials.aws[:access_key]
  end

  def aws_secret_access_key
    Rails.application.credentials.aws[:secret_key]
  end

  def aws_region
    Rails.application.credentials.aws[:region]
  end
end
