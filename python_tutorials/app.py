from flask import Flask, request, render_template
from textblob import TextBlob

app = Flask(__name__)

@app.route('/')
def my_app():
    return render_template('index.html')


@app.route('/', methods=['GET', 'POST'])
def analyze_sentiment():
    if request.method == 'POST':
        text = request.form['text']
        analysis = TextBlob(text)
        sentiment = "Positive" if analysis.sentiment.polarity > 0 else "Negative" if analysis.sentiment.polarity < 0 else "Neutral"
        return render_template('result.html', text=text, sentiment=sentiment, polarity=analysis.sentiment.polarity)
    return render_template('index.html')

if __name__ == '__main__':
    app.run(debug=True)
