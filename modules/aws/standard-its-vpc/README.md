## Requirements

No requirements.

## Providers

No provider.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| application | Application name, eg ucpath, applyuc, annualwage, etc | `string` | n/a | yes |
| azs | Availability zones to occupy | `list(string)` | <pre>[<br>  "us-west-2a",<br>  "us-west-2b"<br>]</pre> | no |
| cidr\_block | CIDR for VPC | `string` | n/a | yes |
| data\_subnet\_index | index of data subnet | `number` | `4` | no |
| enabled | Set to `false` to prevent the module from creating any resources | `string` | `"true"` | no |
| environment | environment, eg dev, qa, prod | `string` | n/a | yes |
| name | name, to be used as prefix for all resource names | `string` | n/a | yes |
| private\_subnet\_index | index of private subnet | `number` | `2` | no |
| public\_subnet\_index | index of public subnet | `number` | `0` | no |
| subnet\_tier\_bits | number of bits to allocate to subnet tiers, 3 means 8 different tier blocks | `number` | `3` | no |
| tags | A map of tags to add to all resources | `map(string)` | `{}` | no |
| tgw\_subnet\_index | index of tgw subnet | `number` | `1` | no |

## Outputs

| Name | Description |
|------|-------------|
| data\_subnet\_ids | list of data subnet ids |
| igw\_id | internet gateway id |
| igw\_route\_id | internet gateway route id |
| main\_route\_table\_association\_id | route table id |
| private\_subnet\_ids | list of private subnet ids |
| public\_subnet\_ids | list of public subnet ids |
| route\_table\_id | route table id |
| tgw\_subnet\_ids | list of tgw subnet ids |
| vpc\_id | virtual private cloud id |

## Note on subnet sizing

The subnet\_tier\_bits and subnet\_index variables can be used to reserve more CIDR space for a specific subnet tier.  For example, to create smaller data and tgw subnets and larger private subnets:

```
private_subnet_index = 0
public_subnet_index = 2
data_subnet_index = 6
tgw_subnet_index = 7
private_subnet_tier_bits = 1
public_subnet_tier_bits = 2
data_subnet_tier_bits = 3
tgw_subnet_tier_bits = 3
```
