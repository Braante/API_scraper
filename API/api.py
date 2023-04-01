from flask import Flask, jsonify, request
import pymongo

app = Flask(__name__)

app.config['MONGO_DBNAME'] = ''
app.config['MONGO_URI'] = ''

mongo = pymongo(app)

@app.route('/games', methods=['GET'])
def get_all_games():
    games = mongo.db.games

    output = []

    for q in games.find():
        output.append({'game' : q['name'], 'date' : q['date'], 'platform' : q['platform'], 'title' : q['title'], 'userscore' : q['userscore'], 'metascore' : q['metascore']})

    return jsonify({'result' : output})

if __name__ == '__main__':
    app.run(debug=True)