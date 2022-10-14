Return-Path: <virtio-dev-return-10018-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CEE279866F3
	for <virtio-dev@lists.oasis-open.org>; Fri, 14 Oct 2022 14:18:33 +0000 (UTC)
From: hrishivarya.bhageeradhan@opensynergy.com
Date: Fri, 14 Oct 2022 16:18:26 +0200
Message-Id: <20221014141826.502247-1-hrishivarya.bhageeradhan@opensynergy.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH] content: reserve device ID 43 for Camera device
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
To: virtio-dev@lists.oasis-open.org, hrishivarya.bhageeradhan@opensynergy.com
List-ID: <virtio-dev.lists.oasis-open.org>

From: Hrishivarya Bhageeradhan <hrishivarya.bhageeradhan@opensynergy.com>

The virtio-camera device allows to stream a camera video with
ability to change controls, formats and get camera captures.
This patch is to reserve the next available device ID for
virtio-camera.

Signed-off-by: Hrishivarya Bhageeradhan <hrishivarya.bhageeradhan@opensyner=
gy.com>
---
 content.tex | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/content.tex b/content.tex
index e863709..91ba76c 100644
--- a/content.tex
+++ b/content.tex
@@ -2990,6 +2990,8 @@ \chapter{Device Types}\label{sec:Device Types}
 \hline
 42         &   RDMA device \\
 \hline
+43         &   Camera device \\
+\hline
 \end{tabular}

 Some of the devices above are unspecified by this document,
--
2.25.1


Please mind our privacy notice<https://www.opensynergy.com/datenschutzerkla=
erung/privacy-notice-for-business-partners-pursuant-to-article-13-of-the-ge=
neral-data-protection-regulation-gdpr/> pursuant to Art. 13 GDPR. // Unsere=
 Hinweise zum Datenschutz gem. Art. 13 DSGVO finden Sie hier.<https://www.o=
pensynergy.com/de/datenschutzerklaerung/datenschutzhinweise-fuer-geschaefts=
partner-gem-art-13-dsgvo/>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

