require "ostruct"

module Config
  REGIONS = {
    'us-east-2': {
      availability_zones: %w[us-east-2a us-east-2b],
      vpc: {
        public_subnets: [
          {
            availability_zone: 'us-east-2a',
            cidr_block: '10.0.0.0/18'
          },
          {
            availability_zone: 'us-east-2b',
            cidr_block: '10.0.64.0/18'
          }
        ],
        private_subnets: [
          {
            availability_zone: 'us-east-2a',
            cidr_block: '10.0.128.0/18'
          },
          {
            availability_zone: 'us-east-2b',
            cidr_block: '10.0.192.0/18'
          }
        ]
      }
    }
  }
end
