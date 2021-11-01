# powershell-poc

This is a proof of concept on how you can develop, build, and package PowerShell projects within GitHub leverage [GitHub flow and techniques][github-services-workflow-guide] and [Azure DevOps Artifacts][azure-devops-artifacts].

## Prerequisites

- [PowerShell 7][powershell-install]
- [dotnet 2.0 or newer][dotnet-install]
- [Azure DevOps account][azure-devops]

For local development or execution on remote machines, these will have to be installed and maintained through your preferred processes.

For continuous integration, these should be pre-installed in various GitHub Actions virtual environments:
  - [ubuntu-18.04][actions-virtual-environment-ubuntu-1804]
  - [ubuntu-20.04][actions-virtual-environment-ubuntu-2004]
  - [windows-2016][actions-virtual-environment-windows-2016]
  - [windows-2019][actions-virtual-environment-windows-2019]
  - [windows-2022][actions-virtual-environment-windows-2022]

### Maintainer

The following is how a maintainer would setup the necessary [Azure DevOps Artifacts feed and tokens for private PowerShell repository][azure-devops-artifacts-powershell] this proof of concept is based on:

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

This primarily impacts PowerShell projects as developers on `dotnet` projects as the `nuget` and `dotnet nuget` CLIs work with NuGet GitHub Packages repositories as expected:

- [GitHub Packages: Private NuGet Packages via GitHub Actions][example-dotnet]
- [Example script for publishing a PowerShell module to the NuGet GitHub Package Registry][example-powershellget-01]
- [How To Setup A Github Actions Pipeline For Publishing Your Powershell Module (to PowerShell Gallery)][example-powershellget-02]
- [Consuming a NuGet package from GitHub Packages][example-nuget-samsmithnz]

[Azure DevOps Artifacts][azure-devops-artifacts] is the only [managed PowerShell repository solution with NuGet v2 support][powershell-private-repo-hosting] recommended by Microsoft capable of supporting private PowerShell repositories.

## Supported PowerShell versions

[GitHub-hosted runners][actions-supported-runners] have support for PowerShell 5.1 and/or 7.x depending on the virtual machine type and [shell][actions-shells] used:

| Virtual machine \ PowerShell version                     | 5.1          | 7.x    | Per-minute rate | End of life                                |
| -------------------------------------------------------- | ------------ | ------ | --------------: | ------------------------------------------ |
| [macos-10.15][actions-virtual-environment-macos-1015]    |              | `pwsh` |          $0.08  |                                            |
| [macos-11][actions-virtual-environment-macos-11]         |              | `pwsh` |          $0.08  |                                            |
| [ubuntu-18.04][actions-virtual-environment-ubuntu-1804]  |              | `pwsh` |          $0.008 |                                            |
| [ubuntu-20.04][actions-virtual-environment-ubuntu-2004]  |              | `pwsh` |          $0.008 |                                            |
| [windows-2016][actions-virtual-environment-windows-2016] | `powershell` | `pwsh` |          $0.016 | [March 15, 2022][actions-windows-2016-eol] |
| [windows-2019][actions-virtual-environment-windows-2019] | `powershell` | `pwsh` |          $0.016 |                                            |
| [windows-2022][actions-virtual-environment-windows-2022] | `powershell` | `pwsh` |          $0.016 |                                            |

For differences and history around PowerShell 5.1 _(Desktop)_ and 7.x _(Core)_, [read more][powershell-version-differences].

For information on how GitHub-hosted runners are billed, [read more][actions-billing].

<details>
  <summary>For confirming the version of PowerShell</summary>

  The following action workflow will show both PowerShell 5.1 and 7.x are installed on `windows-*` runners:

  ```
  on:
    workflow_dispatch:
  jobs:
    check-powershell-versions:
      strategy:
        matrix:
          runner:
            - windows-2016
            - windows-2019
            - windows-2022
      runs-on: ${{ matrix.runner }}
      steps:
        - run: |
            Get-Host
          shell: powershell

        - run: |
            Get-Host
          shell: pwsh
  ```

  resulting in:
  
  ```
  Name             : ConsoleHost
  Version          : 5.1.20348.230
  InstanceId       : b6a8f124-9444-4c21-9af8-5299d854b274
  UI               : System.Management.Automation.Internal.Host.InternalHostUserInterface
  CurrentCulture   : en-US
  CurrentUICulture : en-US
  PrivateData      : Microsoft.PowerShell.ConsoleHost+ConsoleColorProxy
  DebuggerEnabled  : True
  IsRunspacePushed : False
  Runspace         : System.Management.Automation.Runspaces.LocalRunspace
  ```
  
  and
  
  ```
  Name             : ConsoleHost
  Version          : 7.1.5
  InstanceId       : 58ae196a-c589-4e2f-aa78-c1b76f69cf1e
  UI               : System.Management.Automation.Internal.Host.InternalHostUserInterface
  CurrentCulture   : en-US
  CurrentUICulture : en-US
  PrivateData      : Microsoft.PowerShell.ConsoleHost+ConsoleColorProxy
  DebuggerEnabled  : True
  IsRunspacePushed : False
  Runspace         : System.Management.Automation.Runspaces.LocalRunspace
  ```
</details>

## PowerShell repository structure

