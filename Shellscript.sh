#!/bin/bash
mkdir -p claude_monet/kitchen/hot_station
mkdir -p claude_monet/kitchen/cold_station
mkdir -p claude_monet/hall
mkdir -p claude_monet/office
mkdir -p locker_room

cat > claude_monet/kitchen/hot_station/barinov_order << 'FILE_EOF'
Подготовить горячий цех к вечерней смене
Проверить рабочие места поваров
Макса к плите без разрешения не подпускать
FILE_EOF

cat > claude_monet/kitchen/hot_station/senya_task << 'FILE_EOF'
Сеня отвечает за мясные блюда
Получить продукты на складе
Перед закрытием проверить остатки
FILE_EOF

cat > claude_monet/kitchen/cold_station/fedya_task << 'FILE_EOF'
Федя отвечает за рыбные блюда
Проверить свежесть сибаса и дорадо
Подготовить холодные закуски для гостей
FILE_EOF

cat > claude_monet/kitchen/menu_draft << 'FILE_EOF'
Утиная ножка с овощами
Луковый суп по рецепту шефа
Фирменный десерт от Луи
Новое блюдо Макса отправлено на доработку
FILE_EOF

cat > claude_monet/hall/reservations << 'FILE_EOF'
Столик 3 забронирован на восемнадцать часов
Столик 7 подготовить для постоянных гостей
Большой стол оставить для вечернего банкета
FILE_EOF

cat > claude_monet/hall/guest_reviews << 'FILE_EOF'
Гости похвалили десерт и работу официантов
Один гость слишком долго ждал горячее блюдо
Постоянные гости попросили вернуть старое меню
Новый повар Макс показался гостям растерянным
FILE_EOF

cat > claude_monet/office/vika_schedule << 'FILE_EOF'
Вика проводит собрание перед открытием ресторана
В семнадцать часов проверить готовность зала
После смены принять отчёт от Макса
FILE_EOF

cat > locker_room/max_resume << 'FILE_EOF'
Максим Лавров приехал в Москву из Воронежа
Хочет стать профессиональным поваром
Готов работать в ресторане Claude Monet
Опыта мало, но желания много
FILE_EOF

cat > locker_room/leva_note << 'FILE_EOF'
Лёва должен показать Максу рабочее место
Объяснить правила кухни и порядок выдачи блюд
О результате доложить Виктору Петровичу
FILE_EOF

cat > nagiev_message << 'FILE_EOF'
Владелец ресторана приедет вечером
Подготовить лучший стол в зале
Баринов должен лично представить новое меню
FILE_EOF

cat > first_shift << 'FILE_EOF'
Макс прибыл в ресторан вовремя
Лёва выдал ему форму
Первая задача получена от шефа
FILE_EOF

chmod 755 claude_monet
chmod u=rwx,g=rx,o= claude_monet/kitchen
chmod 770 claude_monet/kitchen/hot_station 
chmod u=rw,g=r,o= claude_monet/kitchen/hot_station/barinov_order
chmod 640 claude_monet/kitchen/hot_station/senya_task 
chmod u=rwx,g=rx,o= claude_monet/kitchen/cold_station
chmod 600 claude_monet/kitchen/cold_station/fedya_task 
chmod u=rw,g=r,o=r claude_monet/kitchen/menu_draft
chmod 755 claude_monet/hall
chmod u=rw,g=rw,o=r claude_monet/hall/reservations 
chmod 444 claude_monet/hall/guest_reviews
chmod u=rwx,g=x,o= claude_monet/office
chmod 640 claude_monet/office/vika_schedule
chmod u=rwx,g=rx,o= locker_room
chmod 600 locker_room/max_resume
chmod u=r,g=r,o= locker_room/leva_note
chmod 444 nagiev_message
chmod u=rw,g=r,o=r first_shift
git init
git add claude_monet/
git add first_shift
git add locker_room/
git add nagiev_message
git commit -m "Моя лаба закоммичена наконец-то"

cp locker_room/max_resume claude_monet/office/candidate_max
cp -r claude_monet/hall claude_monet/kitchen/hall_backup
ln -s ../claude_monet/kitchen/menu_draft locker_room/first_menu
ln -s claude_monet/hall guest_zone
ln first_shift claude_monet/kitchen/shift_plan
cat claude_monet/kitchen/hot_station/senya_task claude_monet/kitchen/cold_station/fedya_task > claude_monet/kitchen/team_tasks
cat locker_room/leva_note >> first_shift
mv nagiev_message claude_monet/office/owner_message
git add .
git commit -m "Шаг 3 с копированием сделан 67"
git push

ls -lR | grep '^-' | sort -k5 -n -r | head -n 5
grep -rih "макс" . | grep -iv "отчёт" | sort -r | uniq | head -n 4
cat claude_monet/kitchen/hot_station/*_task claude_monet/kitchen/cold_station/*_task | grep -iE "блюд|продукт" | sort | wc -w
ls -lR | grep '^-' | awk '$2 == 2' | sort -k9 -r
head -n 1 -q claude_monet/kitchen/hot_station/* ; tail -n 1 -q claude_monet/kitchen/hot_station/* | sort
grep -i "гост" claude_monet/hall/guest_reviews | grep -iv "постоянн" | sort -r | head -n 2
grep -ril "гост" claude_monet/kitchen/hall_backup | wc -l
rm locker_room/max_resume
rm locker_room/first_menu
rm guest_zone
rm first_shift
rm claude_monet/kitchen/shift_plan
rm claude_monet/kitchen/cold_station/fedya_task
rmdir claude_monet/kitchen/cold_station
rm -rf claude_monet/kitchen/hall_backup
git add .
git commit -m "Лаба выполнена"
git push
