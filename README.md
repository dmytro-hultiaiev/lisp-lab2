<p align="center"><b>МОНУ НТУУ КПІ ім. Ігоря Сікорського ФПМ СПіСКС</b></p>
<p align="center">
<b>Звіт з лабораторної роботи 2</b><br/>
"Рекурсія"<br/>
дисципліни "Вступ до функціонального програмування"
</p>
<p align="right"><b>Студент</b>: КВ-11 Гультяєв Дмитро</p>
<p align="right"><b>Рік</b>: 2024</p>

## Загальне завдання
Реалізуйте дві рекурсивні функції, що виконують деякі дії з вхідним(и) списком(-ами), за
можливості/необхідності використовуючи різні види рекурсії. Функції, які необхідно
реалізувати, задаються варіантом (п. 2.1.1). Вимоги до функцій:
1. Зміна списку згідно із завданням має відбуватись за рахунок конструювання нового
списку, а не зміни наявного (вхідного).
2. Не допускається використання функцій вищого порядку чи стандартних функцій
для роботи зі списками, що не наведені в четвертому розділі навчального
посібника.
3. Реалізована функція не має бути функцією вищого порядку, тобто приймати функції
в якості аргументів.
4. Не допускається використання псевдофункцій (деструктивного підходу).
5. Не допускається використання циклів.
Кожна реалізована функція має бути протестована для різних тестових наборів. Тести
мають бути оформленні у вигляді модульних тестів (див. п. 2.3).

Додатковий бал за лабораторну роботу можна отримати в разі виконання всіх наступних
умов:
робота виконана до дедлайну (включно з датою дедлайну)
крім основних реалізацій функцій за варіантом, також реалізовано додатковий
варіант однієї чи обох функцій, який працюватиме швидше за основну реалізацію,
не порушуючи при цьому перші три вимоги до основної реалізації (вимоги 4 і 5
можуть бути порушені), за виключенням того, що в разі необхідності можна також
використати стандартну функцію copy-list

## Варіант 5
1. Написати функцію remove-seconds , яка видаляє зі списку кожен другий елемент:
```lisp
CL-USER> (remove-seconds '(1 2 a b 3 4 d))
(1 A 3 D)
```
2. Написати функцію list-set-symmetric-difference , яка визначає симетричну
різницю двох множин, заданих списками атомів (тобто, множину елементів, що не
входять до обох множин):
```lisp
CL-USER> (list-set-symmetric-difference '(1 2 3 4) '(3 4 5 6))
(1 2 5 6) ; порядок може відрізнятись
```

## Лістинг функції remove-seconds
```lisp
(defun remove-seconds (lst n)
    (cond
        ((null lst) nil)
        ((oddp n) (remove-seconds(cdr lst) (+ n 1)))
        (t (cons (car lst) (remove-seconds(cdr lst) (+ n 1))))))
```
### Тестові набори
```lisp
(defun test-first-function ()
    (check-first-function "test 1" '((1 2 3 4 5 6 7 8 9 10) 0) '(1 3 5 7 9))  
    (check-first-function "test 2" '((1 1 1 1 1 1) 0) '(1 1 1)) 
    (check-first-function "test 3" '((1 '(2 3) 4 5 '(6 7 8)) 0) '(1 4 '(6 7 8)))
    (check-first-function "test 4" '(nil 0) nil)) 
```
### Тестування
```lisp
CL-USER> (defun remove-seconds (lst n)
    (cond
        ((null lst) nil)
        ((oddp n) (remove-seconds(cdr lst) (+ n 1)))
        (t (cons (car lst) (remove-seconds(cdr lst) (+ n 1))))))
 
(defun check-first-function (name input expected)
    "Execute `my-reverse' on `input', compare result with `expected' and print
    comparison status"
    (format t "~:[FAILED~;passed~] ~a~%"
        (equal (remove-seconds (car input) (cadr input)) expected)
        name))

(defun test-first-function ()
    (check-first-function "test 1" '((1 2 3 4 5 6 7 8 9 10) 0) '(1 3 5 7 9))  
    (check-first-function "test 2" '((1 1 1 1 1 1) 0) '(1 1 1)) 
    (check-first-function "test 3" '((1 '(2 3) 4 5 '(6 7 8)) 0) '(1 4 '(6 7 8)))
    (check-first-function "test 4" '(nil 0) nil)) 

CL-USER> (test-first-function)
passed test 1
passed test 2
passed test 3
passed test 4

```
## Лістинг функції list-set-symmetric-difference
```lisp
(defun list-set-symmetric-difference (list1 list2)
  (cond
    ((and (null list1) (null list2)) nil)
    ((null list1) list2)
    ((null list2) list1)
    ((contains (first list1) list2) (list-set-symmetric-difference (remove-first (first list1) list1) (remove-first (first list1) list2)))
    (t (cons (first list1) (list-set-symmetric-difference (rest list1) list2)))))
```
### Лістинг функції contains
```lisp
(defun contains (symbol list)
  (cond
    ((null list) nil)
    ((equal symbol (car list)) t)  
    (t (contains symbol (cdr list)))))  
```
### Лістинг функції remove-first
```lisp
(defun remove-first (item lst)
  (cond
    ((null lst) nil)
    ((equal item (car lst)) (cdr lst))
    (t (cons (car lst) (remove-first item (cdr lst))))))
```
### Тестові набори
```lisp
(defun test-second-function ()
    (check-second-function "test 1" '(1 2 3 4) '(3 4 5 6) '(1 2 5 6))  
    (check-second-function "test 2" '(1 1 1 1) '(1 1 1 1) nil) 
    (check-second-function "test 3" nil nil nil))  
```
### Тестування
```lisp
CL-USER> (defun contains (symbol list)
  (cond
    ((null list) nil)
    ((equal symbol (car list)) t)  
    (t (contains symbol (cdr list)))))  

(defun remove-first (item lst)
  (cond
    ((null lst) nil)
    ((equal item (car lst)) (cdr lst))
    (t (cons (car lst) (remove-first item (cdr lst))))))

(defun list-set-symmetric-difference (list1 list2)
  (cond
    ((and (null list1) (null list2)) nil)
    ((null list1) list2)
    ((null list2) list1)
    ((contains (first list1) list2) (list-set-symmetric-difference (remove-first (first list1) list1) (remove-first (first list1) list2)))
    (t (cons (first list1) (list-set-symmetric-difference (rest list1) list2)))))

(defun check-second-function (name input1 input2 expected)
    "Execute `my-reverse' on `input', compare result with `expected' and print
    comparison status"
    (format t "~:[FAILED~;passed~] ~a~%"
        (equal (list-set-symmetric-difference input1 input2) expected)
        name))

(defun test-second-function ()
    (check-second-function "test 1" '(1 2 3 4) '(3 4 5 6) '(1 2 5 6))  
    (check-second-function "test 2" '(1 1 1 1) '(1 1 1 1) nil) 
    (check-second-function "test 3" nil nil nil))  

CL-USER> (test-second-function)
passed test 1
passed test 2
passed test 3
```
