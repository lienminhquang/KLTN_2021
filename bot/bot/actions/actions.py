from actions.services import *
from actions.helpers import logError, logInfo
from actions.OrderVM import OrderVM
from typing import Any, Text, Dict, List

from rasa_sdk import Action, Tracker
from rasa_sdk.executor import CollectingDispatcher
from rasa_sdk.events import UserUtteranceReverted


import json
from datetime import datetime
from dateutil import parser
import locale

locale.setlocale(locale.LC_ALL, 'vi_VN')




class ActionFindFood(Action):

    def name(self) -> Text:
        return "action_find_food"

    def run(self, dispatcher: CollectingDispatcher,
            tracker: Tracker,
            domain: Dict[Text, Any]) -> List[Dict[Text, Any]]:

        food_name = tracker.get_slot('food_name')
        
        list_food = search_food(food_name)

        if type(list_food) is list:

            if len(list_food) > 0:
                dispatcher.utter_message("Tôi tìm thấy những món này:")
                dispatcher.utter_message(json_message= {"payload": "list_food", "data": {"list_food": list_food}})
            else:
                dispatcher.utter_message("Xin lỗi! Tôi không tìm thấy những món nào phù hợp với yêu cầu của bạn :(")
        else:
            logError(type(list_food))
            dispatcher.utter_message(response="utter_internal_error", error_message = list_food)

        return []

class ActionDefaultFallback(Action):
    """Executes the fallback action and goes back to the previous state
    of the dialogue"""

    def name(self) -> Text:
        return "action_default_fallback"

    async def run(
        self,
        dispatcher: CollectingDispatcher,
        tracker: Tracker,
        domain: Dict[Text, Any],
    ) -> List[Dict[Text, Any]]:
        dispatcher.utter_message("Xin lỗi, tôi chưa hiểu ý bạn. Bạn có thể nói lại được không ?")

        # Revert user message which led to fallback.
        return [UserUtteranceReverted()]

class ActionCheckOrderStatus(Action):

    def name(self) -> Text:
        return "action_check_order_status"

    def run(self, dispatcher: CollectingDispatcher,
            tracker: Tracker,
            domain: Dict[Text, Any]) -> List[Dict[Text, Any]]:

        
        logInfo("sender_id: " + str(tracker.sender_id))
        
        result = get_order_status(tracker.sender_id)
        if type(result) is list:
            list_order = ""
            for i in range(0, len(result)):
                list_order += "Mã: " + str(result[i].id) + "\n"
                list_order += " - Danh sách món: "
                for j in range(0, len(result[i].orderDetailVMs)):
                    list_order += str(result[i].orderDetailVMs[j]['foodVM']['name']) + ", "
                list_order += "\n"
                list_order += " - Thời gian đặt: " + parser.parse(result[i].createdDate).strftime("%m/%d/%Y, %H:%M:%S") + "\n"
                list_order += " - Giao đến: " + str(result[i].addressString) + "\n"
                list_order += " - Giá: " + locale.currency(result[i].finalTotalPrice, grouping=True) + "\n"
                list_order += " - Trạng thái: " + result[i].orderStatusVM['name'] + "\n"
            dispatcher.utter_message(response="utter_list_order_status", list_order = list_order)
        else:
            logError(type(result))
            dispatcher.utter_message(response="utter_internal_error", error_message = result)

        return []

class ActionFindMostDiscountedFood(Action):

    def name(self) -> Text:
        return "action_find_most_discounted_food"

    def run(self, dispatcher: CollectingDispatcher,
            tracker: Tracker,
            domain: Dict[Text, Any]) -> List[Dict[Text, Any]]:
        
        list_food = find_most_discounted_food()

        if type(list_food) is list:

            if len(list_food) > 0:
                dispatcher.utter_message("Những món này đang giảm giá nhiều nhất nè:")
                dispatcher.utter_message(json_message= {"payload": "list_food", "data": {"list_food": list_food}})
            else: 
                dispatcher.utter_message("Xin lỗi hiện tại chưa có món nào đang giảm giá :(")
        else:
            logError(type(list_food))
            dispatcher.utter_message(response="utter_internal_error", error_message = list_food)
            
        return []

class ActionFindBestSellingFood(Action):

    def name(self) -> Text:
        return "action_find_best_selling_food"

    def run(self, dispatcher: CollectingDispatcher,
            tracker: Tracker,
            domain: Dict[Text, Any]) -> List[Dict[Text, Any]]:
        
        list_food = find_best_selling_food()

        if type(list_food) is list:

            if len(list_food) > 0:
                dispatcher.utter_message("Những món này đang bán chạy lắm nè: ")
                dispatcher.utter_message(json_message=  {"payload": "list_food", "data": {"list_food": list_food}})
            else:
                dispatcher.utter_message("Xin lỗi! Tôi không tìm thấy những món nào phù hợp với yêu cầu của bạn :(")
        else:
            logError(type(list_food))
            dispatcher.utter_message(response="utter_internal_error", error_message = list_food)
            
        return []


