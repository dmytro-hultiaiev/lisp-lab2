(defun remove-seconds (lst)
    (cond
        ((null lst) nil)
        ((null (cdr lst)) (list (car lst)))
        (t (cons (car lst) (remove-seconds (cddr lst))))))
 
(defun check-first-function (name input expected)
    "Execute `my-reverse' on `input', compare result with `expected' and print
    comparison status"
    (format t "~:[FAILED~;passed~] ~a~%"
        (equal (remove-seconds input) expected)
        name))

(defun test-first-function ()
    (check-first-function "test 1" '(1 2 3 4 5 6 7 8 9 10) '(1 3 5 7 9))  
    (check-first-function "test 2" '(1 1 1 1 1 1) '(1 1 1)) 
    (check-first-function "test 3" '(1 '(2 3) 4 5 '(6 7 8)) '(1 4 '(6 7 8)))
    (check-first-function "test 4" nil nil))


(defun contains (symbol list)
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
    ((contains (first list1) list2) (list-set-symmetric-difference (rest list1) (remove-first (first list1) list2)))
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