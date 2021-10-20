# powershell-poc

This is a proof of concept for managing, developing, building, and shipping PowerShell projects within GitHub using [GitHub flow and techniques][github-services-workflow-guide].

## Overview

## Prerequisites

- [PowerShell 7][powershell-install]
- [dotnet 2.0 or newer][dotnet-install]

For local development or execution on remote machines, these will have to be installed and maintained through your preferred processes.

For continuous integration, these should be pre-installed in [`windows-2016`][actions-virtual-environment-windows-2016], [`windows-2019`][actions-virtual-environment-windows-2019], and [`windows-2022`][actions-virtual-environment-windows-2022] virtual environments.

[github-services-workflow-guide]: https://github.github.com/services-workflow-guide/#/
[powershellgallery-publishing-guidelines]: https://docs.microsoft.com/en-us/powershell/scripting/gallery/concepts/publishing-guidelines?view=powershell-7.1
[powershell-install]: https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell?view=powershell-7.1
[dotnet-install]: https://docs.microsoft.com/en-us/dotnet/core/tools/dotnet-install-script
[actions-virtual-environment-windows-2016]: https://github.com/actions/virtual-environments/blob/main/images/win/Windows2016-Readme.md
[actions-virtual-environment-windows-2019]: https://github.com/actions/virtual-environments/blob/main/images/win/Windows2019-Readme.md
[actions-virtual-environment-windows-2022]: https://github.com/actions/virtual-environments/blob/main/images/win/Windows2022-Readme.md
[actions-supported-runners]: https://docs.github.com/en/actions/using-github-hosted-runners/about-github-hosted-runners#supported-runners-and-hardware-resources