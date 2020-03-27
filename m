Return-Path: virtio-comment-return-1164-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 27 Mar 2020 10:38:02 +0000
Message-Id: <20200327103803.10460-8-alex.bennee@linaro.org>
In-Reply-To: <20200327103803.10460-1-alex.bennee@linaro.org>
References: <20200327103803.10460-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Subject: [virtio-comment] [RFC PATCH  7/8] make*: remove reliance on REVISION-DATE and use git
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: virtio-dev@lists.oasis-open.org
Cc: virtio-comment@lists.oasis-open.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
List-ID: <virtio-dev.lists.oasis-open.org>

Rather than manually tweaking REVISION-DATE and loading it into
DATESTR move all the logic into make-setup-generated.sh. While we are
at it we can query git directly for the state of tree and use that to
fill in the meta-data.

Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
---
 REVISION-DATE           |  1 -
 make-setup-generated.sh | 54 +++++++++++++++++++++++++++++------------
 makeall.sh              |  1 -
 makediff.sh             |  1 -
 makediffall.sh          |  1 -
 makediffwithbase.sh     |  1 -
 maketex.sh              |  1 -
 makezip.sh              |  2 --
 8 files changed, 38 insertions(+), 24 deletions(-)
 delete mode 100644 REVISION-DATE

diff --git a/REVISION-DATE b/REVISION-DATE
deleted file mode 100644
index 59c9d17..0000000
--- a/REVISION-DATE
+++ /dev/null
@@ -1 +0,0 @@
-11 April 2019
diff --git a/make-setup-generated.sh b/make-setup-generated.sh
index f15d148..2faea0b 100755
--- a/make-setup-generated.sh
+++ b/make-setup-generated.sh
@@ -1,39 +1,61 @@
 #! /bin/sh
+#
+# Generate version and metadata preamble for the document
+#
=20
-VERSION=3D1.1
-DATESTR=3D${DATESTR:-`cat REVISION-DATE 2>/dev/null`}
-if [ x"$DATESTR" =3D x ]; then
-    ISODATE=3D`git show --format=3Dformat:'%cd' --date=3Diso | head -n 1`
-    DATESTR=3D`date -d "$DATE" +'%d %B %Y'`
+# Currently this works of the closest lightweight tag but we can
+# update this when we start using proper signed and annotated tags.
+TAG=3D$(git describe 2> /dev/null)
+if [ x"$TAG" =3D x ]; then
+    # no tag on head
+    TAG=3D$(git describe --dirty --tags)
+    # base date on now
+    DATESTR=3D$(date +'%d %B %Y')
+    COMMIT=3D$(git rev-parse --short HEAD)
+else
+    # base date on tag
+    DATESTR=3D$(git log HEAD^..HEAD --format=3Dformat:"%cd" --date=3Dforma=
t:"%d %B %Y")
+    COMMIT=3D""
+fi
+
+VERSION=3D$(cut -d'-' -f2 <<EOF
+$TAG
+EOF
+       )
+
+# Finally check if we have un-committed changes in the tree
+if git diff-index --quiet HEAD -- ; then
+    COMMIT=3D"$COMMIT with local changes"
+fi
+
+if [ x"$COMMIT" =3D x ]; then
+    WORKINGDRAFT=3D""
+else
+    WORKINGDRAFT=3D" (@ git $COMMIT)"
 fi
=20
 case "$1" in
     *-wd*)
 =09STAGE=3Dwd
 =09STAGENAME=3D"Working Draft"
-=09WORKINGDRAFT=3D`basename "$1" | sed 's/.*-wd//'`
 =09;;
     *-os*)
 =09STAGE=3Dos
 =09STAGENAME=3D"OASIS Standard"
-=09WORKINGDRAFT=3D""
 =09;;
     *-csd*)
 =09STAGE=3Dcsd
-=09WORKINGDRAFT=3D`basename "$1" | sed 's/.*-csd//'`
-=09STAGENAME=3D"Committee Specification Draft $WORKINGDRAFT"
+=09STAGENAME=3D"Committee Specification Draft$WORKINGDRAFT"
 =09;;
     *-csprd*)
 =09STAGE=3Dcsprd
-=09WORKINGDRAFT=3D`basename "$1" | sed 's/.*-csprd//'`
-=09STAGENAME=3D"Committee Specification Draft $WORKINGDRAFT"
-=09STAGEEXTRATITLE=3D" / \newline Public Review Draft $WORKINGDRAFT"
-=09STAGEEXTRA=3D" / Public Review Draft $WORKINGDRAFT"
+=09STAGENAME=3D"Committee Specification Draft$WORKINGDRAFT"
+=09STAGEEXTRATITLE=3D" / \newline Public Review Draft$WORKINGDRAFT"
+=09STAGEEXTRA=3D" / Public Review Draft$WORKINGDRAFT"
 =09;;
     *-cs*)
 =09STAGE=3Dcs
