window.addEventListener('DOMContentLoaded', (event) => {
    getVisitCount();
});

const functionApi = 'https://fa-rg-az-resume-python-api-prod-001.azurewebsites.net/api/AzureResumeCounter?code=bLbEvp5DWI8_7-4OiO8vUMXIlnaJSL8sZRCw65uasswvAzFuJsuoug==';

const getVisitCount = () => {
    let count = 30;
    fetch(functionApi).then(response => {
        return response.json()
    }).then(response => {
        count = response;
        document.getElementById('count').innerText = count;
    }).catch(function(error) {
        console.log(error);
      });
    return count;
}