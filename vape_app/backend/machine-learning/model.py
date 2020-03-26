import numpy as np
import pandas as pd
import pickle

data = pd.read_csv('training_data.csv')
data = data.rename(columns={'Category': 'category', 'Descript': 'message'})

#ML

import nltk
nltk.download('stopwords')
import re
from nltk.corpus import stopwords
from nltk.stem import SnowballStemmer
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.svm import LinearSVC
from sklearn.pipeline import Pipeline
from sklearn.model_selection import train_test_split
from sklearn.feature_selection import SelectKBest, chi2

removal = SnowballStemmer('english')
stoppingwords = stopwords.words("english")

data['cleaned'] = data['message'].apply(lambda x: " ".join([removal.stem(i) for i in re.sub("[^a-zA-Z]", " ", x).split() if i not in stoppingwords]).lower())


X_train, X_test, y_train, y_test = train_test_split(data['cleaned'], data.category, test_size=0.2)

pipeline = Pipeline([('vect', TfidfVectorizer(ngram_range=(1, 1), stop_words="english", sublinear_tf=True)),
                     ('chi',  SelectKBest(chi2, k='all')),
                     ('clf', LinearSVC(C=0.8, penalty='l1', max_iter=5000, dual=False))])


model = pipeline.fit(X_train, y_train)

vectorizer = model.named_steps['vect']
chi = model.named_steps['chi']
clf = model.named_steps['clf']

feature_names = vectorizer.get_feature_names()
feature_names = [feature_names[i] for i in chi.get_support(indices=True)]
feature_names = np.asarray(feature_names)

target_names = ['Time of Day', 'Wake-up routine', 'Boredom', 'Vape smell', 'Stress', 'Seeing someone vaping', 'Fatigue', 'Partying', 'Sex']
'''
print("top 10 keystoppingwords per class:")
for i, label in enumerate(target_names):
    top10 = np.argsort(clf.coef_[i])[-10:]
    print("%s: %s" % (label, " ".join(feature_names[top10])))
'''
#print("accuracy score: " + str(model.score(X_test, y_test)))

pickle.dump(model, open('model.pkl','wb'))
model_pickle = pickle.load(open('model.pkl','rb'))
print(model_pickle.predict(['smell']))