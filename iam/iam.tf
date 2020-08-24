# resource "aws_iam_role" "ecs_service_role" {
#     name = "ecs_service_role"
#     assume_role_policy = file("policies/ecs-role.json")
# }

# resource "aws_iam_role_policy" "ecs_service_role_policy" {
#     name = "ecs_service_role_policy"
#     policy = file("policies/ecs-service-role-policy.json")
#     role = aws_iam_role.ecs_service_role.id
# }

resource "aws_iam_role" "fargate_execution_role" {
    name = "fargate_execution_role"
    assume_role_policy = file("policies/fargate-execution-role.json")
}

resource "aws_iam_role_policy" "fargate_execution_role_policy" {
    name = "fargate_execution_role_policy"
    policy = file("policies/fargate-execution-role-policy.json")
    role = aws_iam_role.fargate_execution_role.id
}