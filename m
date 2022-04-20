Return-Path: <virtio-return-3708-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Wed, 20 Apr 2022 15:50:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20220420195001.11954-1-mst@redhat.com>
MIME-Version: 1.0
Subject: [virtio] [PATCH] editorial: switch to upstream latexdiff
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: virtio@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

With latest latexdiff, we can finally show changed lines
within listings. Worth the switch to the lastest master.
As a bonus, we no longer need to maintain a pile of perl hacks
and complex command line as it seems to generally be smarter.
Add it as a submodule so we can track which version we use.
Notes:

1. DIFCODE_UNDERLINE file helps override colors within listings
(default is blue for addition, we use green to avoid confusion with
links elsewhere so I kept this consistent for listings).
It does not seem to be documented, something to watch out for
if/when we update latexdiff, and maybe work with the latexdiff
maintainer to document.

2. I am not sure we still need the 's/\\footnote{/\\footnote {/' hack.
Kept it around just in case. If yes it might be worth discussing
with the latexdiff maintainer to address this as part of latexdiff.

3. Invoke latexdiff as latexdiff-fast which in the past made it go faster
by using the unix diff utility. I'm not sure it's still the case but
it does not seem to hurt either.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 .gitmodules       |  3 +++
 DIFCODE_UNDERLINE |  4 ++++
 diffpreamble.tex  |  4 ++++
 fixupdiff.pl      |  4 ++++
 latexdiff         |  1 +
 makediff.sh       | 10 ++++++----
 6 files changed, 22 insertions(+), 4 deletions(-)
 create mode 100644 .gitmodules
 create mode 100644 DIFCODE_UNDERLINE
 create mode 160000 latexdiff

diff --git a/.gitmodules b/.gitmodules
new file mode 100644
index 0000000..d92c470
--- /dev/null
+++ b/.gitmodules
@@ -0,0 +1,3 @@
+[submodule "latexdiff"]
+	path = latexdiff
+	url = https://github.com/ftilmann/latexdiff.git
diff --git a/DIFCODE_UNDERLINE b/DIFCODE_UNDERLINE
new file mode 100644
index 0000000..c74d1cb
--- /dev/null
+++ b/DIFCODE_UNDERLINE
@@ -0,0 +1,4 @@
+%DIF DIFCODE_UNDERLINE
+  moredelim=[il][\color{red}\sout]{\%DIF\ <\ },
+  moredelim=[il][\color{neongreen}\uwave]{\%DIF\ >\ }
+%DIF END DIFCODE_UNDERLINE
diff --git a/diffpreamble.tex b/diffpreamble.tex
index e163af5..9c105bf 100644
--- a/diffpreamble.tex
+++ b/diffpreamble.tex
@@ -3,6 +3,7 @@
 %DIF FONTSTRIKE PREAMBLE
 \RequirePackage[normalem]{ulem}
 \definecolor{darkgreen}{RGB}{00,153,00}
+\definecolor{neongreen}{RGB}{0,128,60}
 
 \providecommand{\DIFadd}[1]{\protect\textcolor{darkgreen}{\sf #1}}
 \providecommand{\DIFdel}[1]{\protect\textcolor{red}{\footnotesize \sout{#1}}}
@@ -33,4 +34,7 @@
 }
 %DIF END FLOATSAFE PREAMBLE
 
+\providecommand{\DIFmodbegin}{}
+\providecommand{\DIFmodend}{}
+
 %% diffpreable.tex end
diff --git a/fixupdiff.pl b/fixupdiff.pl
index 1c6b8e2..50ed833 100644
--- a/fixupdiff.pl
+++ b/fixupdiff.pl
@@ -1,5 +1,9 @@
 use strict;
 
+#This script was useful with latexdiff we previously used:
+#commit f0914be03e6548bbe1ed0b453c45b6f2498e46e5 https://github.com/ftilmann/latexdiff.git
+#(which is 1.1.0 + a ton of changes).
+#This script is no longer in use, will remove down the road
 my @protected_labels = (
 'devicenormative:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Interrupt Suppression',
 'devicenormative:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Notification Suppression',
diff --git a/latexdiff b/latexdiff
new file mode 160000
index 0000000..4f17f7b
--- /dev/null
+++ b/latexdiff
@@ -0,0 +1 @@
+Subproject commit 4f17f7b188fdbd8f6477aaea4118d0416babf370
diff --git a/makediff.sh b/makediff.sh
index ef538c5..190a0ec 100755
--- a/makediff.sh
+++ b/makediff.sh
@@ -51,10 +51,12 @@ sed 's/\\footnote{/\\footnote {/' new/flat.tex > new/flat-fixed.tex
 #cp new/flat.tex new/flat-fixed.tex
 #wget http://mirror.math.ku.edu/tex-archive/support/latexdiff/latexdiff-fast
 #chmod +x latexdiff-fast
-latexdiff-fast --config \
-"FLOATENV=(?:figure|longtable|table|tabular|plate|lstlisting|note|enumerate|itemize)[\w\d*@]*,PICTUREENV=(?:picture|DIFdeltextcstwo|DIFnomarkup|lstlisting)[\w\d*@]*" \
+git submodule update latexdiff
+ln -fs ./latexdiff/latexdiff ./latexdiff-fast
+./latexdiff-fast \
  --append-safecmd=field --append-textcmd=mmioreg \
+--append-textcmd=mmiodreg \
  --exclude-textcmd=chapter \
 --ignore-warnings -p diffpreamble.tex old/flat-fixed.tex \
-new/flat-fixed.tex > virtio-diff-tofix.tex
-perl fixupdiff.pl virtio-diff-tofix.tex > virtio-diff.tex
+new/flat-fixed.tex > virtio-diff.tex
+#perl fixupdiff.pl virtio-diff-tofix.tex > virtio-diff.tex
-- 
MST


---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

