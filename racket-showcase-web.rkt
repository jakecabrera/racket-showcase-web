#lang racket

(require web-server/servlet
         web-server/servlet-env)

(define words "Hello world!")

(define (more-words) "howdy!")

(define place (path->string (current-directory)))

(define (stuff lst)
  (let ((lst1 (map path->string lst)))
    (if (empty? lst) ""
        (string-append (first lst1) "       " (stuff (rest lst))))))

(define (start req)
  (response/xexpr
   `(html (head
           (link ((rel "stylesheet")
                  (href "/style.css")
                  (type "text/css")))
           (script ((src "https://code.jquery.com/jquery-3.1.1.min.js")))
           (script ((src "https://code.jquery.com/ui/1.12.1/jquery-ui.min.js")))
           (script ((type "text/javascript")
                    (src "/app.js")))
           (title "Racket Heroku App"))
          (body (h1 "It works! lol")
                (p ,(more-words))
                (p ,(path->string (current-directory)))
                (p ,place)
                (p ,(stuff (directory-list place)))
                ))))

(define port (if (getenv "PORT")
                 (string->number (getenv "PORT"))
                 8080))

(serve/servlet start
               #:servlet-path "/"
               #:listen-ip #f
               #:extra-files-paths (list (string->path (string-append (path->string (current-directory)) "StaticFiles")))
               #:port port
               #:command-line? #f)
