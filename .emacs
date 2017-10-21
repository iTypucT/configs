(defalias 'yes-or-no-p 'y-or-n-p)

(setq package-archives '(
			 ("elpy" . "http://jorgenschaefer.github.io/packages/")
			 ("gnu" . "http://elpa.gnu.org/packages/")
			 ;; ("melpa" . "http://melpa.milkbox.net/packages/")
			 ("melpa-stable" . "http://melpa-stable.milkbox.net/packages/")
			 ("org" . "http://orgmode.org/elpa/")
			                          ))


;; autopair
(add-to-list 'load-path "~/.emacs.d/elpa/autopair-0.6.1")
(require 'autopair)
(autopair-global-mode)

;; neotree
(add-to-list 'load-path "~/.emacs.d/elpa/neotree-0.5.2")
(require 'neotree)
(global-set-key [f8] 'neotree-toggle)




;;; Package --- Summary
;;; Commentary:
;;; Settings for Python

;;; Code:

;;; Импорт необходимых модулей
(add-to-list 'load-path "~/.emacs.d/elpa/py-autopep8-2016.1")
(require 'py-autopep8)
(add-to-list 'load-path "~/.emacs.d/elpa/py-isort-2016.1")
(require 'py-isort)
;(add-to-list 'load-path "~/.emacs.d/elpa/pip-requirements-0.5")
;(require 'pip-requirements)

;;; Псевдоним для команды pyvenv-workon, пользователи virtualenv оценят удобство
(defalias 'workon 'pyvenv-workon)

;;; Автоматически загружать модуль python-mode, писать в статус баре "Python-mode"
(autoload 'python-mode "python-mode" "Python mode." t)

;;; Применять python-mode для файлов с расширением .py
;;; Использовать интерпретатор python для python-mode
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(add-to-list 'interpreter-mode-alist '("python3" . python-mode))

;(add-to-list 'auto-mode-alist '("\\REQUIREMENTS" . pip-requirements-mode))
;(add-to-list 'auto-mode-alist '("\\REQUIREMENTS.txt" . pip-requirements-mode))
;(add-to-list 'auto-mode-alist '("\\requirements" . pip-requirements-mode))
;(add-to-list 'auto-mode-alist '("\\requirements.txt" . pip-requirements-mode))

;;; Подсвечивать строки, которые обычно используются при отладке
(defun annotate-pdb()
  (interactive)
  (highlight-lines-matching-regexp "import ipdb")
  (highlight-lines-matching-regexp "import pdb")
  (highlight-lines-matching-regexp "set_trace()")
  (highlight-phrase "TODO")
  (highlight-regexp "FIXME")
  (highlight-regexp "BUG")
  )

;;; В Python-mode автоматически включать anaconda-mode, pdb и
;;; автоматически применять autopep8 при сохранении файла
(add-hook 'python-mode-hook 'anaconda-mode)
(add-hook 'python-mode-hook 'annotate-pdb)
(add-hook 'python-mode-hook 'py-autopep8-enable-on-save)

;;; Перед сохранением так же отсортировать импортированные модули.
;;; Правило сортировки: одна строка - один модуль
(add-hook 'before-save-hook 'py-isort-before-save)
(setq py-isort-options '("-sl"))

;;; python.el ends here
