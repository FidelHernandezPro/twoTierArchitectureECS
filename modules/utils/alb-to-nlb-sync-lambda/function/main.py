import os
import socket
import boto3

elbv2 = boto3.client("elbv2")

def lambda_handler(event, context):
    alb_dns = os.environ["ALB_DNS_NAME"]
    target_group_arn = os.environ["NLB_TARGET_GROUP_ARN"]

    print(f"Resolving ALB: {alb_dns}")
    ips = socket.gethostbyname_ex(alb_dns)[2]
    print(f"Resolved IPs: {ips}")

    targets = [{"Id": ip, "Port": 80} for ip in ips]

    # Deregister existing targets
    old_targets = elbv2.describe_target_health(TargetGroupArn=target_group_arn)["TargetHealthDescriptions"]
    if old_targets:
        old_ids = [{"Id": t["Target"]["Id"], "Port": t["Target"]["Port"]} for t in old_targets]
        print(f"Deregistering old targets: {old_ids}")
        elbv2.deregister_targets(TargetGroupArn=target_group_arn, Targets=old_ids)

    print(f"Registering new targets: {targets}")
    elbv2.register_targets(TargetGroupArn=target_group_arn, Targets=targets)

    return {"message": "Target group updated"}
