## Cloudformation Commands

`!GetAtt` 
Example - `!GetAtt NatGateway1EIP.AllocationId`

`!Sub `
Example - `!Sub ${EnvironmentName} Private Subnet (AZ2)`

`!Ref` - Example - `!Ref PublicSubnet1`

`!Select` - Exmple - `!Select [ 1, !GetAZs '' ]`

## Subnets

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

## NAT Gateway

basic syntax for declaring a NAT Gateway:

```Type: AWS::EC2::NatGateway
Properties: 
AllocationId: String
SubnetId: String
Tags: 
  - Tag
  ```

## Route Table

AWS Route tables go from specific to broad. For example, the route 10.0.0.0/16 will get executed before the route 0.0.0.0/0

The following is the syntax used to define a route table:

```Type: AWS::EC2::RouteTable
Properties: 
Tags: 
  - Tag
  VpcId: String
```
### Route

The following is the syntax used to set up a route:

```Type: AWS::EC2::Route
Properties: 
DestinationCidrBlock: String - *Destination Matching*
DestinationIpv6CidrBlock: String
EgressOnlyInternetGatewayId: String
GatewayId: String
InstanceId: String
NatGatewayId: String
NetworkInterfaceId: String
RouteTableId: String
VpcPeeringConnectionId: String
```

