# KLTN_2021

## How to add more example to improve performance of the model.
### Setup
1. Start Rasa X 
```
rasa x --enable-api --cors "*"
```
2. Start Rasa Action server on other tab
```
rasa run actions
```
3. Run FoodOrder backend server
### Train
1. On Rasa-X page, go to `Talk to your bot` and enter the message that you think the user may utter. For example:
```
trà sữa trân châu hạ long
```
2. Don't need to care about the response of the bot, go to `NLU inbox` tab, check the sentence that you just added.
- If it was predict with the wrong intent, select the correct intent in the dropdown box.
![select the correct intent](https://github.com/lienminhquang/KLTN_2021/blob/main/select_the_correct_intent.png)
- Next, check if the entity was extract correctly. If not, `Left-Click` on the Entity and Click the `Remove` button to remove wrong entity
![Select the correct entity](https://github.com/lienminhquang/KLTN_2021/blob/main/incorrect_entity.png)
Then Select the correct entity in the sentence:
![Select the correct entity](https://github.com/lienminhquang/KLTN_2021/blob/main/select_the_correct_entity.png)
and choose the correct entity_type on the popup:
![Select the correct entity](https://github.com/lienminhquang/KLTN_2021/blob/main/select_the_correct_entity_type.png)
, check if every thing is correct and click apply.
- Mark correct and go to step 1 with other message.
![Select the correct entity](https://github.com/lienminhquang/KLTN_2021/blob/main/mark_correct.png)

