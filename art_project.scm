;Copyright 2020
;Nathan Callahan

;Recursion is used in the dragon-recur function (lines 12 - 49) to create the blue grid across the screen.
;A Higher order function is used to create the center "atomic flower" in lines 93-103

#lang scheme
(require 2htdp/image)

(define (rnd-color)
  (make-color (exact-round (* 255 (random))) (exact-round (* 255 (random))) (exact-round (* 255 (random)))))

(define (dragon-recur n x y image% theta) ;n= iterations x/y = start position image% = image to be added to theta = 1 for N/S facing 0 for W/E facing
  (if (or (<= y 0) (>= y 600)) (set! y 300) (set! y y))
  (if (or (<= x 0) (>= x 800)) (set! x 400) (set! x x))
  (if (<= n 0)
      (place-image
       (circle 5 "outline" (make-color 0 0 255 30)) (+ x 5) (+ y 5) image%)
      ;else
      
      (if (= theta 0)
          (let ([v (random 2)])
            (case v
              [(0) (add-line (dragon-recur (- n 1) x (+ y 10) image% 1) x y x (+ y 10) (make-color 0 0 255 30))]
             
              [(1) (add-line (dragon-recur (- n 1) x (- y 10) image% 1) x y x (- y 10) (make-color 0 0 255 30))]))
  
      (let ([v (random 2)])
        (case v
          [(0) (add-line (dragon-recur (- n 1) (+ x 10) y image% 0) x y (+ x 10) y (make-color 0 0 255 30))]
    
          [(1) (add-line (dragon-recur (- n 1) (- x 10) y image% 0) x y (- x 10) y (make-color 0 0 255 30))]))
      )
          
      )
  )

(define (flower color1% color2%)

  (overlay/offset
   (circle 10 "solid" "black")
   0 8
   (overlay/offset
    (rotate -180 (pulled-regular-polygon 100 3 1.8 30 "solid" color1%))
    0 -15
    (pulled-regular-polygon 50 5 1.2 135 "solid" color2%)
    )
   )

  )



(define (orchid color1% color2%)
  (overlay/offset
   (flower color1% color2%)
   0 20
   (overlay/offset
    (add-curve empty-image 0 0 0 0 0 -100 225 -1 "brown")
    5 0
    (add-curve empty-image 0 0 0 0 0 -100 225 -1 "brown")
    )
   )
  )

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


(define (setScene x y image%)
  (if (< y 300)
      (place-image 
       (orchid (rnd-color) (rnd-color))
       (- x 133) y
       image%)
      (place-image 
       (orchid (rnd-color) (rnd-color))
       ;(circle (/ x 10) "solid" "black")
       (- x 133) y
       (setScene  (- x 30) (- y 40) image%))))

(define (setScene2 x y image%)
  (if (< y 300)
      (place-image 
       (orchid (rnd-color) (rnd-color))
       (+ x 133) y
       image%)
      (place-image 
       (orchid (rnd-color) (rnd-color))
       ;(circle (/ x 10) "solid" "black")
       (+ x 133) y
       (setScene2  (+ x 30) (- y 40) image%))))

(define (setScene3 x y image%)
  (if (>= x 800)
      (place-image (atom 10)
                   x y
                   image%)
      (place-image (atom 10)
                   x y
                   (setScene3 (+ x (/ x 2)) y image%))))

(define (setScene4 x y image%)
  (if (<= x 0)
      (place-image (atom 10)
                   0 y
                   image%)
      (place-image (atom 10)
                   x y
                   (setScene4 (round (- x (* x .5))) y image%))))


(define (setScene5 r x image%)
  (if (>= x 255)
      (place-image (circle r "solid" (make-color 255 0 0 20))
                   400 300
                   image%)
      (place-image (circle r "solid" (make-color x 0 0 20))
                   400 300
                   (setScene5 (+ r 40) (+ x 25) image%))))

(save-image

 (overlay
(overlay
(overlay
 (overlay
(overlay
 (overlay
 (overlay
 (place-image (wormhole 10) 800 300 
 (place-image (wormhole 10) 0 300
(place-image (atomic_flower 10) 400 300 
(dragon-recur 20000 200 150
              (setScene5 10 50
                         (setScene4 800 500
                                    (setScene3 2 50
                                               (setScene2 0 500
                                                          (setScene 800 500
                                                                    (rectangle 800 600 "solid"
                                                                                       (make-color 0 0 255 100)))))))
              0)
)))
 (rectangle 800 100 "solid" "SteelBlue"))
 (rectangle 800 200 "solid" "DarkTurquoise"))
 (rectangle 200 600 "solid" "dark red"))
 (rectangle 400 600 "solid" "red"))
 (rectangle 600 600 "solid" "light red"))
 (rectangle 600 600 "solid" "Maroon"))
 (rectangle 800 600 "solid" "Firebrick"))

"465_art.png" 800 600)
