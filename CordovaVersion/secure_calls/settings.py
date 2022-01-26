from flask import Flask,render_template,request, redirect, url_for, g
from flask_json import FlaskJSON, JsonError, json_response, as_json
import jwt
import psycopg2  
import sys
import datetime
import bcrypt
import traceback

from db_con import get_db_instance, get_db
from tools.token_tools import create_token

from tools.logging import logger

def handle_request():
    logger.debug("Settings Handle Request")

    cur = g.db.cursor(); 
    try: 
	cur.execute("select * from users;") 
	booklist=cur.fetchall() 
	cur.close() 
    except: 
	logger.debug("cannot read from database") 
	return json_response(data={"message": "Error occured while reading from database."}, status=500)
	
    count=0 
    message = '{"books":[' 
    for b in booklist: 
	if b[0] < len(booklist) : 
	    message += '{"title":"'+str(b[1]) + '","price":"' + str(b[2]) + '"},' 
	else: 
	    message += '{"title":"'+str(b[1]) + '","price":"' + str(b[2]) + '"}' 
	message += "]}" 
	print(message)
    #print("sending silly token")
	    
    return json_response( token = create_token(  g.jwt_data ) , data = json.loads(message))
