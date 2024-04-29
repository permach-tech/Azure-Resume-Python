# Persell's Azure Resume

Hi everyone, this is my cloud resume challenge built in Azure. I utilized terraform to create the resource groups and resources in Azure for both the frontend and the backend. The static website is hosted on Azure blob storage and it is built using HTML, CSS, and Javascript.

![Azure-Flowchart (2)](https://github.com/permach-tech/Azure-Resume-Python/assets/92054692/4b8bf061-fc4a-4ab2-8f8a-d47b82842850)

## Demo

See the live version of my resume [here](https://resume.per-tech.org/)

## Tools Used
- VSCode
- Terraform
- Azure
- Bash
- Git
- GitHub Actions

## Frontend

The frontend static website is on an Azure Blob Storage Container where the HTML, CSS, Javascript and other resources for the site are stored.
- I took a college course on web development, so I was already familiar with the web design concept and langauge. I Ultimately used a template to help me out with the design (bonus points for the UT Dallas colors).
- Used Javascript to make an API call to the Azure function to update the visitor count. This [resource](https://www.geeksforgeeks.org/javascript-fetch-method/
) was very helpful in understanding the API call via Javascript.
- All frontend resources were deployed via Terraform

## Backend