-=09WORKINGDRAFT=3D`basename "$1" | sed 's/.*-cs//'`
-=09STAGENAME=3D"Committee Specification $WORKINGDRAFT"
+=09STAGENAME=3D"Committee Specification$WORKINGDRAFT"
 =09;;
     *)
 =09echo Unknown doc type >&2
@@ -54,7 +76,7 @@ cat > setup-generated.tex <<EOF
 % define VIRTIO Working Draft number and date
 \newcommand{\virtiorev}{$VERSION}
 \newcommand{\virtioworkingdraftdate}{$DATESTR}
-\newcommand{\virtioworkingdraft}{$WORKINGDRAFT}
+\newcommand{\virtioworkingdraft}{$COMMIT}
 \newcommand{\virtiodraftstage}{$STAGE}
 \newcommand{\virtiodraftstageextra}{$STAGEEXTRA}
 \newcommand{\virtiodraftstageextratitle}{$STAGEEXTRATITLE}
diff --git a/makeall.sh b/makeall.sh
index 37e6c34..1e25b82 100755
--- a/makeall.sh
+++ b/makeall.sh
@@ -1,7 +1,6 @@
 #!/bin/sh
=20
 export SPECDOC=3D${SPECDOC:-`cat REVISION`}
-export DATESTR=3D${DATESTR:-`cat REVISION-DATE`}
 ./makezip.sh
 ./makehtml.sh
 ./makepdf.sh
diff --git a/makediff.sh b/makediff.sh
index ef538c5..03f6731 100755
--- a/makediff.sh
+++ b/makediff.sh
@@ -1,7 +1,6 @@
 #force revision and date in environment
 #this way they don't appear in the diff
 export SPECDOC=3D${SPECDOC:-`cat REVISION`}
-export DATESTR=3D${DATESTR:-`cat REVISION-DATE`}
 export FROMVERSION=3D${FROMVERSION:-`cat DIFFVERSION`}
=20
 #make pdf diff using latexpand and latexdiff-fast
diff --git a/makediffall.sh b/makediffall.sh
index caff23e..f1a3333 100755
--- a/makediffall.sh
+++ b/makediffall.sh
@@ -1,5 +1,4 @@
 export SPECDOC=3D${SPECDOC:-`cat REVISION`}
-export DATESTR=3D${DATESTR:-`cat REVISION-DATE`}
 export FROMVERSION=3D${FROMVERSION:-`cat DIFFVERSION`}
 ./makezip.sh
 mv -f $SPECDOC.zip $SPECDOC-diff-from-${FROMVERSION}.pdf
diff --git a/makediffwithbase.sh b/makediffwithbase.sh
index 8cd3c7a..3916c83 100755
--- a/makediffwithbase.sh
+++ b/makediffwithbase.sh
@@ -1,5 +1,4 @@
 export SPECDOC=3D${SPECDOC:-`cat REVISION`}
-export DATESTR=3D${DATESTR:-`cat REVISION-DATE`}
 ./makezip.sh
 ./makehtml.sh
 ./makepdf.sh
diff --git a/maketex.sh b/maketex.sh
index c3b458f..1fee32b 100755
--- a/maketex.sh
+++ b/maketex.sh
@@ -1,3 +1,2 @@
 export SPECDOC=3D${SPECDOC:-`cat REVISION`}-tex
-export DATESTR=3D${DATESTR:-`cat REVISION-DATE`}
 ./makezip.sh
diff --git a/makezip.sh b/makezip.sh
index 806fa52..40b13cc 100755
--- a/makezip.sh
+++ b/makezip.sh
@@ -1,5 +1,4 @@
 export SPECDOC=3D${SPECDOC:-`cat REVISION`}
-export DATESTR=3D${DATESTR:-`cat REVISION-DATE`}
 rm -f $SPECDOC.zip
 if test -d .git; then
 =09git archive --format=3Dzip --prefix=3Dtex/ -o $SPECDOC.zip HEAD
@@ -15,6 +14,5 @@ zip $SPECDOC.zip listings/virtio_queue.h
 rm -fr tmpfilesforzip
 mkdir -p tmpfilesforzip/tex
 echo "$SPECDOC" > tmpfilesforzip/tex/REVISION
-echo "$DATESTR" > tmpfilesforzip/tex/REVISION-DATE
 cd tmpfilesforzip
 zip ../$SPECDOC.zip tex/*
--=20
2.20.1


This publicly archived list offers a means to provide input to the
OASIS Virtual I/O Device (VIRTIO) TC.

In order to verify user consent to the Feedback License terms and
to minimize spam in the list archive, subscription is required
before posting.

Subscribe: virtio-comment-subscribe@lists.oasis-open.org
Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
List help: virtio-comment-help@lists.oasis-open.org
List archive: https://lists.oasis-open.org/archives/virtio-comment/
Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lis=
ts
Committee: https://www.oasis-open.org/committees/virtio/
Join OASIS: https://www.oasis-open.org/join/

