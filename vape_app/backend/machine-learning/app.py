from flask import Flask, request, jsonify, render_template
import pickle

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
    return prediction[0]

if __name__ == "__main__":
    app.run(debug=True)