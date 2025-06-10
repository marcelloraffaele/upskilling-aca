# Demo Hello
## Introduction
This is a simple demo that use an Azure Container App to run a hello web page.
The source code of this image is available at [GitHub](https://github.com/marcelloraffaele/hello)
There are available differnt versions of the image, in order to test the different features of Azure Container Apps.

| Branch | Image |
|--------|--------|
| main | ghcr.io/marcelloraffaele/hello:main |
| blue | ghcr.io/marcelloraffaele/hello:blue |
| green | ghcr.io/marcelloraffaele/hello:green |
| under-construction | ghcr.io/marcelloraffaele/hello:under-construction |

## Run test script
Run the test script with the following command:

```powershell
.\2.test.ps1 -HOWMANY forever
```

