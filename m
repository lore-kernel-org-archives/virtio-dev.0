Return-Path: <virtio-comment-return-3479-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Date: Mon, 21 Nov 2022 11:30:23 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20221121162756.350032-3-mst@redhat.com>
References: <20221121162756.350032-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20221121162756.350032-1-mst@redhat.com>
Subject: [virtio-comment] [PATCH RFC 2/3] rng: be specific about the virtqueue
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, "Cali, Marco" <xmarcalx@amazon.co.uk>, "Graf (AWS), Alexander" <graf@amazon.de>, "Chalios, Babis" <bchalios@amazon.es>, "Jason A. Donenfeld" <Jason@zx2c4.com>
List-ID: <virtio-dev.lists.oasis-open.org>

As we are going to add more virtqueues, when talking
about the requestq be specific and mention it by name
as opposed to just generally "the virtqueue".

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 virtio-rng.tex | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/virtio-rng.tex b/virtio-rng.tex
index c26f589..1ec7164 100644
--- a/virtio-rng.tex
+++ b/virtio-rng.tex
@@ -20,23 +20,24 @@ \subsection{Device configuration layout}\label{sec:Device Types / Entropy Device
 \subsection{Device Initialization}\label{sec:Device Types / Entropy Device / Device Initialization}
 
 \begin{enumerate}
-\item The virtqueue is initialized
+\item The \field{requestq} virtqueue is initialized
 \end{enumerate}
 
 \subsection{Device Operation}\label{sec:Device Types / Entropy Device / Device Operation}
 
 When the driver requires random bytes, it places the descriptor
-of one or more buffers in the queue. It will be completely filled
+of one or more buffers in the \field{requestq} virtqueue. It will be completely filled
 by random data by the device.
 
 \drivernormative{\subsubsection}{Device Operation}{Device Types / Entropy Device / Device Operation}
 
-The driver MUST NOT place device-readable buffers into the queue.
+The driver MUST NOT place device-readable buffers into the \field{requestq} virtqueue.
 
 The driver MUST examine the length written by the device to determine
 how many random bytes were received.
 
 \devicenormative{\subsubsection}{Device Operation}{Device Types / Entropy Device / Device Operation}
 
-The device MUST place one or more random bytes into the buffer, but it
+The device MUST place one or more random bytes into the buffer
+made available to it through \field{requestq}, but it
 MAY use less than the entire buffer length.
-- 
MST


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

