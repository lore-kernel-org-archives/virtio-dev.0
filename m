Return-Path: virtio-comment-return-1454-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 14 Sep 2020 12:44:09 -0700
Message-ID: <160011251967.38663.1066997200552457824.stgit@ahduyck-workstation>
In-Reply-To: <20200914081355.71f0d3f7.cohuck@redhat.com>
References: <20200914081355.71f0d3f7.cohuck@redhat.com>
MIME-Version: 1.0
Subject: [virtio-comment] [PATCH v8 4/3] content: Minor change to clarify free_page_hint_cmd_id
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: mst@redhat.com, david@redhat.com, cohuck@redhat.com
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, wei.w.wang@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

From: Alexander Duyck <alexander.h.duyck@linux.intel.com>

The original wording was a bit unclear and could have been misinterpreted
as indicating that VIRTIO_BALLOON_FREE_PAGE_HINT was read-only instead of
the field free_page_hint_cmd_id. To clarify that break it up into two
sentences making it clear that the field is only available if the feature
is negotiated, and that the field is read-only.

Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
---

So this patch addresses a minor nit that was pointed out after the ballot
had already been created. If need be I can either open a new bugzilla and
request a ballot to have it added.

 content.tex |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/content.tex b/content.tex
index 76dfce919b97..f74090491534 100644
--- a/content.tex
+++ b/content.tex
@@ -5052,8 +5052,8 @@ \subsection{Device configuration layout}\label{sec:Device Types / Memory Balloon
   \field{num_pages} and \field{actual} are always available.
 
   \field{free_page_hint_cmd_id} is available if
-    VIRTIO_BALLOON_F_FREE_PAGE_HINT has been negotiated and is read-only by
-    the driver.
+    VIRTIO_BALLOON_F_FREE_PAGE_HINT has been negotiated. The field is
+    read-only by the driver.
 
 \begin{lstlisting}
 struct virtio_balloon_config {



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
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
Committee: https://www.oasis-open.org/committees/virtio/
Join OASIS: https://www.oasis-open.org/join/

