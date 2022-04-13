;; -*- coding: utf-8; lexical-binding: t; -*-

(use-package treemacs :commands (treemacs)
  :config
  (progn
    (setq treemacs-collapse-dirs                   (if treemacs-python-executable 3 0)
          treemacs-deferred-git-apply-delay        0.5
          treemacs-directory-name-transformer      #'identity
          treemacs-display-in-side-window          t
          treemacs-eldoc-display                   'simple
          treemacs-file-event-delay                5000
          treemacs-file-extension-regex            treemacs-last-period-regex-value
          treemacs-file-follow-delay               0.2
          treemacs-file-name-transformer           #'identity
          treemacs-follow-after-init               t
          treemacs-expand-after-init               t
          treemacs-find-workspace-method           'find-for-file-or-pick-first
          treemacs-git-command-pipe                ""
          treemacs-goto-tag-strategy               'refetch-index
          treemacs-indentation                     2
          treemacs-indentation-string              " "
          treemacs-is-never-other-window           nil
          treemacs-max-git-entries                 5000
          treemacs-missing-project-action          'ask
          treemacs-move-forward-on-expand          nil
          treemacs-no-png-images                   nil
          treemacs-no-delete-other-windows         t
          treemacs-project-follow-cleanup          nil
          ;; treemacs-persist-file                    (expand-file-name ".cache/treemacs-persist" user-emacs-directory)
          treemacs-position                        'left
          treemacs-read-string-input               'from-child-frame
          treemacs-recenter-distance               0.1
          treemacs-recenter-after-file-follow      nil
          treemacs-recenter-after-tag-follow       nil
          treemacs-recenter-after-project-jump     'always
          treemacs-recenter-after-project-expand   'on-distance
          treemacs-litter-directories              '("/node_modules" "/.venv" "/.cask")
          treemacs-show-cursor                     nil
          treemacs-show-hidden-files               t
          treemacs-silent-filewatch                nil
          treemacs-silent-refresh                  nil
          treemacs-sorting                         'alphabetic-asc
          treemacs-select-when-already-in-treemacs 'move-back
          treemacs-space-between-root-nodes        t
          treemacs-tag-follow-cleanup              t
          treemacs-tag-follow-delay                1.5
          treemacs-text-scale                      nil
          treemacs-user-mode-line-format           nil
          treemacs-user-header-line-format         nil
          treemacs-wide-toggle-width               70
          treemacs-width                           35
          treemacs-width-increment                 1
          treemacs-width-is-initially-locked       t
          treemacs-workspace-switch-cleanup        nil)

    ;; The default width and height of the icons is 22 pixels. If you are
    ;; using a Hi-DPI display, uncomment this to double the icon size.
    ;;(treemacs-resize-icons 44)

    (treemacs-follow-mode t)
    (treemacs-filewatch-mode t)
    (treemacs-fringe-indicator-mode 'always)

    (pcase (cons (not (null (executable-find "git")))
                 (not (null treemacs-python-executable)))
      (`(t . t)
       (treemacs-git-mode 'deferred))
      (`(t . _)
       (treemacs-git-mode 'simple)))

    (treemacs-hide-gitignored-files-mode nil)

	(let ((face-spec 'doom-themes-treemacs-file-face))
	  (treemacs-create-theme "my/doom-atom"
							 :config
							 (progn
							   (treemacs-create-icon
								:icon (format " %s\t" (all-the-icons-octicon "repo" :height 1.2 :v-adjust -0.1 :face 'doom-themes-treemacs-root-face))
								:extensions (root-open))
							   (treemacs-create-icon
								:icon (format " %s\t" (all-the-icons-octicon "repo" :height 1.2 :v-adjust -0.1 :face 'doom-themes-treemacs-root-face))
								:extensions (root-closed))
							   (treemacs-create-icon
								:icon (format "%s\t%s\t"
											  (all-the-icons-octicon "chevron-down" :height 0.95 :v-adjust 0.1 :face face-spec)
											  (all-the-icons-octicon "file-directory" :v-adjust 0 :face face-spec))
								:extensions (dir-open))
							   (treemacs-create-icon
								:icon (format "%s\t%s\t"
											  (all-the-icons-octicon "chevron-right" :height 0.95 :v-adjust 0.1 :face face-spec)
											  (all-the-icons-octicon "file-directory" :v-adjust 0 :face face-spec))
								:extensions (dir-closed))
							   (treemacs-create-icon
								:icon (format "%s\t%s\t"
											  (all-the-icons-octicon "chevron-down" :height 0.95 :v-adjust 0.1 :face face-spec)
											  (all-the-icons-octicon "package" :v-adjust 0 :face face-spec)) :extensions (tag-open))
							   (treemacs-create-icon
								:icon (format "%s\t%s\t"
											  (all-the-icons-octicon "chevron-right" :height 0.95 :v-adjust 0.1 :face face-spec)
											  (all-the-icons-octicon "package" :v-adjust 0 :face face-spec))
								:extensions (tag-closed))
							   (treemacs-create-icon
								:icon (format "%s\t" (all-the-icons-octicon "tag" :height 0.9 :v-adjust 0 :face face-spec))
								:extensions (tag-leaf))
							   (treemacs-create-icon
								:icon (format "%s\t" (all-the-icons-octicon "flame" :v-adjust 0 :face face-spec))
								:extensions (error))
							   (treemacs-create-icon
								:icon (format "%s\t" (all-the-icons-octicon "stop" :v-adjust 0 :face face-spec))
								:extensions (warning))
							   (treemacs-create-icon
								:icon (format "%s\t" (all-the-icons-octicon "info" :height 0.95 :v-adjust 0.1 :face face-spec))
								:extensions (info))
							   (treemacs-create-icon
								:icon (format "  %s\t" (all-the-icons-octicon "file-media" :v-adjust 0 :face face-spec))
								:extensions ("ai" "aiff" "avi" "bmp" "eps" "flac" "gif" "ico" "indd"
											 "jpeg" "jpg" "midi" "mkv" "mov" "mp3" "mp4" "ogg" "png"
											 "psd" "svg" "tif" "tiff" "wav" "webm" "webp"))
							   (treemacs-create-icon
								:icon (format "  %s\t" (all-the-icons-octicon "file-code" :v-adjust 0 :face face-spec))
								:extensions ("accdb" "accdt" "actionscript" "adoc" "adoc" "ansible"
											 "antlr" "applescript" "asciidoc" "asm" "c" "cask" "cc"
											 "cc" "clj" "cljc" "cljs" "cmake" "coffee" "cpp" "css"
											 "cxx" "cython" "d" "dart" "diet" "diff" "dml"
											 "docker-compose.yml" "dockerfile" "dscript" "edn" "eex"
											 "el" "elm" "ex" "exs" "fennel" "fish" "fortran"
											 "fortran-modern" "fortranfreeform" "fsharp" "gdscript"
											 "go" "gradle" "graphql" "h" "hh" "hpp" "hs" "htm" "html"
											 "hy" "iced" "inc" "ino" "j2" "j2" "java" "jinja" "jinja2"
											 "jl" "js" "jsx" "kt" "kts" "ledger" "less" "lhs" "lisp"
											 "lua" "makefile" "matlab" "merlin" "mips" "ml" "mli"
											 "moonscript" "nim" "nims" "nix" "objectpascal" "ocaml"
											 "pascal" "patch" "pde" "perl" "pgsql" "php" "php4" "php5"
											 "phps" "pl" "plt" "pm" "pm6" "pony" "pp" "pp" "pro"
											 "prolog" "ps1" "purs" "py" "pyc" "r" "racket" "rb" "rd"
											 "rdx" "re" "rei" "rkt" "rktd" "rktl" "rs" "rsx" "sass"
											 "sbt" "scala" "scm" "scpt" "scrbl" "scribble" "scss" "sh"
											 "sql" "styles" "sv" "tex" "tpp" "ts" "tsx" "v"
											 "vagrantfile" "vh" "vhd" "vhdl" "vhms" "vim" "vue" "xsl"
											 "zsh" "zshrc"))
							   (treemacs-create-icon
								:icon (format "  %s\t" (all-the-icons-octicon "book" :v-adjust 0 :face face-spec))
								:extensions ("azw" "azw3" "cb7" "cba" "cbr" "cbt" "cbz" "ceb" "chm"
											 "djvu" "doc" "docx" "exe" "fb2" "inf" "kf8" "kfx" "lit"
											 "lrf" "lrx" "mobi" "opf" "or" "oxps" "pdb" "pdb" "pdb"
											 "pdg" "pkg" "prc" "ps" "rtf" "tr2" "tr3" "txt" "xeb" "xps"
											 "pot" "potx" "potm" "pps" "ppsx" "ppsm" "ppt" "pptx"
											 "pptm" "pa" "ppa" "ppam" "sldm" "sldx" ))
							   (treemacs-create-icon
								:icon (format "  %s\t" (all-the-icons-faicon "cogs" :height 0.95 :v-adjust 0 :face face-spec))
								:extensions ("Vagrantfile" "babel.config.js" "babelignore" "babelrc"
											 "babelrc.js" "babelrc.json" "bashrc" "bazel" "bazelrc"
											 "bower.json" "bowerrc" "cabal" "cfg" "conf" "config"
											 "cson" "csv" "editorconfig" "envrc" "eslintignore"
											 "eslintrc" "feature" "gemfile" "git" "gitattributes"
											 "gitconfig" "gitignore" "gitmodules" "ideavimrc" "iml"
											 "ini" "inputrc" "json" "ledgerrc" "lock" "nginx"
											 "npm-shrinkwrap.json" "npmignore" "npmrc"
											 "package-lock.json" "package.json" "phpunit" "pkg" "plist"
											 "properties" "terminalrc" "toml" "tridactylrc"
											 "vimperatorrc" "vimrc" "vrapperrc" "xdefaults" "xml"
											 "xresources" "yaml" "yarn-integrity" "yarnclean"
											 "yarnignore" "yarnrc" "yml"))
							   (treemacs-create-icon
								:icon (format "  %s\t" (all-the-icons-octicon "file-text" :v-adjust 0 :face face-spec))
								:extensions ("md" "markdown" "rst" "org" "log" "txt" "contribute"
											 "license" "readme" "changelog"))
							   (treemacs-create-icon
								:icon (format "  %s\t" (all-the-icons-octicon "file-binary" :v-adjust 0 :face face-spec))
								:extensions ("exe" "dll" "obj" "so" "o" "out" "elc" "cmake-cache" "csr"
											 "eslintcache" "crt" "cer" "der" "pfx" "p12" "p7b" "p7r"
											 "DS_STORE" "key" "pem" "src" "crl" "sst" "stl" "ipynb"))
							   (treemacs-create-icon
								:icon (format "  %s\t" (all-the-icons-octicon "file-pdf" :v-adjust 0 :face face-spec))
								:extensions ("pdf"))
							   (treemacs-create-icon
								:icon (format "  %s\t" (all-the-icons-octicon "file-zip" :v-adjust 0 :face face-spec))
								:extensions ("zip" "xz" "7z" "tar" "gz" "rar" "tgz" "jar"))
							   (treemacs-create-icon
								:icon (format "  %s\t" (all-the-icons-octicon "file-text" :v-adjust 0 :face face-spec))
								:extensions (fallback)))))

	(setq doom-themes-treemacs-theme "my/doom-atom")
	(treemacs-load-theme "my/doom-atom")
	))

(use-package treemacs-evil
  :after (treemacs evil))
