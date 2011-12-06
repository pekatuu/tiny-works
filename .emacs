;===================================
; font
;===================================
(cond ( (string-match "^23\." emacs-version)
 (cond (window-system
;	 (set-default-font "Yutapon coding Bold-10")
;	 (set-default-font "Liberation Mono-9:bold")
;	 (set-default-font "Inconsolata-10")
;	 (set-default-font "M+1VM+IPAG circle-9")
;	 (set-default-font "Consolas-9.8")
;	(set-default-font "DejaVu Sans Mono-9:bold")
	(set-default-font "DejaVu Sans Mono-9:bold")
;	 (set-default-font "DejaVu Sans Mono-10")
    (set-fontset-font (frame-parameter nil 'font)
      'japanese-jisx0208
;      (font-spec :family "meiryo" :size 16))
;      (font-spec :family "M+1VM+IPAG circle" :size 16))
;      (font-spec :family "Osaka\-Mono" :size 16))
;     (font-spec :family "Hiragino Kaku Gothic ProN W3" :size 14))
     (font-spec :family "Hiragino Kaku Gothic ProN W6" :size 14))
;      (font-spec :family "Hiragino Kaku Gothic ProN W6" :size 14))
;      (font-spec :family "Hiragino Mincho ProN W6" :size 14))
;      (font-spec :family "Kozuka Mincho Pro\-VI" :size 14))
;      (font-spec :family "Kozuka Gothic Pro\-VI" :size 14))
;      (font-spec :family "Yutapon coding Bold" :size 16))
))))
;hogehogehogehogehoge
;ほげほげほげほげほげ
;間開関閉璧壁
;````^^^~~~~-'"```^|l1L\/][{}()&%"#mv^```````````1111LLLLlllllllll123lLiIlIlI
;ぱばぱばぱば
(setq load-path
      (append (list "~/.emacs.d"
		    "~/.emacs.d/auto-install"
		    "~/.emacs.d/emacs-skype") load-path))

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

;===================================
; フレームの設定
;===================================
(setq default-frame-alist
      (append (list 
	       '(height . 92)
	       '(width . 88)
	       '(alpha . 80)
		    )
	      default-frame-alist))
; カーソルを点滅させない
(blink-cursor-mode 0)



;===================================
; yatex
;===================================
;(setq load-path
;      (append (list "~/.yatex") load-path))

