from flask import Flask
from flask import jsonify
from requests import request
from flask import *
import random
# # from flask import request

from pyrebase import pyrebase
from pyrebase.pyrebase import Auth
import pyrebase



app = Flask(__name__)

config = {
            'apiKey': "AIzaSyDBtmBiZeDMgYLMzs5xDGP9GG1CnEOG72A",
            'authDomain': "netflix-8639f.firebaseapp.com",
            'databaseURL': "https://netflix-8639f.firebaseio.com",
            'projectId': "netflix-8639f",
            'storageBucket': "netflix-8639f.appspot.com",
            'messagingSenderId': "136161743894",
            'appId': "1:136161743894:web:c2d33c9d04bd7266739137",
            'measurementId': "G-E15639TN3E"}

firebase = pyrebase.initialize_app(config)
auth = firebase.auth()
db = firebase.database()

@app.route("/firebase/auth/sign_in", methods=["POST"])
def sign_in():
    if request.method == "POST":
        # gather user email / password
        query = request.form.to_dict()
        email = query["email"]
        password = query["password"]
        # sign in to auth
        user = auth.sign_in_with_email_and_password(email, password)
        # refresh the token
        user = auth.refresh(user['refreshToken'])



        # get users id
        localId = auth.current_user['localId']
        # structure db path into a string
        path = "users/{}".format(localId)
        # get token Id
        tokenId = auth.current_user['idToken']

        # post to database using movie id and user info
        data = db.child(path).get(tokenId)

    

        # return user
        return jsonify(data.val())

@app.route("/firebase/auth/create_user", methods=["POST"])
def create_user():
    if request.method == "POST":
        query = request.form.to_dict()
        # displayName = query['username']
        email = query["email"]
        password = query["password"]
        user = auth.create_user_with_email_and_password(email, password)
        # return jsonify(user)


#       MIGHT NEED THIS LATER
        auth.sign_in_with_email_and_password(email, password)
        # get users id
        localId = auth.current_user['localId']
        # structure db path into a string
        path = "users/{}".format(localId)
        # get token Id
        tokenId = auth.current_user['idToken']
        # new query to add
        new_query = {}
        new_query['email'] = query['email']
        new_query['password'] = query['password']
        new_query['num_user_id'] = str(random.randint(10000,999999999))
        new_query['user_id'] = localId
        new_query['username'] = "name"

        # post to database using movie id and user info
        db.child(path).set(new_query, tokenId)
        data = db.child(path).get(tokenId)

        movie_data = {}
        movie_data['user_id'] = new_query['num_user_id']
        movie_data['movie_id'] = "862"
        movie_data['rating'] = "5";
        movie_data['selected_by_ai'] = "false"


        db.child("ratings/{}/movies/{}".format(localId, movie_data['movie_id'])).set(movie_data,tokenId);
        return jsonify(data.val())

@app.route("/firebase/database/rating", methods=["POST", "GET"])
def rating():
    if request.method == "POST":
        # grabs data from request, in form of dictionary
        query = request.form.to_dict()
        # get users id
        localId = auth.current_user['localId']
        # get movie id
        movieId = query['movie_id']
        # structure db path into a string
        path = "ratings/{}/movies/{}".format(localId, movieId)
        # get token Id
        tokenId = auth.current_user['idToken']
        # post to database using movie id and user info
        data = db.child(path).set(query, tokenId)
        return jsonify(data)


    if request.method == "GET":
        # grabs data from request
        query = request.args
        # get uuid id
        localId = auth.current_user['localId']
        # get movie id
        movieId = query['movie_id']
        # get token Id
        tokenId = auth.current_user['idToken']
        # structure db path into a string
        path = "ratings/{}/movies/{}".format(localId, movieId)
        # grabs information from database
        data = db.child(path).get(tokenId)
        # returns json method
        return jsonify(data.val())

@app.route("/firebase/database/user", methods=["POST", "GET"])
def user():
    if request.method == "POST":
        # grabs data from request, in form of dictionary
        query = request.form.to_dict()
        # get users id
        localId = auth.current_user['localId']
        # structure db path into a string
        path = "users/{}".format(localId)
        # get token Id
        tokenId = auth.current_user['idToken']
        # post to database using movie id and user info
        data = db.child(path).set(query, tokenId)
        return jsonify(data)


    if request.method == "GET":
        # grabs data from request
        query = request.args
        # get uuid id
        localId = auth.current_user['localId']
        # get token Id
        tokenId = auth.current_user['idToken']
        # structure db path into a string
        path = "users/{}".format(localId)
        # grabs information from database
        data = db.child(path).get(tokenId)
        # returns json method
        return jsonify(data.val())

@app.route("/firebase/database/rating/random", methods=["GET"])
def random_rating():
    if request.method == "GET":
        # grabs data from request
        # query = request.args
        # get uuid id
        localId = auth.current_user['localId']
        # get movie id
        # movieId = query['movie_id']
        # get token Id
        tokenId = auth.current_user['idToken']
        # structure db path into a string
        path = "ratings/{}/movies".format(localId)
        # grabs information from database
        data = db.child(path).get(tokenId)
        values = data.val()


        # returns json method
        return jsonify()


@app.route("/firebase/database/ratings", methods=["GET"])
def ratings():
    if request.method == "GET":
        # grabs data from request
        # query = request.args
        # get uuid id
        localId = auth.current_user['localId']
        # get movie id
        # movieId = query['movie_id']
        # get token Id
        tokenId = auth.current_user['idToken']
        # structure db path into a string
        path = "ratings/{}/movies".format(localId)
        # grabs information from database
        data = db.child(path).get(tokenId)
        movies = data.val()

        list_of_movies =[]
        for value in movies:
            list_of_movies.append(movies[value])



        # returns json method
        return jsonify(list_of_movies)




if __name__ == "__main__":
    app.run(debug=True)
