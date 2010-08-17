;;
;;  CL-WHOIS  -  WHOIS Protocol in Common Lisp
;;
;;  Copyright 2010 Thomas de Grivel <billitch@gmail.com>
;;
;;  Permission is hereby granted, free of charge, to any person
;;  obtaining a copy of this software and associated documentation
;;  files (the "Software"), to deal in the Software without
;;  restriction, including without limitation the rights to use, copy,
;;  modify, merge, publish, distribute, sublicense, and/or sell copies
;;  of the Software, and to permit persons to whom the Software is
;;  furnished to do so, subject to the following conditions:
;;  
;;  The above copyright notice and this permission notice shall be
;;  included in all copies or substantial portions of the Software.
;;
;;  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
;;  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
;;  MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
;;  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
;;  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
;;  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
;;  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
;;  DEALINGS IN THE SOFTWARE.
;;

(in-package :cl-whois)

(defun whois (name &key (server cl-whois.servers:whois.internic.net))
  (let* ((socket (usocket:socket-connect server 43))
	 (stream (usocket:socket-stream socket)))
    (format stream "~A~C~C" name #\Newline #\Linefeed)
    (finish-output stream)
    (with-output-to-string (answer)
      (loop
	 with buffer = (make-array 8192 :element-type 'character)
	 for length = (read-sequence buffer stream)
	 until (zerop length)
	 do (write-sequence buffer answer :end length)))))
