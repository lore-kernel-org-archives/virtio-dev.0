Return-Path: virtio-comment-return-1165-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 27 Mar 2020 10:38:03 +0000
Message-Id: <20200327103803.10460-9-alex.bennee@linaro.org>
In-Reply-To: <20200327103803.10460-1-alex.bennee@linaro.org>
References: <20200327103803.10460-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Subject: [virtio-comment] [RFC PATCH  8/8] Makefile: add simple make automation with clean target
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
To: virtio-dev@lists.oasis-open.org
Cc: virtio-comment@lists.oasis-open.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
List-ID: <virtio-dev.lists.oasis-open.org>

This will remove all intermediate files in the checkout.
---
 Makefile | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 Makefile

diff --git a/Makefile b/Makefile
new file mode 100644
index 0000000..f11d871
--- /dev/null
+++ b/Makefile
@@ -0,0 +1,17 @@
+# -*- Mode: makefile -*-
+#
+# Basic Makefile to aid automation of document building
+#
+
+.PHONY: help
+help:
+=09@echo "Build the VIRTIO specification documents."
+=09@echo ""
+=09@echo "Possible operations are:"
+=09@echo
+=09@echo " $(MAKE) clean                Remove all intermediate files"
+
+
+.PHONY: clean
+clean:
+=09@rm -f (git ls-files --others --exclude-standard)
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

