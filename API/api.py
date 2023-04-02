from flask import Flask, jsonify, request
from flask_pymongo import PyMongo
from datetime import datetime

app = Flask(__name__)

app.config['MONGO_DBNAME'] = 'scraper'
app.config['MONGO_URI'] = ''

mongo = PyMongo(app)

@app.route('/help', methods=['GET'])
def help():
    return jsonify({'For Your Help' : 
                    ("/games for all games",
                    "/games/<name> for one specific game by name",
                    "/platform/<platform> for game by this platform",
                    "/userscore/<number 0-10> for game by this userscore",
                    "/metascore/<number 0-100> for game by this metascore",
                    "/date/<date m_d_y> for game by this date",)
                    }
                    )

@app.route('/games', methods=['GET'])
def get_all_games():
    games = mongo.db.listGames

    output = []
    for q in games.find():
        try:
            output.append({'game' : q['name'], 'date' : q['date'], 'platform' : q['platform'], 'title' : q['title'], 'userscore' : q['userscore'], 'metascore' : q['metascore']})
        except:
            output.append("Wrong game data")
    return jsonify({'result' : output})


@app.route('/games/<name>', methods=['GET'])
def get_one_game(name):
    games = mongo.db.listGames

    q = games.find_one({'name' : name})

    if q:
        output = ({'game' : q['name'], 'date' : q['date'], 'platform' : q['platform'], 'title' : q['title'], 'userscore' : q['userscore'], 'metascore' : q['metascore']})
    else:
        output = 'No results found for this name'

    return jsonify({'result' : output})

@app.route('/platform/<name>', methods=['GET'])
def get_all_games_platform(name):
    games = mongo.db.listGames

    output = []
    for q in games.find({'platform': name}):
        try:
            output.append({'game' : q['name'], 'date' : q['date'], 'platform' : q['platform'], 'title' : q['title'], 'userscore' : q['userscore'], 'metascore' : q['metascore']})
        except:
            output.append("Wrong game data")
    return jsonify({'result' : output})

@app.route('/userscore/<name>', methods=['GET'])
def get_all_games_userscore(name):
    name = str(float(name))
    games = mongo.db.listGames

    output = []
    for q in games.find({'userscore': name}):
        try:
            output.append({'game' : q['name'], 'date' : q['date'], 'platform' : q['platform'], 'title' : q['title'], 'userscore' : q['userscore'], 'metascore' : q['metascore']})
        except:
            output.append("Wrong game data")
    return jsonify({'result' : output})

@app.route('/metascore/<name>', methods=['GET'])
def get_all_games_metascore(name):
    games = mongo.db.listGames

    output = []
    for q in games.find({'metascore': name}):
        try:
            output.append({'game' : q['name'], 'date' : q['date'], 'platform' : q['platform'], 'title' : q['title'], 'userscore' : q['userscore'], 'metascore' : q['metascore']})
        except:
            output.append("Wrong game data")
    return jsonify({'result' : output})

@app.route('/date/<name>', methods=['GET'])
def get_all_games_date(name):
    games = mongo.db.listGames
    try:
        name = datetime.strptime(name, '%m_%d_%y').strftime("%B %d, %Y")
    except:
        return jsonify({'result' : "Wrong Format date"})
    output = []
    for q in games.find({'date': name}):
        try:
            output.append({'game' : q['name'], 'date' : q['date'], 'platform' : q['platform'], 'title' : q['title'], 'userscore' : q['userscore'], 'metascore' : q['metascore']})
        except:
            output.append("Wrong game data")
    return jsonify({'result' : output})

if __name__ == '__main__':
    app.run(debug=True)