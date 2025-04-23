{
	enviroment.systemPackages = with pkgs; [
		neovim    # TEXT EDITOR, GET NIGHTLY VERSION
		wget      # HTTP
		curl      # HTTP
		git       # REPO VERSION MANAGER
		gh        # GIT VERSION MANAGER
		firefox   # WEB BROWSER
		htop      # PROCESS MANAGER
		# psql    # DATABASE SQL
		mysql     # DATABASE SQL
		# mongodb # DATABASE NOSQL
		fzf       # FUZY FINDER
		unzip     # COMPRESSOR & DECOMPRESSOR
		xclip     # YANKER
		# python  # PYTHON DEVELOPMENT
		# pip     # PYTHON PACKAGE MANAGER
		# go      # GO DEVELOPMENT
		gcc       # C DEVELOPMENT
		# DOCKER ZSHELL POWERLEVEL10K OH-MY-SHELL JAVA JAVAC MAKE JDK MAVEN LATEXMK LATEX-LIBS-ALL ...
	];
}
