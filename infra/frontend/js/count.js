window.addEventListener('DOMContentLoaded', (event) => {
    getVisitCount();
});


const functionApi = 'https://pamfunction.azurewebsites.net/api/HttpTrigger1?code=_r5AaxxqytcrXYluGJG4LOQyjACg9SOLnJP1Wo2YKvd1AzFuGB6fxg=='; 

const getVisitCount = () => {
    let count = 0;
    fetch(functionApi)
    .then(response => {
        return response.json()
    })
    .then(response => {
        count = response;
        document.getElementById('count').innerText = count;
    }).catch(function(error) {
        console.log(error);
      });
    return count;
}