from flask import Flask, request, jsonify, render_template
import pickle
import json


app = Flask(__name__)
model = pickle.load(open('model.pkl', 'rb'))

@app.route('/')
def index():
    prediction = model.predict(['smell'])
    return prediction[0]


@app.route('/predict',methods=['POST'])
def predict():
    final_feature = [request.json['trigger']]
    prediction = model.predict(final_feature)
    return json.dumps({'trigger':prediction[0].replace(u'\xa0',u' ')})

if __name__ == "__main__":
    app.run(debug=True)