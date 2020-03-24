Return-Path: virtio-comment-return-1152-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 24 Mar 2020 17:54:38 +0000
Message-Id: <20200324175446.13965-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Subject: [virtio-comment] [RFC PATCH  0/8] some tweaks to the document build process
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
List-ID: <virtio-dev.lists.oasis-open.org>

Hi,

I was reviewing someones virtio-spec and realised that I wasn't quite
sure what it had been built from. Seeing as the standard is hosted in
git I've tried to clean up some of the automation to make it clearer
what a particular rendering was built from. Going forward it would be
nice to use signed annotated tags for the final build version but I
don't know how much of the boilerplate is down to OASIS requirements.

What do people think? Is this worth improving on?

Alex Benn=C3=A9e (8):
  README.md: convert html to proper Markdown format
  CONTRIBUTING.md: convert to proper MarkDown
  LICENSE.md: convert html to proper MarkDown
  makeall.sh: add explicit shebang to script
  Cleanup old changelog files
  Remove all mentioned of subversion
  make*: remove reliance on REVISION-DATE and use git
  Makefile: add simple make automation with clean target

 CONTRIBUTING.md         |   22 +-
 LICENSE.md              |    9 +-
 Makefile                |   17 +
 README.md               |  258 ++++------
 REVISION-DATE           |    1 -
 cl-cs01.tex             |   86 ----
 cl-cs02.tex             |   52 --
 cl-cs03.tex             |  328 ------------
 cl-cs04.tex             |  134 -----
 cl-csprd02.tex          | 1043 ---------------------------------------
 cl-csprd03.tex          |  400 ---------------
 getchangelog.pl         |  114 -----
 git-svn.txt             |   34 --
 make-setup-generated.sh |   54 +-
 makeall.sh              |    3 +-
 makediff.sh             |    1 -
 makediffall.sh          |    1 -
 makediffwithbase.sh     |    1 -
 maketex.sh              |    1 -
 makezip.sh              |   11 +-
 20 files changed, 169 insertions(+), 2401 deletions(-)
 create mode 100644 Makefile
 delete mode 100644 REVISION-DATE
 delete mode 100644 cl-cs01.tex
 delete mode 100644 cl-cs02.tex
 delete mode 100644 cl-cs03.tex
 delete mode 100644 cl-cs04.tex
 delete mode 100644 cl-csprd02.tex
 delete mode 100644 cl-csprd03.tex
 delete mode 100755 getchangelog.pl
 delete mode 100644 git-svn.txt

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

