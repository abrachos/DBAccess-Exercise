data "aws_iam_user" "github_action_user" {
  user_name = "githubaction_aws"
}

resource "aws_iam_role_policy_attachment" "github_action_user_AmazonEKSAdminPolicy" {
  role       = data.aws_iam_user.github_action_user.user_name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSAdminPolicy"
}

resource "aws_iam_role_policy_attachment" "github_action_user_AmazonEKSClusterAdminPolicy" {
  role       = data.aws_iam_user.github_action_user.user_name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

