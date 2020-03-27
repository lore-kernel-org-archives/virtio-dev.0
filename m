Return-Path: virtio-comment-return-1169-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Date: Fri, 27 Mar 2020 11:53:38 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20200327115338.57a79ac4.cohuck@redhat.com>
In-Reply-To: <20200327103803.10460-1-alex.bennee@linaro.org>
References: <20200327103803.10460-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Subject: Re: [virtio-comment] [RFC PATCH  0/8] some tweaks to the document
 build process
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>
Cc: virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, 27 Mar 2020 10:37:55 +0000
Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:

> Hi,
>=20
> I was reviewing someones virtio-spec and realised that I wasn't quite
> sure what it had been built from. Seeing as the standard is hosted in
> git I've tried to clean up some of the automation to make it clearer
> what a particular rendering was built from. Going forward it would be
> nice to use signed annotated tags for the final build version but I
> don't know how much of the boilerplate is down to OASIS requirements.

OASIS requirements are my concern here as well.

>=20
> What do people think? Is this worth improving on?
>=20
> Alex Benn=C3=A9e (8):
>   README.md: convert html to proper Markdown format
>   CONTRIBUTING.md: convert to proper MarkDown
>   LICENSE.md: convert html to proper MarkDown

We should double-check first if the html snippets in there are sourced
into some official web page somewhere. If not, I'm all for converting
this.

>   makeall.sh: add explicit shebang to script
>   Cleanup old changelog files

I'm not sure if there are any requirements for keeping this -- even if
they are available in the history forever.

>   Remove all mentioned of subversion

That's probably fine.

>   make*: remove reliance on REVISION-DATE and use git
>   Makefile: add simple make automation with clean target
>=20
>  CONTRIBUTING.md         |   22 +-
>  LICENSE.md              |    9 +-
>  Makefile                |   17 +
>  README.md               |  258 ++++------
>  REVISION-DATE           |    1 -
>  cl-cs01.tex             |   86 ----
>  cl-cs02.tex             |   52 --
>  cl-cs03.tex             |  328 ------------
>  cl-cs04.tex             |  134 -----
>  cl-csprd02.tex          | 1043 ---------------------------------------
>  cl-csprd03.tex          |  400 ---------------
>  getchangelog.pl         |  114 -----
>  git-svn.txt             |   34 --
>  make-setup-generated.sh |   54 +-
>  makeall.sh              |    3 +-
>  makediff.sh             |    1 -
>  makediffall.sh          |    1 -
>  makediffwithbase.sh     |    1 -
>  maketex.sh              |    1 -
>  makezip.sh              |   11 +-
>  20 files changed, 169 insertions(+), 2401 deletions(-)
>  create mode 100644 Makefile
>  delete mode 100644 REVISION-DATE
>  delete mode 100644 cl-cs01.tex
>  delete mode 100644 cl-cs02.tex
>  delete mode 100644 cl-cs03.tex
>  delete mode 100644 cl-cs04.tex
>  delete mode 100644 cl-csprd02.tex
>  delete mode 100644 cl-csprd03.tex
>  delete mode 100755 getchangelog.pl
>  delete mode 100644 git-svn.txt
>=20


This publicly archived list offers a means to provide input to the=0D
OASIS Virtual I/O Device (VIRTIO) TC.=0D
=0D
In order to verify user consent to the Feedback License terms and=0D
to minimize spam in the list archive, subscription is required=0D
before posting.=0D
=0D
Subscribe: virtio-comment-subscribe@lists.oasis-open.org=0D
Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org=0D
List help: virtio-comment-help@lists.oasis-open.org=0D
List archive: https://lists.oasis-open.org/archives/virtio-comment/=0D
Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf=
=0D
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lis=
ts=0D
Committee: https://www.oasis-open.org/committees/virtio/=0D
Join OASIS: https://www.oasis-open.org/join/

