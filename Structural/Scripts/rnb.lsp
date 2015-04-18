;VVA
;make a copy of a block with a new name
;select block to copy
;enter new name unless anonymous block, then new name = ols name less *
;pick insertion point

(defun round (num prec)
  (* prec
     (if (minusp num)
       (fix (- (/ num prec) 0.5))
       (fix (+ (/ num prec) 0.5))
     )
  )
)
 
(defun C:rnb (/ *error* OldBlockName NewBlockName
 
rewind BlockName Info BlockInfo ent_name ent_info)
 
(defun *error* (Msg)
 
(cond
 
((or (not Msg)
 
(member Msg '("console break"
 
"Function cancelled"
 
"quit / exit abort"))))
 
((princ (strcat "\nError: " Msg)))
 
) ;cond
 
(princ)
 
) ;end error
 
(sssetfirst)

(setq oldEntity (entsel "\nSelect Block to copy: "))

(setq oldent (car oldEntity))

(setq OldBlockName oldEntity)
 
(while
 
(or
 
(null OldBlockName)
 
(/= "INSERT" (cdr (assoc 0 (entget (car OldBlockName)))))
 
)
 
(princ "\nSelection was not a block - try again...")
 
(setq OldBlockName (entsel "\nSelect Block to copy: "))
 
)
 
;block name
 
(setq OldBlockName (strcase (cdr (assoc 2 (entget (car OldBlockName))))))
 
(princ (strcat "\nSelected block name: " OldBlockName))
 
(if (= "*" (substr OldBlockName 1 1))
 
(setq NewBlockName (substr OldBlockName 2))
 
(setq NewBlockName (getstring T "\nEnter new block name: "))
 
)
 
(setq rewind T)
 
(while (setq Info (tblnext "BLOCK" rewind))
 
(setq BlockName (strcase (cdr (assoc 2 Info))))
 
(if (= OldBlockName BlockName)
 
(setq BlockInfo Info)
 
)
 
(setq rewind nil)
 
)
 
(if BlockInfo
 
(progn
 
(setq ent_name (cdr (assoc -2 BlockInfo)))
 
;header definition:

(setq le (entget oldent))

(entmake (list 
	'(0 . "BLOCK")
 
	(cons 2 NewBlockName)
 
	'(70 . 2)
 
	(cons 10 '(0 0 0))

	)
 
)
 
;body definition:
 
(entmake (cdr (entget ent_name)))
 
(while (setq ent_name (entnext ent_name))
 
(setq ent_info (cdr (entget ent_name)))
 
(entmake ent_info)
 
)
 
;footer definition:
 
(entmake '((0 . "ENDBLK")))
 
(command "-INSERT" NewBlockName (cdr (assoc 10 le)) (cdr (assoc 41 le)) (cdr (assoc 42 le)) (round (* 180 (/ (cdr (assoc 50 le)) 3.14 )) 1 ) )
(entdel oldent)
)


 
)
 
(*Error* nil)

(princ)

) ;end