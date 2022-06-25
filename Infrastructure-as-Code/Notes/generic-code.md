## Cloudformation Function Commands

### **`!GetAtt`**
Example - `!GetAtt NatGateway1EIP.AllocationId`

### **`!GetAZs`**
This function returns an array that lists Availability Zones for a specified region in alphabetical order.

Example: AvailabilityZone: `!Select [ 0, !GetAZs '' ]`

### **`!Sub `**
Example - `!Sub ${EnvironmentName} Private Subnet (AZ2)`
This function substitutes value to a property at runtime. 

can use this function as `!Sub "$Value"`. <br> For example, the `!Sub "${EnvironmentName}-VPCID"` will substitute the value of `EnvironmentName` parameter during runtime.

https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/intrinsic-function-reference-sub.html

### **`!Ref`** - 

Example - `!Ref PublicSubnet1`

It returns the value of the specified parameter or resource. You can specify a parameter or a resource by its logical name. 

https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/intrinsic-function-reference-ref.html

### **`!Select`** - 

Exmple - `!Select [ 1, !GetAZs '' ]`

This function returns a single object from a list of objects by index.

https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/intrinsic-function-reference-select.html

### **`!Join`**

Example -  `!Join [ ",", [ !Ref PublicSubnet1, !Ref PublicSubnet2 ]]`; 

`Fn::Join: [ delimiter, [ comma-delimited list of values ] ]`

### **`Fn::ImportValue`**

Example
```
Fn::ImportValue:
  !Sub "${EnvironmentName}-VPCID"
```

This function returns the value of an output exported by another stack. 

https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/intrinsic-function-reference-importvalue.html


### **Fn::Base64: !Sub |**

Example

        Fn::Base64: !Sub |
          #!/bin/bash
          sudo apt-get update -y
          sudo apt-get install apache2 -y
          sudo systemctl start apache2.service   

-----------------------------------------------------------------------------------
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

### Route Subnet Association

SubnetRouteTableAssociation resource using the following syntax:

```Type: AWS::EC2::SubnetRouteTableAssociation
Properties: 
RouteTableId: String
SubnetId: String
```

## Outputs

To declare an Output use the following syntax:

```Outputs:
  Logical ID:
    Description: Information about the value
    Value: Value to return - REQUIRED
    Export:
      Name: Value to export - OPTIONAL
```

## Security Groups

### Route table vs Security Groups

Here is a good explanation https://stackoverflow.com/questions/60211533/what-is-the-diference-between-network-acl-and-route-tables-in-aws

In my own terms, **Route tables direct traffic**. Direct what goes in and out of the Subnet and VPC. 

Security groups determines what traffic is allowed in/out of the VPC & Subnets. 

So, Security group determines what traffic comes in & out and route table determines where that traffic goes. 

The following is the syntax required to create a SecurityGroup:

```Type: AWS::EC2::SecurityGroup
Properties: 
GroupDescription: String - Required. Up to 255 Values
GroupName: String
SecurityGroupEgress: 
  - Egress
SecurityGroupIngress: 
  - Ingress
Tags: 
  - Tag
VpcId: String
```

**Security Group Reference** https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/security-group-rules-reference.html

## AutoScaling Group

AWS::AutoScaling::AutoScalingGroup

An autoscaling group in our example exercise will require the following:

* VPCZoneIdentifier
* LaunchConfigurationName
* Min and Max count of instances
* TargetGroupARNs


In the code above:

The `VPCZoneIdentifier` is a list of subnet IDs for a virtual private cloud (VPC) where instances in the Auto Scaling group can be created. We are using the private subnets.

The `LaunchConfigurationName` represents the name of the launch configuration to use to launch instances. We will create a launch configuration in the next demo.

The `MinSize & MaxSize` lets us know the range of machines we will be running, which also alerts us to the min/max costs we can be expecting from these machines.

**A target group is a group of registered instances, to whom the traffic will be routed.** The ARN (Amazon Resource Names) serves as a unique ID for any resource. The `TargetGroupARNs` property refers to the ARNs of the load balancer target group that we will create in the upcoming demos.

Note: In a Launch configuration, the only required properties are `ImageId` and `Instance Type`. The remaining ones are optional.


*You can have a lauch configuration, but without autoscaling group, the machines won't lauch. So, you need to deploy autoscaling group for the minimum number of machines specified to be built.*

## Load Balancers
Load balancer will be sent on a specific port to listen to an instance and report back if it's healthy or not. If it's not healthy, autoscaling group will terminate it and build a new one in it's place. 

