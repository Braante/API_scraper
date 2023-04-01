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

@app.route('/games/<name>', method=['GET'])
def get_one_framework(name):
    games = mongo.db.games

    q = games.find_one({'name' : name})

    if q:
        output = ({'game' : q['name'], 'date' : q['date'], 'platform' : q['platform'], 'title' : q['title'], 'userscore' : q['userscore'], 'metascore' : q['metascore']})
    else:
        output = 'No results found for this name'

    return jsonify({'result' : output})

if __name__ == '__main__':
    app.run(debug=True)