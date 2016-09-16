param
(
   [alias("s")]
   [string]$serverNameString = $(read-host -Prompt "Enter the ESX server Name"),
   [alias("v1ip")]
   [string]$switch1IPString = $(read-host -Prompt "Enter the switch 1 IP"),
   [alias("v3ip")]
   [string]$switch3IPString = $(read-host -Prompt "Enter the switch 3 IP")
)

echo "server is" $serverNameString
echo "switch 1 IP is:" $switch1IPString
echo "switch 3 IP is:" $switch3IPString


$switch1Name 	= 	"vSwitch1"
$switch1PG	=	"VMotion"
$switch1Nics	=	@("vmnic2","vmnic3")

$switch2Name 	= 	"vSwitch2"
$switch2PG	=	@(2,8,12,21,22,23,27,28,29,30,31,32,50,188)
$switch2Nics	=	@("vmnic8", "vmnic9")

$switch3Name 	= 	"vSwitch3"
$switch3PG	=	"IP_Storage"
$switch3Nics	=	@("vmnic6","vmnic7")
$vlan		=	""

#create vSwith1
New-VirtualSwitch -VMHost $serverNameString -Name $switch1Name -Nic $switch1Nics
New-VMHostNetworkAdapter -VMHost $serverNameString -VirtualSwitch $switch1Name  -PortGroup $switch1PG -IP $switch1IPString -SubnetMask 255.255.255.0 -VMotionEnabled:$true

#create vSwitch2
New-VirtualSwitch -VMHost $serverNameString -Name $switch2name -Nic $switch2Nics
foreach ($vlan in $switch2PG) {
$vlanname = "VLAN" + $vlan.tostring()
New-VirtualPortGroup -VirtualSwitch (Get-VirtualSwitch -Name vSwitch2 -VMHost $servernamestring)  -name "$vlanname" -VLanId $vlan
}


#create vSwitch3
New-VirtualSwitch -VMHost $serverNameString -Name $switch3Name -Nic $switch3Nics
New-VMHostNetworkAdapter -VMHost $serverNameString -VirtualSwitch $switch3Name  -PortGroup $switch3PG -IP $switch3IPString -SubnetMask 255.255.255.0










