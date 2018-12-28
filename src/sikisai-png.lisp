; Package sikisai-png
(defpackage sikisai-png
  (:use :cl)
  (:nicknames :sik-png)
  (:export load-png))
(in-package :sikisai-png)

; Number of element rgba.
(defvar *n-elem-rgba* 4)

#|
  Convert to gl bytes.
|#
(defun to-gl-bytes (bytes width height)
  (let ((gl-bytes (cffi:foreign-alloc '%gl:ubyte :count (* width height *n-elem-rgba*))))
      (loop for i from 0 to (1- (length bytes)) do
            (setf (cffi:mem-aref gl-bytes '%gl:ubyte i) (aref bytes i)))
      gl-bytes))

#|
  Load and convert png to raw.
|#
(defun load-png (path)
  (let* ((png-img (with-open-file (input path :element-type '(unsigned-byte 8))
                    (png:decode input :preserve-alpha t)))
         (width (png:image-width png-img))
         (height (png:image-height png-img))
         (raw-img (make-array (* width height *n-elem-rgba*) 
                              :element-type '(unsigned-byte 8))))
    (dotimes (y height raw-img)
      (dotimes (x width)
        (dotimes (e *n-elem-rgba*)
          (setf (aref raw-img (+ (* y width *n-elem-rgba*) (* x *n-elem-rgba*) e))
                (aref png-img y x e)))))
    
    (make-instance 'sik:raw :width width :height height :bytes (to-gl-bytes raw-img width height))))

(in-package :cl-user)

