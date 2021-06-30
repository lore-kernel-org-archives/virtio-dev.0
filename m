Return-Path: <virtio-comment-return-1919-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Date: Wed, 30 Jun 2021 13:58:50 +0200
Message-Id: <20210630115851.12272-1-info@metux.net>
MIME-Version: 1.0
Subject: [virtio-comment] [PATCH v2 1/2] makepdf: fix shell command
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="US-ASCII"
To: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

The script needs bash, but calls /bin/sh, which might be (and on some
distros actually is) a completely different shell.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 makeall.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/makeall.sh b/makeall.sh
index 37e6c34..186a6d1 100755
--- a/makeall.sh
+++ b/makeall.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
=20
 export SPECDOC=3D${SPECDOC:-`cat REVISION`}
 export DATESTR=3D${DATESTR:-`cat REVISION-DATE`}
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

