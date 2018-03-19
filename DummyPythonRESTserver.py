#!/usr/bin/env python3
'''
see REST with Python help :
 - http://flask.pocoo.org/docs/0.12/quickstart/
 - https://stackoverflow.com/questions/30779584/flask-restful-passing-parameters-to-get-request
'''
from flask import Flask, jsonify, request
# initialize application
app = Flask(__name__)
# index
@app.route('/')
def index():
    return "Hello, World!\n"
# dummiest WS
@app.route('/test/dummiest', methods=['POST','PUT','GET','DELETE'])
def dummiestParameter():
    return requestParser(request)
@app.route('/test/dummiest/<bar>', methods=['POST','PUT','GET','DELETE'])
def dummiestMember(bar):
    return requestParser(request)
# request parser
def requestParser(request):
    return jsonify(
        {
            'view_args': request.view_args,
            'host': request.host,
            'path': request.path,
            'method': request.method,
            'args': request.args,
            'jsonData': request.json
        }
    )
# main
if __name__ == '__main__':
    app.run()
