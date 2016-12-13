#lang web-server/insta

(require web-server/servlet
         web-server/servlet-env)

(define words "Hello world!")

(static-files-path (build-path (current-directory) "stylesheets"))

(define (start req)
  (response/xexpr
   `(html (head
           (style "html {background-color: cyan;}"
                  "p {color: red;}")
           (title "Racket Heroku App"))
          (body (h1 "It works! lol")
                (p ,words)
                ))))

(define port (if (getenv "PORT")
                 (string->number (getenv "PORT"))
                 8080))
(serve/servlet start
               #:servlet-path "/"
               #:listen-ip #f
               #:port port
               #:command-line? #t)
