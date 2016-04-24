; set load path
;(setq load-path
;      (append (list 
;	       "~/.emacs.d/lisp") load-path)) 

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
;(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

;===================================
; エンコード
;===================================
; shell を UTF に
(add-hook 'shell-mode-hook
	  (lambda () (set-buffer-process-coding-system 'utf-8-unix
						       'utf-8-unix)))

; dired を UTFに
;(add-hook 'dired-load-hook
;	  (lambda () 
;	    (set-buffer-process-coding-system 'utf-8-unix)
;))
(add-hook 'dired-before-readin-hook
	  (lambda ()
	    (set (make-local-variable 'coding-system-for-read) 'utf-8)))

;====================================
; Misc
;====================================
(global-set-key (kbd "C-M-o") 'imenu)
;;;C-h BS
(global-set-key "\C-h" 'delete-backward-char)
;;;M-h BS-word いくつかコマンドが犠牲
(global-set-key "\M-h" 'backward-kill-word)
;;;C-x h:help
(global-set-key "\C-xh" 'help-command)
;;;ウインドウの移動をShift+矢印で行う
(windmove-default-keybindings)
;;;wrapを有効に
(setq windmove-wrap-around t)
(global-set-key "\M-o" 'windmove-right)
(global-set-key "\M-i" 'windmove-down)
(global-set-key "\M-u" 'windmove-left)
;;;インクリメンタルサーチでのdelete-charをC-hに
;(defun-key ekb-isearch-mode-map "\C-b" 'isearch-delete-char) ;ならへん！
;;文字の色つけ
(global-font-lock-mode t)
;;時計を表示
(display-time)             
(setq display-time-format "%m-%d (%a) %H:%M")
;;カーソルのある行番号を表示
(setq line-number-mode t)  
;;日本語infoの文字化け防止
(auto-compression-mode t)  
;;フレームのタイトル指定
(setq frame-title-format   
      (concat "%b - emacs@" system-name))
;;; ツールバーを消す
(tool-bar-mode 0)
;;; メニューバーを消す
(menu-bar-mode 0)
;;;スクロールバーを消す
(menu-bar-no-scroll-bar)
;;;リージョンのハイライトを無効に
(transient-mark-mode 0)

;;;対応する括弧の強調
(show-paren-mode t)

;===================================
; 日本語
;===================================
(set-language-environment "Japanese")
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)

;===================================
; org
;===================================
;;; add WIP to TODO keywords
(setq org-todo-keywords '("TODO" "WIP" "IDLE" "STICKY""DONE")
      org-todo-interpretation 'sequence)
; change color 
(setq org-todo-keyword-faces
      '(
        ("WIP" . (:foreground "cyan"))
        ("IDLE" . (:foreground "yellow"))
        ("STICKY" . (:foreground "gray"))
        ))

;;; set keybind
(global-set-key "\M-r" 'org-remember)
(defun org-remember-open-memo ()
  (interactive)
  (find-file "~/memo/agenda.org")
)
(global-set-key "\M-a" 'org-remember-open-memo)
;(require 'org-install)
(setq org-startup-truncated nil)
(setq org-return-follows-link t)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(setq org-directory "~/memo/")
(setq org-default-notes-file (concat org-directory "agenda.org"))
(setq org-remember-templates
      '(("Todo" ?t "** TODO %?\n   %i\n   %a\n   %t" nil "Inbox")
        ("Bug" ?b "** TODO %?   :bug:\n   %i\n   %a\n   %t" nil "Inbox")
;        ("Idea" ?i "** %?\n   %i\n   %a\n   %t" nil "New Ideas")
        ("Memo" ?m "** %?\n   %i\n   %a\n   %t" nil "Memo")
        ("Dialy" ?d "** %t [/]\n- [ ]%?\n*** 記録" nil "Dialy")
        ))

; Dialy-remember-code-reading
(defvar org-code-reading-software-name nil)
;; ~/memo/code-reading.org に記録する
(defvar org-code-reading-file "code-reading.org")
(defun org-code-reading-read-software-name ()
  (set (make-local-variable 'org-code-reading-software-name)
       (read-string "Code Reading Software: " 
                    (or org-code-reading-software-name
                        (file-name-nondirectory
                         (buffer-file-name))))))

(defun org-code-reading-get-prefix (lang)
  (concat "[" lang "]"
          "[" (org-code-reading-read-software-name) "]"))
(defun org-remember-code-reading ()
  (interactive)
  (let* ((prefix (org-code-reading-get-prefix (substring (symbol-name major-mode) 0 -5)))
         (org-remember-templates
          `(("CodeReading" ?r "** %(identity prefix)%?\n   \n   %a\n   %t"
             ,org-code-reading-file "Memo"))))
    (org-remember)))
(defun org-next-visible-link ()
  "Move forward to the next link.
If the link is in hidden text, expose it."
  (interactive)
  (when (and org-link-search-failed (eq this-command last-command))
    (goto-char (point-min))
    (message "Link search wrapped back to beginning of buffer"))
  (setq org-link-search-failed nil)
  (let* ((pos (point))
	 (ct (org-context))
	 (a (assoc :link ct))
         srch)
    (if a (goto-char (nth 2 a)))
    (while (and (setq srch (re-search-forward org-any-link-re nil t))
                (goto-char (match-beginning 0))
                (prog1 (not (eq (org-invisible-p) 'org-link))
                  (goto-char (match-end 0)))))
    (if srch
        (goto-char (match-beginning 0))
      (goto-char pos)
      (setq org-link-search-failed t)
      (error "No further link found"))))

(defun org-previous-visible-link ()
  "Move backward to the previous link.
If the link is in hidden text, expose it."
  (interactive)
  (when (and org-link-search-failed (eq this-command last-command))
    (goto-char (point-max))
    (message "Link search wrapped back to end of buffer"))
  (setq org-link-search-failed nil)
  (let* ((pos (point))
	 (ct (org-context))
	 (a (assoc :link ct))
         srch)
    (if a (goto-char (nth 1 a)))
    (while (and (setq srch (re-search-backward org-any-link-re nil t))
                (goto-char (match-beginning 0))
                (not (eq (org-invisible-p) 'org-link))))
    (if srch
        (goto-char (match-beginning 0))
      (goto-char pos)
      (setq org-link-search-failed t)
      (error "No further link found"))))

;=================================
; helm
;=================================
(require 'helm)
(require 'helm-gtags)

;;; bindings
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x b") 'helm-for-files)

;;; hooks
(add-hook 'c-mode-hook 'helm-gtags-mode)
(add-hook 'helm-gtags-mode-hook
          '(lambda ()
              (local-set-key (kbd "M-.") 'helm-gtags-find-tag-from-here)
              (local-set-key (kbd "M-,") 'helm-gtags-find-rtag)
              (local-set-key (kbd "M-s s") 'helm-gtags-find-symbol)
              (local-set-key (kbd "M-*") 'helm-gtags-pop-stack)))

;=================================
; ruby
;=================================
(require 'align)
(add-to-list 'align-rules-list
             '(ruby-comma-delimiter
               (regexp . ",\\(\\s-*\\)[^# \t\n]")
               (repeat . t)
               (modes  . '(ruby-mode))))
(add-to-list 'align-rules-list
             '(ruby-hash-literal
               (regexp . "\\(\\s-*\\)=>\\s-*[^# \t\n]")
               (repeat . t)
               (modes  . '(ruby-mode))))

;=================================
; jaunte
;=================================
(require 'jaunte)
(global-set-key (kbd "C-c C-j") 'jaunte)
(global-set-key (kbd "C-c j") 'jaunte)

;=================================
; web-mode
;=================================
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))

;=================================
; auto-complete
;=================================
(require 'auto-complete-config)
(ac-config-default)
