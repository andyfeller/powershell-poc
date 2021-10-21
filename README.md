# powershell-poc

This is a proof of concept on how you can develop, build, and package PowerShell projects within GitHub leverage [GitHub flow and techniques][github-services-workflow-guide] and [Azure DevOps Artifacts][azure-devops-artifacts].

## Prerequisites

- [PowerShell 7][powershell-install]
- [dotnet 2.0 or newer][dotnet-install]
- [Azure DevOps account][azure-devops]

For local development or execution on remote machines, these will have to be installed and maintained through your preferred processes.

For continuous integration, these should be pre-installed in various GitHub Actions virtual environments:
  - [`ubuntu-18.04`][actions-virtual-environment-ubuntu-1804]
  - [`ubuntu-20.04`][actions-virtual-environment-ubuntu-2004]
  - [`windows-2016`][actions-virtual-environment-windows-2016]
  - [`windows-2019`][actions-virtual-environment-windows-2019]
  - [`windows-2022`][actions-virtual-environment-windows-2022]

### Maintainer

1. [Create Azure DevOps Artifacts feed and personal access token (PAT) for CI][azure-devops-artifacts-powershell]

   <details>
     <summary>Only <b>Packaging (Read & Write)</b> permissions needed</summary>

     ![Screenshot of Azure DevOps personal access tokens needed by maintainer for GitHub Actions to publish to Azure Artifacts feed](docs/assets/maintainer-azure-devops-pat.png)
   </details>

   <details>
     <summary>Consider disabling any unnecessary Azure DevOps services</summary>

     ![Screenshot of Azure DevOps project containing Azure Artifacts feed, demonstrating everything but Azure Artifact disabled](docs/assets/maintainer-azure-devops-project.png)
   </details>

   <details>
     <summary>Azure Artifact feeds support both NuGet v2 and v3 APIs</summary>

     Replacing `/v3/index.json` with `/v2/` should allow this feed to be used by PowerShellGet.

     ![Screenshot of NuGet-based Azure Artifacts feed, demonstrating NuGet configuration and commands to work with feed](docs/assets/maintainer-azure-devops-feed.png)
   </details>

1. Create GitHub Actions secret with Azure DevOps Artifacts PAT

   <details>
     <summary>GitHub Action secrets are obscured in runner logs</summary>

     ![Screenshot of GitHub repository settings for actions secrets available to actions runners including secret of Azure Artifacts PAT to publish artifacts](docs/assets/maintainer-actions-secret.png)
   </details>

### Contributor

1. 

### System Administrator

1. 

## Why recommend Azure DevOps Artifacts?

As of October 2021, the [PowerShellGet 3.0 beta with NuGet v3 support][powershellget-nuget-support] has a couple of known issues using [NuGet-based GitHub Packages][packages-nuget] as a PowerShell repository:

- https://github.com/PowerShell/PowerShellGet/issues/163
- https://github.com/OneGet/oneget/issues/430

This has forced people to work outside of [best practices in publishing PowerShell packages][powershellgallery-publishing-guidelines] of using PowerShellGet to interact with repositories:

- [GitHub Packages: Private NuGet Packages via GitHub Actions][example-dotnet]
- [Example script for publishing a PowerShell module to the NuGet GitHub Package Registry][example-powershellget-01]
- [How To Setup A Github Actions Pipeline For Publishing Your Powershell Module (to PowerShell Gallery)][example-powershellget-02]
- [Consuming a NuGet package from GitHub Packages][example-nuget-samsmithnz]

### PowerShell repository structure

In figuring out how to structure repositories for modules, scripts, and packages, I found several articles that were really well written and provided opinionated, concrete approaches:

- [Invoke-Automation "PowerShell Scaffolding – How I build modules"][building-modules-invokeautomation]
- [PowerShell Explained "Powershell: Adventures in Plaster"][building-modules-powershellexplained]
- [Rambling Cookie Monster "Building a PowerShell Module"][building-modules-ramblingcookiemonster]

[powershellgallery-plaster]: https://www.powershellgallery.com/packages/Plaster/
[invokeautomation]: https://github.com/jpsider/Invoke-Automation/
[github-services-workflow-guide]: https://github.github.com/services-workflow-guide/#/
[powershellgallery-publishing-guidelines]: https://docs.microsoft.com/en-us/powershell/scripting/gallery/concepts/publishing-guidelines?view=powershell-7.1
[powershell-install]: https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell?view=powershell-7.1
[dotnet-install]: https://docs.microsoft.com/en-us/dotnet/core/tools/dotnet-install-script
[actions-virtual-environment-windows-2016]: https://github.com/actions/virtual-environments/blob/main/images/win/Windows2016-Readme.md
[actions-virtual-environment-windows-2019]: https://github.com/actions/virtual-environments/blob/main/images/win/Windows2019-Readme.md
[actions-virtual-environment-windows-2022]: https://github.com/actions/virtual-environments/blob/main/images/win/Windows2022-Readme.md
[actions-virtual-environment-ubuntu-1804]: https://github.com/actions/virtual-environments/blob/main/images/linux/Ubuntu1804-README.md
[actions-virtual-environment-ubuntu-2004]: https://github.com/actions/virtual-environments/blob/main/images/linux/Ubuntu2004-README.md
[actions-supported-runners]: https://docs.github.com/en/actions/using-github-hosted-runners/about-github-hosted-runners#supported-runners-and-hardware-resources
[pester]: https://github.com/pester/Pester
[plaster]: https://github.com/PowerShellOrg/Plaster
[building-modules-invokeautomation]: https://invoke-automation.blog/2019/09/24/powershell-scaffolding-how-i-build-modules/
[building-modules-powershellexplained]: https://powershellexplained.com/2017-05-12-Powershell-Plaster-adventures-in/
[building-modules-ramblingcookiemonster]: http://ramblingcookiemonster.github.io/Building-A-PowerShell-Module/
[powershell-about-comment-based-help]: https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_comment_based_help?view=powershell-7.1
[powershell-about-format]: https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_format.ps1xml?view=powershell-7.1
[azure-devops]: https://azure.microsoft.com/en-us/services/devops/
[azure-devops-artifacts]: https://azure.microsoft.com/en-us/services/devops/artifacts/
[azure-devops-artifacts-powershell]: https://docs.microsoft.com/en-us/azure/devops/artifacts/tutorials/private-powershell-library?view=azure-devops
[packages-nuget]: https://docs.github.com/en/packages/working-with-a-github-packages-registry/working-with-the-nuget-registry
[powershellget-nuget-support]: https://devblogs.microsoft.com/powershell/powershellget-3-0-preview-11-release/
[example-dotnet]: https://geoffhudik.com/tech/2020/10/04/github-packages-private-nuget-packages-via-github-actions/
[example-nuget-samsmithnz]: https://samlearnsazure.blog/2021/08/08/consuming-a-nuget-package-from-github-packages/
[example-powershellget-01]: https://gist.github.com/Badgerati/ecec3629cdc4c326ac3c8ba0fb99fe5a
[example-powershellget-02]: https://scriptingchris.tech/2021/05/16/how-to-setup-a-github-actions-pipeline-for-publishing-your-powershell-module/
[powershellgallery-publishing-guidelines]: https://docs.microsoft.com/en-us/powershell/scripting/gallery/concepts/publishing-guidelines?view=powershell-7.1