This repository is a proof of concept and it is evolving as we learn from others and exercise ideas.  One of those areas is the relation of repository design and building artifacts.

- [Invoke-Automation "PowerShell Scaffolding – How I build modules"][building-modules-invokeautomation]
- [PowerShell Explained "Powershell: Adventures in Plaster"][building-modules-powershellexplained]
- [Rambling Cookie Monster "Building a PowerShell Module"][building-modules-ramblingcookiemonster]
- [Adam the Automator "Understanding and Building PowerShell Modules"][building-modules-adamtheautomator]

[actions-billing]: https://docs.github.com/en/billing/managing-billing-for-github-actions/about-billing-for-github-actions
[actions-shells]: https://docs.github.com/en/actions/learn-github-actions/workflow-syntax-for-github-actions#using-a-specific-shell
[actions-supported-runners]: https://docs.github.com/en/actions/using-github-hosted-runners/about-github-hosted-runners#supported-runners-and-hardware-resources
[actions-virtual-environment-macos-1015]: https://github.com/actions/virtual-environments/blob/main/images/macos/macos-10.15-Readme.md
[actions-virtual-environment-macos-11]: https://github.com/actions/virtual-environments/blob/main/images/macos/macos-11-Readme.md
[actions-virtual-environment-ubuntu-1804]: https://github.com/actions/virtual-environments/blob/main/images/linux/Ubuntu1804-README.md
[actions-virtual-environment-ubuntu-2004]: https://github.com/actions/virtual-environments/blob/main/images/linux/Ubuntu2004-README.md
[actions-virtual-environment-windows-2016]: https://github.com/actions/virtual-environments/blob/main/images/win/Windows2016-Readme.md
[actions-virtual-environment-windows-2019]: https://github.com/actions/virtual-environments/blob/main/images/win/Windows2019-Readme.md
[actions-virtual-environment-windows-2022]: https://github.com/actions/virtual-environments/blob/main/images/win/Windows2022-Readme.md
[actions-windows-2016-eol]: https://github.blog/changelog/2021-10-19-github-actions-the-windows-2016-runner-image-will-be-removed-from-github-hosted-runners-on-march-15-2022/
[azure-devops-artifacts-powershell]: https://docs.microsoft.com/en-us/azure/devops/artifacts/tutorials/private-powershell-library?view=azure-devops
[azure-devops-artifacts]: https://azure.microsoft.com/en-us/services/devops/artifacts/
[azure-devops]: https://azure.microsoft.com/en-us/services/devops/
[building-modules-adamtheautomator]: https://adamtheautomator.com/powershell-modules/#Adding_PSRepositories
[building-modules-invokeautomation]: https://invoke-automation.blog/2019/09/24/powershell-scaffolding-how-i-build-modules/
[building-modules-powershellexplained]: https://powershellexplained.com/2017-05-12-Powershell-Plaster-adventures-in/
[building-modules-ramblingcookiemonster]: http://ramblingcookiemonster.github.io/Building-A-PowerShell-Module/
[dotnet-install]: https://docs.microsoft.com/en-us/dotnet/core/tools/dotnet-install-script
[example-dotnet]: https://geoffhudik.com/tech/2020/10/04/github-packages-private-nuget-packages-via-github-actions/
[example-nuget-samsmithnz]: https://samlearnsazure.blog/2021/08/08/consuming-a-nuget-package-from-github-packages/
[example-powershellget-01]: https://gist.github.com/Badgerati/ecec3629cdc4c326ac3c8ba0fb99fe5a
[example-powershellget-02]: https://scriptingchris.tech/2021/05/16/how-to-setup-a-github-actions-pipeline-for-publishing-your-powershell-module/
[github-services-workflow-guide]: https://github.github.com/services-workflow-guide/#/
[invokeautomation]: https://github.com/jpsider/Invoke-Automation/
[packages-nuget]: https://docs.github.com/en/packages/working-with-a-github-packages-registry/working-with-the-nuget-registry
[pester]: https://github.com/pester/Pester
[plaster]: https://github.com/PowerShellOrg/Plaster
[powershell-about-comment-based-help]: https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_comment_based_help?view=powershell-7.1
[powershell-about-format]: https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_format.ps1xml?view=powershell-7.1
[powershell-install]: https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell?view=powershell-7.1
[powershell-private-repo-hosting]: https://docs.microsoft.com/en-us/powershell/scripting/gallery/how-to/working-with-local-psrepositories?view=powershell-7.1#use-packaging-solutions-to-host-powershellget-repositories
[powershell-version-differences]: https://docs.microsoft.com/en-us/powershell/scripting/whats-new/differences-from-windows-powershell?view=powershell-7.1
[powershellgallery-plaster]: https://www.powershellgallery.com/packages/Plaster/
[powershellgallery-publishing-guidelines]: https://docs.microsoft.com/en-us/powershell/scripting/gallery/concepts/publishing-guidelines?view=powershell-7.1
[powershellgallery-publishing-guidelines]: https://docs.microsoft.com/en-us/powershell/scripting/gallery/concepts/publishing-guidelines?view=powershell-7.1
[powershellget-nuget-support]: https://devblogs.microsoft.com/powershell/powershellget-3-0-preview-11-release/
