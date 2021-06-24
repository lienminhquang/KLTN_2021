from typing import Any, Text, Dict, List

from rasa_sdk import Action, Tracker
from rasa_sdk.executor import CollectingDispatcher
from rasa_sdk.events import UserUtteranceReverted



class ActionHelloWorld(Action):

    def name(self) -> Text:
        return "action_find_food_category"

    def run(self, dispatcher: CollectingDispatcher,
            tracker: Tracker,
            domain: Dict[Text, Any]) -> List[Dict[Text, Any]]:
        categoy = tracker.get_slot("category")
        if categoy.lower() == "bo":
            message = "Danh sách món bò"
        elif categoy.lower() == "trasua":
            message = "Danh sách trà sữa"
        elif categoy.lower() == "com":
            message = "Danh sách món cơm"
        elif categoy.lower() == "banhngot":
            message = "Danh sách bánh ngọt"
        else:
            message = "hiện tại chưa có món này"
        dispatcher.utter_message(text=message)

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
        dispatcher.utter_message("Xin lỗi, tôi không hiểu. Bạn có thể nhắc lại được không ?")

        # Revert user message which led to fallback.
        return [UserUtteranceReverted()]