(setq auto-mode-alist
      (cons (cons "\\.tex$" 'yatex-mode) auto-mode-alist))
(autoload 'yatex-mode "yatex" "Yet Another LaTeX mode" t)

(defun YaTeX-previous-section ()
  "move to previous section"
  (interactive)
  (previous-line)
  (search-backward "section{"))


(defun YaTeX-next-section ()
  "move to next section"
  (interactive)
  (next-line)
  (search-forward "section{"))

(add-hook 'yatex-mode-hook
	  (lambda ()
	    (define-key YaTeX-mode-map (kbd "\C-c\C-v") 'YaTeX-section-overview)
	    (define-key YaTeX-mode-map (kbd "\C-c\C-p") 'YaTeX-previous-section)
	    (define-key YaTeX-mode-map (kbd "\C-c\C-n") 'YaTeX-next-section)
	    (define-key YaTeX-mode-map (kbd "\C-t") 'delete-backward-char)))



;TeX typeset
(setq tex-command "platex")

;dvi preview
(setq dvi2-command "xdvi -geometry 1024x750+0+0 -s 0 -paper a4r")

;;;   1=Shift JIS
;;;   2=JIS
;;;   3=EUC
(setq YaTeX-kanji-code 3)

; add dvipdfmx
(setq dviprint-command-format "dvipdfmx -l %s ")

;===================================
; migemo
;===================================
(load "migemo")

;===================================
; desktop-read
;===================================
;(desktop-load-default)
;(desktop-read)

;====================================
; Misc
;====================================
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

;;;行のハイライト
(defface hlline-face
  '((((class color)
      (background dark))
     (:background "gray15"))
    (((class color)
      (background light))
     (:background "gray15"))
    (t
     ()))
  "*Face used by hl-line.")

(defface hlline-face-japanese
  '((((class color)
      (background dark))
     (:background "dark blue"))
    (((class color)
      (background light))
     (:background "dark blue"))
    (t
     ()))
  "*Face used by hl-line in japanese ime.")

(setq hl-line-face 'hlline-face)
;(setq hl-line-face 'underline) ; 下線
(global-hl-line-mode 1)


;;;対応する括弧の強調
(show-paren-mode t)

;;;使用ブラウザの変更
;;; set browser
(defun browse-url-chrome (url &optional new-window)
  (interactive (browse-url-interactive-arg "URL: "))
;  (start-process "google-chrome" nil "google-chrome"
  (start-process "firefox" nil "firefox"
                 url))
(setq browse-url-browser-function 'browse-url-chrome)

;===================================
; dabbrev-expand-multiple
;===================================
(require 'dabbrev-expand-multiple)
(global-set-key "\M-/" 'dabbrev-expand-multiple)
(setq dabbrev-expand-multiple-use-tooltip nil)

;===================================
; 日本語
;===================================
;(set-language-environment "Japanese")
;(set-default-coding-systems 'euc-jp-unix)
;(set-terminal-coding-system 'euc-jp-unix)
;(set-keyboard-coding-system 'euc-jp-unix)
;(set-buffer-file-coding-system 'euc-jp-unix)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)

;=================================
; iBus
;=================================
(if (window-system)
    (progn
      (require 'ibus)                             
      (add-hook 'after-init-hook 'ibus-mode-on)
      (global-set-key "\C-\\" 'ibus-toggle)
      (setq ibus-cursor-color '("green" "white" "limegreen"))
      (setq ibus-use-in-isearch-window nil)
      ))

(defun ibus-toggle ()
  "Toggle IBus' input status."
  (interactive)
  (when (and (interactive-p)
	     (null ibus-current-buffer))
    (ibus-check-current-buffer))
  (if ibus-imcontext-status
      (progn
	(ibus-disable)
	(setq hl-line-face 'hlline-face)
	)
    (progn
      (ibus-enable)
      (setq hl-line-face 'hlline-face-japanese)
      ))
  )


;===================================
; Anthy 
;===================================

;;;入力モードに応じて色を変える
(defun anthy-adjust-cursor-color ()
  (if anthy-minor-mode
      (progn
	(set-cursor-color "green")
	(setq hl-line-face 'hlline-face-japanese))
    (progn
      (set-cursor-color "white")
      (setq hl-line-face 'hlline-face))
    ))

(if (not (window-system))
    (progn
      (set-input-method "japanese-anthy")
      (if ( >= emacs-major-version 23)
	  (setq anthy-accept-timeout 1))
      
      (setq anthy-wide-space " ")
      (anthy-change-hiragana-map "xn" "ん")
      (anthy-change-hiragana-map "." "．")
      (anthy-change-hiragana-map "," "，")
      (anthy-change-hiragana-map "*" "*")
      (anthy-change-hiragana-map "[" "[")
      (anthy-change-hiragana-map "]" "]")
      (anthy-change-hiragana-map "->" "→")
      (anthy-change-hiragana-map "<-" "←")


      (mapcar
       (lambda (f)
	 (eval
	  `(defadvice ,f (after adjust-cursor-color activate)
	     (anthy-adjust-cursor-color))))
       '(anthy-update-mode-line
	 anthy-mode-off
	 bury-buffer
	 kill-buffer
	 other-window
	 pop-to-buffer
	 switch-to-buffer
	 windmove-up
	 windmove-right
	 windmove-down
	 windmove-left))))

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
(org-remember-insinuate)
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
(define-key org-mode-map "\M-n" 'org-next-visible-link)
(define-key org-mode-map "\M-p" 'org-previous-visible-link)

;===================================
; print-buffer
;===================================
(setq ps-multibyte-buffer 'non-latein-printer)
(require 'ps-mule)
(defalias 'ps-mule-header-string-charsets 'ignore)
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(org-agenda-files (quote ("~/memo/agenda.org"))))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )


;=================================
; auto complete
;=================================
(require 'auto-complete)

;=================================
; pull down
;=================================
(require 'pulldown)
(require 'popup)

;=================================
; switch-to-buffer-popup
;=================================
(defun switch-to-buffer-popup ()
  (interactive)
  (let ((inhibit-read-only t)
	(buf-list (buffer-list))
	(rslt-list nil))
    (while buf-list
      (unless (string-match "^ " (buffer-name (car buf-list)))
	(setq rslt-list (cons (car buf-list) rslt-list)))
      (setq buf-list (cdr buf-list)))
    (switch-to-buffer
     (popup-menu (cdr (reverse rslt-list)) :scroll-bar t :margin t))))

;(global-set-key "\C-xb" 'switch-to-buffer-popup)

;=================================
; auto-install.el
;=================================
(require 'auto-install)
(setq auto-install-directory "~/.emacs.d/auto-install/")
(auto-install-update-emacswiki-package-name t)
(auto-install-compatibility-setup)

;=================================
; anything.el
;=================================
(require 'anything)
(require 'anything-startup)
(global-set-key "\C-x\M-f" 'anything-filelist+)

;=================================
; 4 clojure
;=================================


;;; This was installed by package-install.el.
;;; This provides support for the package system and
;;; interfacing with ELPA, the package archive.
;;; Move this code earlier if you want to reference
;;; packages in your .emacs.

(when
    (load
     (expand-file-name "~/.emacs.d/elpa/package.el"))
  (package-initialize))

;=================================
; shell-pop
;=================================
(require 'shell-pop)
(shell-pop-set-internal-mode "ansi-term")
(shell-pop-set-internal-mode-shell "/usr/bin/zsh")
(shell-pop-set-window-height 50)

(defvar ansi-term-after-hook nil)
(add-hook 'ansi-term-after-hook
          (lambda ()
            ;; これがないと M-x できなかったり
            (define-key term-raw-map (kbd "M-x") 'nil)
            ;; コピー, 貼り付け
            (define-key term-raw-map (kbd "C-k")
              (lambda (&optional arg) (interactive "P") (funcall 'kill-line arg) (term-send-raw)))
            (define-key term-raw-map (kbd "C-y") 'term-paste)
            (define-key term-raw-map (kbd "M-y") 'anything-show-kill-ring)
            ;; Tango!
            (setq ansi-term-color-vector
                  [unspecified
                   "#000000"           ; black
                   "#ff3c3c"           ; red
                   "#84dd27"           ; green
                   "#eab93d"           ; yellow
                   "#135ecc"           ; blue
                   "#f47006"           ; magenta
                   "#89b6e2"           ; cyan
                   "#ffffff"]          ; white
                  )
            ))

(defadvice ansi-term (after ansi-term-after-advice (arg))
  "run hook as after advice"
  (run-hooks 'ansi-term-after-hook))
(ad-activate 'ansi-term)

(global-set-key [M-zenkaku-hankaku] 'shell-pop)

;=================================
; Gauche
;=================================
(setq scheme-program-name "gosh")
(require 'cmuscheme)

(defun scheme-other-window ()
  "Run scheme on other window"
  (interactive)
  (switch-to-buffer-other-window
   (get-buffer-create "*scheme*"))
  (run-scheme scheme-program-name))

(define-key global-map
  "\C-cS" 'scheme-other-window)

;=================================
; auto-complete
;=================================
;(require 'auto-complete)
;(global-auto-complete-mode nil)

;=================================
; python
;=================================
;(require 'pysmell)
;(defvar ac-source-pysmell
;	  '((candidates
;	     . (lambda ()
;	         (require 'pysmell)
;	         (pysmell-get-all-completions))))
;	  "Source for PySmell")
;
;(define-key ac-complete-mode-map "\C-n" 'ac-next)
;(define-key ac-complete-mode-map "\C-p" 'ac-previous)
; 
;(add-hook 'python-mode-hook
;          '(lambda ()
;             (set (make-local-variable 'ac-sources) 
;		  (append ac-sources '(ac-source-pysmell)))))
;
;(require 'pymacs)
;(autoload 'pymacs-apply "pymacs")
;(autoload 'pymacs-call "pymacs")
;(autoload 'pymacs-eval "pymacs" nil t)
;(autoload 'pymacs-exec "pymacs" nil t)
;(autoload 'pymacs-load "pymacs" nil t)

;=================================
; skype
;=================================
(require 'skype)
(setq skype--my-user-handle "hoge")

;---------------------------------
; popwin
;---------------------------------
(require 'popwin)
(setq display-buffer-function 'popwin:display-buffer)
(setq popwin:special-display-config
      '(("*YaTeX-typesetting*" :noselect t)
	("*dvi-printing*" :noselect t)
	("*dvi-preview*" :noselect t)
	("*Remember*")
	("*Backtrace*" :noselect t)
	("*Buffer List*" :height 30)
	("^\*twittering" :regexp t)
	("^\*anything" :regexp t :height 30)
	("^\*magit:" :regexp t)))

;=================================
; toggle-fullscreen
;=================================
(defun toggle-fullscreen (&optional f)
  (interactive)
  (let ((current-value (frame-parameter nil 'fullscreen)))
    (set-frame-parameter nil 'fullscreen
			 (if (equal 'fullboth current-value)
			     (if (boundp 'old-fullscreen) old-fullscreen nil)
			   (progn (setq old-fullscreen current-value)
				  'fullboth)))))
(global-set-key [f11] 'toggle-fullscreen)