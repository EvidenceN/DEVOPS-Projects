To specify a subnet for your VPC you can use the following syntax: 


```Type: AWS::EC2::Subnet
Properties: 
  AssignIpv6AddressOnCreation: Boolean
  AvailabilityZone: String
  CidrBlock: String
  Ipv6CidrBlock: String
  MapPublicIpOnLaunch: Boolean
  Tags: 
    - Tag
  VpcId: String
  ```


Cloudformation Commands

`!GetAtt` 
Example - `!GetAtt NatGateway1EIP.AllocationId`

`!Sub `
Example - `!Sub ${EnvironmentName} Private Subnet (AZ2)`

`!Ref` - Example - `!Ref PublicSubnet1`

`!Select` - Exmple - `!Select [ 1, !GetAZs '' ]`


