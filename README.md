# Challenge

Deploy a [Substrate](https://github.com/paritytech/substrate) or[Polkadot](https://github.com/paritytech/polkadot) network of your choice. Either run your own network like the Alice and Bob example or let a node join an existing test network.

The idea is to show automation of the provisioning and deployment process and then sharing this via a github repo.

Make sure the nodes are properly monitored. This may be accomplished deploying your own [substrate-telemetry](https://github.com/paritytech/substrate-telemetry) instance (can be used for substrate and polkadot networks) or connecting your node to [telemetry.polkadot.io] if you're joining a public network. Alternatively there are [Prometheus](prometheus.io) exporters available e.g. [https://github.com/w3f/substrate-telemetry-exporter] or [https://github.com/mixbytes/polkadot-prometheus-exporter] which can be used as well.

Feel free to use whatever tools or frameworks (like kubernetes, ansible, docker-compose or other) to accomplish the task. Task is preferably submitted by providing a Gitlab/Github repo with the results.

# Solution
## Prerequisites
- All deployment will be run on the default VPC. If you wish to build a new VPC you can use the repos below
    - https://github.com/muge13/ansible-provision-aws-vpc
    - https://github.com/muge13/terraform-provision-aws-vpc
- You have ansible installed locally 
- You have your AWS ec2 key pair, access_key and Secret key
## Steps
- [x] Provision Environment
- [x] Prepare and setup environment
- [x] Deploy Local Polkadot Network
- [x] Deploy Local Prometheus and Grafana Service
- [x] Refactor Grafana Visualizations
- [x] Aggregate Setup Scripts
- [x] Automate Setup and Deployment in Ansible Script
- [x] Run Final tests
- [x] Complete Documentation
- [x] Tear Down Test environment

### Base
- On your system set your AWS credentials on your environment
```
export AWS_ACCESS_KEY_ID="" &&  export AWS_SECRET_ACCESS_KEY="" && export AWS_REGION=""
```
- We can use the default ec2 host discovery or we can define the hosts in a host file similar to what we have in `hosts.ini`. This will require the modification of the command from `./ec2.py` to `./hosts.ini` and modifying the hosts in the playbook, alternatively you can limit to just the specific host on the playbook command.
### Provision Environment
- We will be working on AWS with a t2.medium instance with Amazon Linux as our test environment
It can be provisioned using the Ansible Script below
```
ansible-playbook  -T 60 -f 100  Provision.yml -e "vpc_id={vpc_id} ec2_keypair={available_keypair}"
```
- You can populate the `hosts.ini` file with the instance public DNS name or public IP
### Setup Environment
We have an ansible script to prepare the instance with docker and a number of preliminary requirements used to run the network
```
ansible-playbook -i ./hosts.ini -T 60 -f 100 --private-key=~/{keypair}.pem Setup.yml
```
### Deploy Services and setup all requirements
We have an ansible script that deploys all the services and sets up the monitoring scripts
```
ansible-playbook -i ./hosts.ini -T 60 -f 100 --private-key=~/{keypair}.pem Deploy.yml
```
### Teardown
We run the Ansible Teardown script defining the instance_id of the server to be terminated
```
ansible-playbook  -T 60 -f 100 TearDown.yml -e "instance_id={list_of_test_instances}"
```