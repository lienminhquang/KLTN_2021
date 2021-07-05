from actions.vm.FoodVM import FoodVM
from datetime import datetime, timedelta
from typing_extensions import ParamSpecKwargs
import requests
import json
from actions.helpers import logError, logInfo
from actions.OrderVM import OrderVM

base_url = "https://localhost:6001"
username = "admin2"
password = "123456?a"
jwt = ""
token_expire =  datetime.now() 

def login():
    global jwt
    global token_expire

    url = base_url + "/api/Users/Login"
    payload = {
                "username": username,
                "password": password,
                "rememberMe": True
            }
    response = requests.post(url, 
            verify=False,
            data= json.dumps(payload),
            headers={"Content-Type": "application/json-patch+json"}
        )

    logInfo("Statuscode: " + str(response.status_code))
    if response.status_code == 200:
    
        result_json = json.loads(response.text)
        logInfo(result_json)
        
        jwt = result_json['payLoad']['accessToken']
        token_expire = datetime.now() + timedelta(hours=1)
        return True
    else:
        logError(response.reason)
        return False

def check_token():
    if token_expire <= datetime.now():
        login()

def get_order_status(sender_id):
    check_token()
    url = base_url + "/api/Orders/processing/user?userID=" + sender_id
    response = requests.get(url,
        headers={'Authorization':'Bearer ' + jwt},
        verify=False
    )
    
    logInfo("Statuscode: " + str(response.status_code))
    if response.status_code == 200:
    
        result_json = json.loads(response.text)
        logInfo(result_json)
        listOrderVM = []
        for i in range(0, len(result_json['payLoad'])):
            listOrderVM.append(OrderVM(**result_json['payLoad'][i]))

        return listOrderVM
    else:
        logError(response.reason)
        return "Đã xảy ra lỗi"

def search_food(food_name):
    check_token()
    url = base_url + "/api/Food?SearchString=" + food_name
    response = requests.get(url,
        headers={'Authorization':'Bearer ' + jwt},
        verify=False
    )
    
    logInfo("Statuscode: " + str(response.status_code))
    if response.status_code == 200:
    
        result_json = json.loads(response.text)
        logInfo(result_json)
        listFoodVM = []
        for i in range(0, len(result_json['payLoad']['items'])):
            listFoodVM.append(FoodVM(**result_json['payLoad']['items'][i]))
        logInfo(listFoodVM)
        return listFoodVM
    else:
        logError(response.reason)
        return "Đã xảy ra lỗi"

def find_most_discounted_food():
    check_token()
    url = base_url + "/api/Food/most_discounted"
    response = requests.get(url,
        headers={'Authorization':'Bearer ' + jwt},
        verify=False
    )
    
    logInfo("Statuscode: " + str(response.status_code))
    if response.status_code == 200:
    
        result_json = json.loads(response.text)
        logInfo(result_json)
        listFoodVM = []
        for i in range(0, len(result_json['payLoad']['items'])):
            listFoodVM.append(FoodVM(**result_json['payLoad']['items'][i]))
        logInfo(listFoodVM)
        return listFoodVM
    else:
        logError(response.reason)
        return "Đã xảy ra lỗi"


def find_best_selling_food():
    check_token()
    url = base_url + "/api/Food/best_selling"
    response = requests.get(url,
        headers={'Authorization':'Bearer ' + jwt},
        verify=False
    )
    
    logInfo("Statuscode: " + str(response.status_code))
    if response.status_code == 200:
    
        result_json = json.loads(response.text)
        logInfo(result_json)
        listFoodVM = []
        for i in range(0, min(5, len(result_json['payLoad']['items']))):
            listFoodVM.append(FoodVM(**result_json['payLoad']['items'][i]))
        logInfo(listFoodVM)
        return listFoodVM
    else:
        logError(response.reason)
        return "Đã xảy ra lỗi"
