# Playground One Terraform Template Scanner

Terraform Template Scanner implemented as GitHub Action.

Variants implemented:

- Terraform plan via shell script (`terraform-template-scan-shell.yaml`).
- Terraform plan action by [Daniel Flook](https://github.com/dflook/terraform-github-actions/tree/main/terraform-plan) (`terraform-template-scan-tfaction.yaml`).
- CloudFormation template via shell script (`cloudformation-template-scan-shell.yaml`)

All variants are using the same [Vision One Cloud Posture API](https://automation.trendmicro.com/xdr/api-beta#tag/Template-scanner/paths/~1beta~1cloudPosture~1scanTemplate/post).

## Requirements

- Vision One API-Key (Cloud Posture -> View)

## Secrets

The workflow requires secrets to be set. For that navigate to `Settings --> Security --> Secrets and variables --> Actions --> Secrets`.

For simplicity, authentication to AWS is done via access and secret access key. Alternative and likely better variants are described [here](https://github.com/marketplace/actions/configure-aws-credentials-action-for-github-actions).

Add the following secrets:

- API_KEY: `<Your Vision One API Key>`
- AWS_ACCESS_KEY_ID
- AWS_SECRET_ACCESS_KEY

The included terraform configuration requires additionally:

- AWS_REGION
- AWS_ACCOUNT_ID

## Template

```yaml
env:
...
  # Vision One API Key
  API_KEY: ${{ secrets.API_KEY }}

  # Region in which Vision One serves your organisation
  REGION: ""  # Examples: "eu." "sg." Leave blank if running in us.

  # Scan result threshold (fail on risk-level or higher)
  # THRESHOLD: any
  # THRESHOLD: critical
  THRESHOLD: high
  # THRESHOLD: medium
  # THRESHOLD: low
...
```

Below, the workflow tamplate. Adapt it to your needs and save it as a `yaml`-file in the `.github/workflow` directory.

Adapt the environment variables in the `env:`-section as required.

Variable          | Purpose
----------------- | -------
`REGION`          | Vision One Region of choice (e.g. "eu." "sg." Leave blank if running in us).
`THRESHOLD`       | Defines the fail condition of the action in relation to discovered vulnerabilities. A threshold of `critical` does allow any number of vulnerabilities up to the criticality `high`. 

Allowed values for the `THRESHOLD` are:

- `any`: No vulnerabilities allowed.
- `critical`: Max risk-level of discovered findings is `high`.
- `high`: Max risk-level of discovered findings is `medium`.
- `medium`: Max risk-level of discovered findings is `low`.
- `low`: Max risk-level of discovered findings is `negligible`.

If the `THRESHOLD` is not set, vulnerabilities will not fail the pipeline.

## Test

Any push --tags on the main branch will trigger the actions.

## Support

This is an Open Source community project. Project contributors may be able to help, depending on their time and availability. Please be specific about what you're trying to do, your system, and steps to reproduce the problem.

For bug reports or feature requests, please [open an issue](../../issues). You are welcome to [contribute](#contribute).

Official support from Trend Micro is not available. Individual contributors may be Trend Micro employees, but are not official support.

## Contribute

I do accept contributions from the community. To submit changes:

1. Fork this repository.
1. Create a new feature branch.
1. Make your changes.
1. Submit a pull request with an explanation of your changes or additions.

I will review and work with you to release the code.
