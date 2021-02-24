; Copyright 2020
; Nathan Callahan

#lang scheme
(require "defs.rkt" 2htdp/image)

(beside (wormhole "blue") (orbit 5) (atom 100) (atomic_flower "red") )

(overlay/offset
 (ellipse 5 10 "solid" (make-color 100 200 30))
 0 -10
 (overlay
  (overlay/offset
   (petal "red")
   20 0
   (rotate 180 (petal "red")))
  (ellipse 30 60 "solid" "green")))
