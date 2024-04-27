import logging
import azure.functions as func

def main(req: func.HttpRequest, inputDocument: func.DocumentList, outputDocument: func.Out[func.Document]) -> func.HttpResponse:
    logging.info('Python HTTP trigger function processed a request.')

    counter = inputDocument[0]['count'] + 1
    inputDocument[0]['count'] = counter
    outputDocument.set(func.Document.from_json(inputDocument[0].to_json()))

    return func.HttpResponse(f"{counter}", status_code=200 if counter else 500)
