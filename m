Return-Path: <virtio-dev-return-10136-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AD54398650C
	for <virtio-dev@lists.oasis-open.org>; Wed,  9 Nov 2022 11:33:44 +0000 (UTC)
From: Heng Qi <hengqi@linux.alibaba.com>
Date: Wed,  9 Nov 2022 19:33:35 +0800
Message-Id: <20221109113336.121773-2-hengqi@linux.alibaba.com>
In-Reply-To: <20221109113336.121773-1-hengqi@linux.alibaba.com>
References: <20221109113336.121773-1-hengqi@linux.alibaba.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH 1/2] virtio_net: fix syntax errors
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="US-ASCII"; x-default=true
To: virtio-dev@lists.oasis-open.org
Cc: Jason Wang <jasowang@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Heng Qi <henqqi@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>

From: Heng Qi <henqqi@linux.alibaba.com>

\field{hash_types} can contain multiple bitmasks.

Signed-off-by: Heng Qi <henqqi@linux.alibaba.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 content.tex | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/content.tex b/content.tex
index e863709..6fabf1d 100644
--- a/content.tex
+++ b/content.tex
@@ -3210,7 +3210,7 @@ \subsection{Device configuration layout}\label{sec:De=
vice Types / Network Device
 The next field, \field{supported_hash_types} only exists if the device sup=
ports hash calculation,
 i.e. if VIRTIO_NET_F_RSS or VIRTIO_NET_F_HASH_REPORT is set.
=20
-Field \field{supported_hash_types} contains the bitmask of supported hash =
types.
+Field \field{supported_hash_types} contains the bitmasks of supported hash=
 types.
 See \ref{sec:Device Types / Network Device / Device Operation / Processing=
 of Incoming Packets / Hash calculation for incoming packets / Supported/en=
abled hash types} for details of supported hash types.
=20
 \devicenormative{\subsubsection}{Device configuration layout}{Device Types=
 / Network Device / Device configuration layout}
@@ -4369,7 +4369,7 @@ \subsubsection{Control Virtqueue}\label{sec:Device Ty=
pes / Network Device / Devi
     u8 hash_key_data[hash_key_length];
 };
 \end{lstlisting}
-Field \field{hash_types} contains a bitmask of allowed hash types as
+Field \field{hash_types} contains bitmasks of allowed hash types as
 defined in
 \ref{sec:Device Types / Network Device / Device Operation / Processing of =
Incoming Packets / Hash calculation for incoming packets / Supported/enable=
d hash types}.
 Initially the device has all hash types disabled and reports only VIRTIO_N=
ET_HASH_REPORT_NONE.
@@ -4398,7 +4398,7 @@ \subsubsection{Control Virtqueue}\label{sec:Device Ty=
pes / Network Device / Devi
     u8 hash_key_data[hash_key_length];
 };
 \end{lstlisting}
-Field \field{hash_types} contains a bitmask of allowed hash types as
+Field \field{hash_types} contains bitmasks of allowed hash types as
 defined in
 \ref{sec:Device Types / Network Device / Device Operation / Processing of =
Incoming Packets / Hash calculation for incoming packets / Supported/enable=
d hash types}.
=20
--=20
2.19.1.6.gb485710b


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

