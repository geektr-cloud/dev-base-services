#!/usr/bin/env bash
esxi_host=ryou.geektr.co

vm_name=co.geektr.dev-base-services
vm_ip=10.2.1.10
vm_domain=dev-base-services.geektr.co

service_ip=10.0.0.4
service_domains=(
    git.geektr.co
    npm.geektr.co
    registry.geektr.co
)

govc vm.create -u $esxi_host \
    -ds=main-storage \
    -m=8192 \
    -c=4 \
    -g=debian10_64Guest \
    --net.adapter=vmxnet3 \
    -net=vlan-vms \
    --disk.controller=pvscsi \
    -disk=base/debian10-docker.vmdk \
    -on=false \
    $vm_name

govc vm.network.add -u $esxi_host \
    -vm=$vm_name \
    --net.adapter=vmxnet3 \
    -net=vlan-base

echo "vm created"

govc vm.power -u $esxi_host -on=true $vm_name

vm_mac=$(govc device.info -u $esxi_host -vm $vm_name -json ethernet-0 | jq -r ".Devices[].MacAddress")
service_mac=$(govc device.info -u $esxi_host -vm $vm_name -json ethernet-1 | jq -r ".Devices[].MacAddress")

ssh router "/ip dhcp-server lease add comment=$vm_domain mac-address=$vm_mac      server=dhcp-vms  address=$vm_ip"
ssh router "/ip dhcp-server lease add comment=$vm_domain mac-address=$service_mac server=dhcp-base address=$service_ip"

ssh router "/ip dns static add name=$vm_domain address=$vm_ip"

for domain in "${service_domains[@]}"
do
    ssh router "/ip dns static add name=$domain address=$service_ip"
done

echo "network configured"

printf "waiting sshd startup ..."
while ! nc -z $vm_ip 22; do
  printf '.'
  sleep 3
done

ssh -o "StrictHostKeyChecking=no" "$vm_ip" \
    "sudo su -c 'hostnamectl set-hostname $vm_domain'"

echo "hostname configured"
