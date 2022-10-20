HOST_ID1=`aws route53 list-hosted-zones | jq .HostedZones[].Id | grep -o 'zone/.*' | cut -f2- -d/ | sed s'/.$//'`
echo $HOST_ID1
HOST_ID2=`aws route53 list-resource-record-sets --hosted-zone-id $HOST_ID1 --query "ResourceRecordSets[?Name == 'qapetclinic.xyz.']" | jq .[].AliasTarget.HostedZoneId | sed 's/^"\(.*\)".*/\1/' | sed '2,3d'`
export HOST_ID2
LOAD_BALANCER=`kubectl describe svc --namespace=default | grep -o 'LoadBalancer Ingress:.*' | cut -f2- -d: | sed 's/^ *//g'
echo $LOAD_BALANCER
export LOAD_BALANCER
cat ./Jenkins/Scripts/Kubernetes/update.json | envsubst >./Jenkins/Scripts/Kubernetes/update2.json
cat ./Jenkins/Scripts/Kubernetes/update2.json
aws route53 change-resource-record-sets --hosted-zone-id $HOST_ID1 --change-batch file://./Jenkins/Scripts/Kubernetes/update2.json
