#lang racket

(require web-server/servlet
         web-server/servlet-env)

(define words "Hello world!")

(define (more-words) "howdy! Try dragging 'Hello World' around!")

(define cwd (string-append (path->string (current-directory)) (if (directory-exists? "app") "app" "")))

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
          (body (h1 ,words)
                (p ,(more-words))
                ))))

(define port (if (getenv "PORT")
                 (string->number (getenv "PORT"))
                 8080))

(serve/servlet start
               #:servlet-path "/"
               #:listen-ip #f
               #:extra-files-paths (list (string->path (string-append cwd "StaticFiles")))
               #:port port
               #:command-line? #f)
