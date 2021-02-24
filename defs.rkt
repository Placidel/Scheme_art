; Copyright 2020
; Nathan Callahan

#lang scheme

(require 2htdp/image)
(provide atom wormhole atomic_flower orbit petal)

(define (atom n)
(overlay
   (ellipse 30 60 n "red")
   (ellipse 60 30 n "red")
   (rotate 45 (ellipse 60 30 n "blue"))
   (rotate -45 (ellipse 60 30 n "blue"))
   (circle 10 "solid" "black"))
)

(define (orbit n)
(overlay
   (ellipse (* n 2) n 100 "red")
   (ellipse (* n 2 2) (* n 2) 100 "blue")
   (ellipse (* n 2 2 2) (* n 2 2) 100 "green")
   (ellipse (* n 2 2 2 2) (* n 2 2 2) 100 "yellow")
   (circle 10 "solid" "black"))
)

(define (wormhole color%)
(overlay (regular-polygon 20 7 "solid" (make-color  50  50 255))
           (regular-polygon 26 7 "solid" (make-color 100 100 255))
           (regular-polygon 32 7 "solid" (make-color 150 150 255))
           (regular-polygon 38 7 "solid" (make-color 200 200 255))
           (regular-polygon 44 7 "solid" (make-color 250 250 255))
           (star-polygon 40 10 7 "solid" "navy"))
)

(define (atomic_flower color%)
(rotate 45(let ([at_petal (put-pinhole
                50 50
                (ellipse 100 60 100 "purple"))])
    (clear-pinhole
     (overlay/pinhole
      (atom 100)
      (rotate (* 90 0) at_petal)
      (rotate (* 90 1) at_petal)
      (rotate (* 90 2) at_petal)
      (rotate (* 90 3) at_petal))))))

(define (petal color%) (overlay/offset
        (ellipse 15 18 "solid" "black")
        -18 0
        (ellipse 30 50 "solid" color%)))