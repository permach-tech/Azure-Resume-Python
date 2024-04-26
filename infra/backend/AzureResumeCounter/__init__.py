import logging
import azure.functions as func

def main(context: func.Context, req: func.HttpRequest, data):
    context.bindings['outputDocument'] = data[0]
    context.bindings['outputDocument']['count'] += 1
    context.res = func.HttpResponse(
        body=str(context.bindings['outputDocument']['count']),
        mimetype="application/json"
    )