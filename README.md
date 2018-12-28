# sikisai-png
PNG loader for sikisai.

## Description

sikisai-png is PNG loader for Sikisai.

## Features

* Load and convert PNG to RAW.

## Dependencies

sikisai-png depends these libraries.

* sikisai
* cl-png

notice:  
Currently (2018/12/28), cl-png on QuickLisp is older than that of on GitHub.  
cl-png on QuickLisp is NOT support for alpha channel.  
You must use cl-png on GitHub(https://github.com/ljosa/cl-png).

## Usage

```
; sik-png-test.lisp
(defpackage sik-png-test
  (:use :cl)
  (:export main))
(in-package :sik-png-test)

(defclass window (sik:window) ())

(defmethod sik:user-initialize ((this window))
  (defparameter *tex* (make-instance 'sik:texture :src (sik-png:load-png "./cat.png"))))

(defmethod sik:user-display ((this window))
  ; :a parameter needed to use alpha channel.
  (sik:image *tex* 100 100 :a 1.0))

(defun main ()
  (sik:display-window (make-instance 'window)))
```

```
; sik-png-test.asd
(defsystem "sik-png-test"
  :depends-on ("sikisai" "sikisai-png")
  :components ((:module "src"
                :components
                ((:file "sik-png-test")))))
```
