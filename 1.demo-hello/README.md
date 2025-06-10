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

Some api exposed by the image:
| API | Description |
|--------|--------|
| /api/version | Returns the version of the service |
| /api/hello | Returns a hello message |
| /api/time | Returns the current time |


## Run test script
Run the test script with the following command:

```powershell
# Run till you stop it
.\2.test.ps1 -HOWMANY forever
# or run it for a specific number of times
.\2.test.ps1 -HOWMANY 10
# or run it for a default number of times
.\2.test.ps1

```

