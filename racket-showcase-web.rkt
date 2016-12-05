#lang web-server/insta

(require web-server/servlet
         web-server/servlet-env)

(static-files-path "stylesheets")

(define (start req)
  (response/xexpr
   '(html (head
           (link ((rel "stylesheet")
                  (href "/style.css")
                  (type "text/css")
                  ))
           (title "Racket Heroku App"))
          (body (h1 "It works! lol")))))

(define port (if (getenv "PORT")
                 (string->number (getenv "PORT"))
                 8080))
(serve/servlet start
               #:servlet-path "/"
               #:listen-ip #f
               #:port port
               #:command-line? #t)
