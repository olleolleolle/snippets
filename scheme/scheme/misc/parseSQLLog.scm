; Copyright (c) 2002  Dustin Sallings <dustin@spy.net>
;
; $Id: parseSQLLog.scm,v 1.2 2002/12/28 00:57:09 dustin Exp $

(module parse-sql-log
	(import
	  (dates "../dates.scm")
	  (stringlib "../stringlib.scm"))
	(main main))

; Structure for holding log entries
(define-struct log-entry
			   time calls calltime)

; Parse the date out of the given line
(define (parse-date line)
  (+ (apply dates-seconds-for-time
		 (map string->integer
			  (string-split-chars
				(substring line 0 19)
				'(#\: #\space #\-)
				19)))
	 28800))

; Process each line
(define (get-log-entry line)
  (let ((rv (make-log-entry)))
	(log-entry-time-set! rv (parse-date line))
	(let ((parts (string-split-chars line '(#\space #\+) 12)))
	  (let ((tparts (string-split
					  (list-ref parts 10) #\/ 3)))
		(log-entry-calls-set! rv
							  (string->integer (list-ref tparts 1)))
		(log-entry-calltime-set! rv
								 (string->integer
								   (substring (car tparts) 0
											  (- (string-length
												   (car tparts))
												 2))))))
	rv))

(define (approx-time x)
  (* 60 (truncate (/ x 60))))

(define (print-update rrdfile last-time total-calls total-time)
  (print "update " rrdfile " "
		 ; (car (string-split (real->string last-time) #\. 2))
		 last-time
		 ":" total-calls ":" (flonum->fixnum total-time)))

(define (print-log-entry e)
  (display "Log entry:  ")
  (print (log-entry-time e)
		 " (" (car (string-split
					 (real->string (approx-time (log-entry-time e)))
					 #\. 2))
		 ") " (log-entry-calls e) "/" (log-entry-calltime e)))

; Grab each line from stdin, pass it to process-line-to-rrd
(define (process-to-rrd rrdfile)
  (let ( (last-time 0) (total-calls 0) (total-time 0))
	(let loop ((line (read-line (current-input-port))))
		(if (not (eof-object? line))
			(begin
				; If this line looks like what we want, process it
				(if (strstr line "database.DBManager.sql" 20)
				  (let ((le (get-log-entry line)))
					; (print-log-entry le)
					(let ((t (approx-time (log-entry-time le))))
					  (if (and
							(not (= t last-time))
							(not (zero? last-time))
							(> total-calls 0))
						(begin
						  (print-update rrdfile last-time total-calls
										total-time)
						  (set! total-calls 0)
						  (set! total-time 0)))
					  (if (> (log-entry-calls le) 0)
						(begin
						  (set! last-time t)
						  (set! total-calls (+ 1 total-calls))
						  (set! total-time (+ total-time
											  (truncate
												(/ (log-entry-calltime le)
												 (log-entry-calls le))))))))))
				(loop (read-line (current-input-port))))))))

; main, get the rrd file, and start processing stdin
(define (main args)
	(process-to-rrd (cadr args)))
