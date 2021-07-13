from actions.services import *
from actions.helpers import logError, logInfo
from actions.OrderVM import OrderVM
from typing import Any, Text, Dict, List

from rasa_sdk import Action, Tracker
from rasa_sdk.executor import CollectingDispatcher
from rasa_sdk.events import UserUtteranceReverted, SlotSet


import json
from datetime import datetime
from dateutil import parser
import locale

locale.setlocale(locale.LC_ALL, 'vi_VN')



class ActionResetFoodNameSlot(Action):

    def name(self) -> Text:
        return "action_reset_food_name_slot"

    def run(self, dispatcher: CollectingDispatcher,
            tracker: Tracker,
            domain: Dict[Text, Any]) -> List[Dict[Text, Any]]:

        return [SlotSet("food_name", None)]

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

        logInfo(tracker.latest_message)
        logInfo("sender_id: " + str(tracker.sender_id))

        list_order = get_order_status(tracker.sender_id)
        if type(list_order) is list:
            if len(list_order) > 0:
                dispatcher.utter_message(response="utter_list_order_status")
                dispatcher.utter_message(json_message= {"payload": "list_order", "data": {"list_order": list_order,
                                                                                          "type":"list_order"}})
            else:
                dispatcher.utter_message(response="utter_list_order_empty")
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
                dispatcher.utter_message(json_message= {"payload": "list_food", "data": {"list_food": list_food,
                                                                                         "type":"list_food"}})
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
                dispatcher.utter_message(json_message=  {"payload": "list_food", "data": {"list_food": list_food,"type":"list_food"}})
            else:
                dispatcher.utter_message("Xin lỗi! Tôi không tìm thấy những món nào phù hợp với yêu cầu của bạn :(")
        else:
            logError(type(list_food))
            dispatcher.utter_message(response="utter_internal_error", error_message = list_food)
            
        return []


