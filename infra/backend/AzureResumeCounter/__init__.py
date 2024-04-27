import logging

import azure.functions as func



# HTTP Request
def main(req: func.HttpRequest, inputDocument: func.DocumentList,
         outputDocument: func.Out[func.Document]) -> func.HttpResponse:
    logging.info('Python HTTP trigger function processed a request.')

    counter = getNewCounterValue(inputDocument[0]['count'])
    inputDocument[0]['count'] = counter
    outputDocument.set(func.Document.from_json(inputDocument[0].to_json()))
    if counter:
        return func.HttpResponse(f"{counter}", status_code=200)
    else:
        return func.HttpResponse(
            "Error",
            status_code=500)


def getNewCounterValue(value: int):
    return value + 1