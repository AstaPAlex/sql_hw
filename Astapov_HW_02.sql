--1. Посчитать количество заказов за все время
select cast(count(*) as int) as "count_orders"
from orders

--2. Посчитать сумму по всем заказам за все время (учитывая скидки)
select cast(sum(unit_price * quantity * (1 - discount)) as numeric(9,2)) as "sum_price_all_orders"
from order_details


--3. Показать сколько сотрудников работает в каждом городе.
select city, cast(count(*) as int) as "count_empl_in_city"
from employees
group by city

--4. Выявить самый продаваемый товар в штуках. Вывести имя продукта и его количество.
select product_name, cast(sum(quantity) as int) as "sum_sold_product"
from order_details od join products pr on pr.product_id = od.product_id
group by product_name
having sum(quantity) = (
	select max(sum)
	from (
		select *, sum(quantity) over(partition by product_id)
		from order_details
	)
)

--5. Выявить фио сотрудника, у которого сумма всех заказов самая маленькая
select first_name, last_name, cast( sum(unit_price * quantity * (1 - discount)) as numeric(9,2)) as "amount_sales_employee"
from orders ord join order_details od on ord.order_id = od.order_id
	join employees em on em.employee_id = ord.employee_id
group by first_name, last_name
having cast(sum(unit_price * quantity * (1 - discount)) as numeric(9,2)) = (
	select min(sum)
	from (
		select *, cast(sum(unit_price * quantity * (1 - discount)) over(partition by employee_id) as numeric(9,2))
		from orders ord join order_details od on ord.order_id = od.order_id
	)
)
	




