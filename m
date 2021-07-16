Return-Path: <virtio-dev-return-8303-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DFF5A9864BD
	for <virtio-dev@lists.oasis-open.org>; Fri, 16 Jul 2021 06:56:18 +0000 (UTC)
From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Fri, 16 Jul 2021 12:26:13 +0530
Message-Id: <9fa7575c80200335ee32c9269ce5efcf0a729be7.1626418413.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH] Add .gitignore file
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="US-ASCII"
To: virtio-dev@lists.oasis-open.org
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>
List-ID: <virtio-dev.lists.oasis-open.org>

Add .gitignore to not see the unnecessary list of build generated files
with commands like git status.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 .gitignore | 10 ++++++++++
 1 file changed, 10 insertions(+)
 create mode 100644 .gitignore

diff --git a/.gitignore b/.gitignore
new file mode 100644
index 000000000000..0e2afb7f1d42
--- /dev/null
+++ b/.gitignore
@@ -0,0 +1,10 @@
+*.swp
+*.patch
+missfont.log
+listings/
+new/
+old/
+setup-generated.tex
+tmpfilesforzip/
+virtio-diff*
+virtio-v[0-9].[0-9]-cs[0-9][0-9]*
--=20
2.31.1.272.g89b43f80a514


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

