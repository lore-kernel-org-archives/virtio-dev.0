Return-Path: virtio-comment-return-1163-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 27 Mar 2020 10:38:01 +0000
Message-Id: <20200327103803.10460-7-alex.bennee@linaro.org>
In-Reply-To: <20200327103803.10460-1-alex.bennee@linaro.org>
References: <20200327103803.10460-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Subject: [virtio-comment] [RFC PATCH  6/8] Remove all mentioned of subversion
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: virtio-dev@lists.oasis-open.org
Cc: virtio-comment@lists.oasis-open.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
List-ID: <virtio-dev.lists.oasis-open.org>

The repo hasn't been hosted in subversion for a while so the documents
are no longer relevant to working with the repo. Also remove the
unused code in the makezip.sh tool.

Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
---
 getchangelog.pl | 114 ------------------------------------------------
 git-svn.txt     |  34 ---------------
 makezip.sh      |   9 +---
 3 files changed, 1 insertion(+), 156 deletions(-)
 delete mode 100755 getchangelog.pl
 delete mode 100644 git-svn.txt

diff --git a/getchangelog.pl b/getchangelog.pl
deleted file mode 100755
index 5619ce4..0000000
--- a/getchangelog.pl
+++ /dev/null
@@ -1,114 +0,0 @@
-#!/usr/bin/perl
-
-use strict;
-
-my $rev =3D undef;
-if ($#ARGV >=3D 0) {
-=09$rev =3D shift @ARGV;
-} else {
-=09open(REV, "git svn log REVISION|") || die;
-=09while (<REV>) {
-=09=09next unless (m/^(r[0-9]+)/);
-=09=09#top revision is WD, skip it
-=09=09if (not defined $rev) {
-=09=09=09$rev =3D $1;
-=09=09=09next;
-=09=09} else {
-=09=09=09$rev =3D $1;
-=09=09=09last;
-=09=09}
-=09}
-}
-
-die unless $rev =3D~ m/^r([0-9]+)$/;
-$rev =3D $1;
-
-sub escapelatex {
-=09my $s =3D shift;
-=09$s =3D~ s/[\\]/\\textbackslash /go;
-=09$s =3D~ s/([&#%{}\$])/\\$1/go;
-=09$s =3D~ s/[~]/\\~{}/go;
-=09$s =3D~ s/(https?:\S*)/\\url{$1}/go;
-#1st line always on a separate paragraph
-=09$s =3D~ s/\n/\n\n/o;
-#Guess where new paragraph starts
-=09$s =3D~ s/\\.\n/.\n\n/go;
-=09$s =3D~ s/\n-/\n\n-/go;
-=09return $s;
-}
-
-#map editors to authors
-my %editors =3D {};
-$editors{'rusty'} =3D 'Rusty Russell <rusty@au1.ibm.com>';
-$editors{'hornet'} =3D 'Pawel Moll <pawel.moll@arm.com>';
-$editors{'cornelia.huck'} =3D 'Cornelia Huck <cornelia.huck@de.ibm.com>';
-$editors{'mstsirkin'} =3D 'Michael S. Tsirkin <mst@redhat.com>';
-
-my $cl =3D "";
-my $signoff =3D undef;
-my $editor =3D undef;
-my $date =3D undef;
-my $r =3D undef;
-open(LOG, "git svn log *tex|") || die;
-my $line =3D undef;
-while (<LOG>) {
-=09if (m/^----------------------------------------------------------------=
--------$/) {
-=09=09next if ($cl eq "");
-=09=09# act on it
-=09=09my $author;
-=09=09if (defined $signoff) {
-=09=09=09$author =3D $signoff;
-=09=09} else {
-=09=09=09$author =3D $editors{$editor};
-=09=09}
-=09=09#strip mail info
-=09=09$author =3D~ s/\s*<.*//;
-=09=09$cl =3D escapelatex($cl);
-=09=09print "$r & $date & $author & { $cl } \\\\\n";
-=09=09print "\\hline\n";
-
-=09=09$cl =3D "";
-=09=09$signoff =3D undef;
-=09=09$editor =3D undef;
-=09=09$date =3D undef;
-=09=09$r =3D undef;
-
-=09=09$line =3D 0;
-=09=09next;
-=09}
-=09$line++;
-#r164 | mstsirkin | 2013-12-08 14:30:55 +0200 (Sun, 08 Dec 2013)| 6 lines
-
-=09if ($line eq 1) {
-=09=09die unless (m/^r[0-9]/);
-=09=09my @rinfo =3D split(/\s*\Q|\E\s*/, $_);
-=09=09$r =3D $rinfo[0];
-
-=09=09die unless $r =3D~ m/^r([0-9]+)$/;
-=09=09$r =3D $1;
-=09=09last if ($r <=3D $rev);
-
-=09=09$editor =3D $rinfo[1];
-=09=09$date =3D $rinfo[2];
-=09=09die unless ($date =3D~ m/^[^(]*\([^,]*,\s*([^)]+)\)\s*$/);
-=09=09$date =3D $1;
-=09=09next;
-=09}
-=09next if (m/^$/);
-
-=09# First signature is the author: needed?
-=09# ignore for now
-=09#if (not defined $signoff and m/^Signed-off-by:\s*(.*)/) {
-=09#=09$signoff =3D $1;
-=09#}
-=09# skip signatures
-=09next if (m/^\s*[A-Z][A-Za-z-]*-by:/);
-
-
-=09# fix bug: wrong date in some commit logs
-=09if (/Change accepted on VIRTIO TC Meeting, 3 December 2013/) {
-=09=09$_ =3D "Change accepted on Virtio TC Meeting Minutes: Feb 25, 2014\n=
";
-=09}
-
-=09$cl .=3D $_;
-}
diff --git a/git-svn.txt b/git-svn.txt
deleted file mode 100644
index e094217..0000000
--- a/git-svn.txt
+++ /dev/null
@@ -1,34 +0,0 @@
-Using git svn with virtio svn repository:
-
-Initial clone (fetches all branches, takes a very long time):
-        git svn clone -s https://tools.oasis-open.org/version-control/svn/=
virtio
-Pull:
-        git svn rebase
-Push:
-        git svn dcommit
-
-Tagging 1.0 cs02 to match the released specification:
-        git branch -t v1.0-cs02
-
-Updating the trunk with all changes made on 1.0 branch:
-
-=09git config --global svn.pushmergeinfo true
-=09git checkout -b master origin/trunk
-=09git svn fetch
-=09git svn rebase -l
-=09git merge --no-ff origin/v1.0
-=09=09[ resolve merge conflicts ]
-=09git svn dcommit
-
-Faster initial clone from git mirror (example using mst's mirror at kernel=
.org):
-
-=09git clone git://git.kernel.org/pub/scm/virt/kvm/mst/virtio-text.git
-=09cd virtio-text
-=09git config --remove-section remote.origin
-=09git svn init -s https://tools.oasis-open.org/version-control/svn/virtio
-=09git svn rebase
-=09git checkout -b trunk origin/trunk
-
-Updating a git mirror from git-svn repository (after setting up a
-remote named "mirror"):
-=09git push mirror --prune +refs/remotes/origin/*:refs/heads/*
diff --git a/makezip.sh b/makezip.sh
index 3c94f8e..806fa52 100755
--- a/makezip.sh
+++ b/makezip.sh
@@ -3,15 +3,8 @@ export DATESTR=3D${DATESTR:-`cat REVISION-DATE`}
 rm -f $SPECDOC.zip
 if test -d .git; then
 =09git archive --format=3Dzip --prefix=3Dtex/ -o $SPECDOC.zip HEAD
-elif test -d .svn; then
-=09rm -fr export-from-svn
-=09mkdir -p export-from-svn
-=09svn export . export-from-svn/tex
-=09cd export-from-svn/
-=09zip ../$SPECDOC.zip tex/
-=09cd ..
 else
-=09echo Neither .git nor .svn found.
+=09echo .git not found.
 =09echo Falling back to generated list.
 fi
 zip -d $SPECDOC.zip tex/.gitattributes
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

