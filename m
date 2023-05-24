Return-Path: <virtio-dev-return-12810-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C80CEC7EE2C
	for <virtio-dev@archiver.kernel.org>; Wed, 24 May 2023 11:33:56 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 1B20942560
	for <virtio-dev@archiver.kernel.org>; Wed, 24 May 2023 11:33:53 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 61840986738
	for <virtio-dev@archiver.kernel.org>; Wed, 24 May 2023 11:33:52 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 1DE1E98659A; Wed, 24 May 2023 11:33:52 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C21AA986413;
	Wed, 24 May 2023 11:33:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-TM-MAIL-RECEIVED-TIME: 1684928020.815000
X-TM-MAIL-UUID: 9e45b87f-8c59-40ad-91d4-eb6776f88c99
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B9NoGDOkXx1X2cc+FMj0RaWYMV9+7LHhGk/0I+T0j5qsqZ7StIp+hGE0bOjrI+9fgiIUNtQYb7c1KkCveZAEP+tSvWnizwLNqhUMsytqxW7SrPN/uswLzadGWBdxqak52vraRnnpRWp7CmBFuVL5XU+1bB0CKSrW+oIrWMFRU2pxHTcIeO92Xi6wXKNEnWSdkg6zU3i4RvcDMqziwHJrW3/WG0FOMoGNCh4yy745fldizIk69EvdoLnZiwXRMGbTYXuIG37qvfGqpdkO9mwUcCG5cM6OzoQa6WEtxfcSGZODCGPlQyA5Po19hycXRu4LWSspElPHebtfhnsQqw05pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WbzIYJKwir4O18dmYCx4inZKX7kJ4n2tjGk7LjW2xf0=;
 b=iIuSbwRGgDdLJ+v5QzIG/+3uqiK0zhyvjIobivWP88DSlT/FLcu+x8WJ3FVVTTte7jR7RsFbS7CDIMOrmeIXMG21UHLfhrryqqMhsAa7inzLKHkPer+w98FZCE3a5em0z0ny5vanWd2GxSr67niFKoDgdPlpA7noEagQUpgevdW8/xHXPVsaNExm6xnr3JUv48sAwVHdHDRTS7KKSiWzK7BzammM1K/wcZEiN0LXUdNdqeu7/OwIDxfMPWGTo0jb+oVAuQC8UQm8GwUlTegXCjCoeULoA5L+9BMEa0scMm23H8V+v8qLKfm9dZXNIq9V8u8F4yUibS+mQFkvoyxmmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 217.66.60.4) smtp.rcpttodomain=chromium.org smtp.mailfrom=opensynergy.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=opensynergy.com; dkim=none (message not signed); arc=none
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 217.66.60.4)
 smtp.mailfrom=opensynergy.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=opensynergy.com;
Received-SPF: Pass (protection.outlook.com: domain of opensynergy.com
 designates 217.66.60.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.66.60.4; helo=SR-MAIL-03.open-synergy.com; pr=C
From: Alexander Gordeev <Alexander.Gordeev@opensynergy.com>
To: virtio-comment@lists.oasis-open.org,
	virtio-dev@lists.oasis-open.org,
	Albert Esteve <aesteve@redhat.com>,
	Alexandre Courbot <acourbot@chromium.org>,
	alex.bennee@linaro.org,
	Andrew Gazizov <andrew.gazizov@opensynergy.com>,
	Andrii Cherniavskyi <andrii.cherniavskyi@opensynergy.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Enric Balletbo i Serra <eballetb@redhat.com>,
	Enrico Granata <egranata@google.com>,
	Gustavo Padovan <gustavo.padovan@collabora.com>,
	Keiichi Watanabe <keiichiw@chromium.org>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Marcin Wojtas <mwojtas@google.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Peter Griffin <peter.griffin@linaro.org>,
	Tomasz Figa <tfiga@chromium.org>,
	Matti.Moell@opensynergy.com,
	bag@semihalf.com,
	bgrzesik@google.com,
	hmazur@google.com,
	mikrawczyk@google.com,
	srosek@google.com,
	zyta@google.com
Cc: Alexander Gordeev <Alexander.Gordeev@opensynergy.com>
Date: Wed, 24 May 2023 13:33:18 +0200
Message-Id: <20230524113318.518692-2-Alexander.Gordeev@opensynergy.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230524113318.518692-1-Alexander.Gordeev@opensynergy.com>
References: <20230524113318.518692-1-Alexander.Gordeev@opensynergy.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1EUR05FT054:EE_|BE1P281MB2996:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: a6eb47da-28d3-4f61-deb4-08db5c4ab6ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	n/a6Li183Q1DoIe2dig5/73RckYpfNJi53t+RvygPaMjTLC0k4PLKNpf+fUv4mAnasz9mTeClQG7trPls3beHHFag9rTJuI71dyQeuvcjBpU0gHYwcbb71FgBIFwRmNolE6j+eHhSLzzS1DcC7+PyIC49Th8cKobQpgCp3ImuFWCJXmoLr6X4mRGqoX29p4+jur/CD5YfChUHvy4Sn4R4dxE7E1cfyziMXpi/1HPe3SS09MvCpIkNg8b6L3XQP7ye4FN8bUOiO3lsoTWHmTjwU8kM6/91xMXlJcGigT3Yz9W5Uxv4s5QWcuhYYWWyUEJgj9k7AeCWCV7bHz/CGQRsI94oxvYh3XjiRlhBEvvpeO1gqwn2ChBNmEA6I+W7zK3zNgSKdBXm7k2dKw0cHQa9JBbuTbylUOc+VnEF194HSfJyp9LlfKBsGO6otRnMiRZaK+q+C3kYPmxt/YcfkA3uYJ/3wJpDUFangTnMuDLJnTy7uRdMNz/T6AjaAAcZ9yi7TFFKvb6QGQoapI6aCT9lcX7fhrwDCWQeNt0eJXK/aAqU/zHY6rrapDypizE2JmxK00xm6iFa/fkXrrPUxKrdgAkXsz8FAmFytlYpnabWxDUYszl5nbVNU4XlrEx52HoFoY1fTiBpt2L8HfRWelH5DSKQlgtZz8UzEyzfcwSZ+nXSEfHX9uIqHen3Vd4oDM2jkJWMeMVmxllb4UI9U7rsUUEJkDiU4UgnSBzlCyMztZLFTV7oYLVqef0MUVWYCwr7Drq2KwSKYDQ9sVld/K0+cxuO5+52otykySEWUVIxAA=
X-Forefront-Antispam-Report:
	CIP:217.66.60.4;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SR-MAIL-03.open-synergy.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(376002)(346002)(39840400004)(136003)(396003)(451199021)(36840700001)(46966006)(82310400005)(36860700001)(336012)(316002)(921005)(5660300002)(7416002)(36756003)(81166007)(40480700001)(41300700001)(70206006)(70586007)(107886003)(47076005)(83380400001)(4326008)(478600001)(186003)(30864003)(8676002)(8936002)(86362001)(2906002)(110136005)(26005)(42186006)(2616005)(1076003)(36900700001)(559001)(579004);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2023 11:33:36.4393
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6eb47da-28d3-4f61-deb4-08db5c4ab6ac
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=800fae25-9b1b-4edc-993d-c939c4e84a64;Ip=[217.66.60.4];Helo=[SR-MAIL-03.open-synergy.com]
X-MS-Exchange-CrossTenant-AuthSource:
	VI1EUR05FT054.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE1P281MB2996
X-TM-AS-ERS: 104.47.11.174-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1007-27646.007
X-TMASE-Result: 10--37.555100-4.000000
X-TMASE-MatchedRID: beVDmbIhaME0b21ExFN2+qoXHZz/dXlxtDwh7YQTftN8vx8dQICa6xzu
	L4P52bGMjD2u30TwDiivwm0pw/7rQdz4cH5hW96YzYK5U+QI3O7BOVz0Jwcxl6vCrG0TnfVUaUX
	s6FguVy2877BVIJP3X30GFT5KU5MDUb9lEuZnMySyMWcHlEdDX9G3Y6ijqBt3WAuSz3ewb23T0P
	pHDbMisyWRqpXdALNez2BzWfwZiWtwyAmzxb7Z05Ak4Vz6rKorbVpKAU3PUEb44PEIh5jzG6KJ8
	yeXnfHAYkpEt3v9lIM26w1VKWEcTbOSuzNaqOKl4bp7SkqrNmmUO3k9AyCPTSNc2RZgnIdMU6dq
	4zU7M7O5fZSg7LfdFMI8a+iNHcSe7xCWOo2+4brG+nS24MzHebFcDzCo2ZtWRkICFa5gS+SkkTG
	Znjve6197VMViFlyeNMJ26/MZwKN+wAuSUWlj5A7LUBXy1QPwHLMdyB+LKtwaqZRmrM2balOkRI
	CTn8kKadj884PZEN7L0O7A1t3q4SUbMHwo/PiaG9TMqjxt7zFPnKxAOPp4WZfgq3BB/7ARGxqfj
	jQHhtxKeCNkS3i57IhMTcdVKb+FHrdU8b54DYM4hD0Y/Y/a7xap5mln19zzLEzDQUyQGVl1h8CC
	Bqmu8RjcNb3CF3X/vozYXu4KE3wHAGyld+eWZ8TiL+P6CoMgqf/efKFN1nAyr+EEjz9hsSuQG1R
	azp1egwbhD51IUQV/CCtab6s37rCJvLOmyWTFTbFVCYPBTqZvrcC8cqLKoXUdiACDPkYl2bBB17
	cIjBp95PGsEWgS8+4+2csFUqIy8UD9moVqZZJ+yskgwrfsC30tCKdnhB58FMkUvzgg/cWVHVxP1
	hp9BUazPf1QyU1J9xS3mVzWUuCRTpSQiv9X7WcwT8myf+b6
X-TMASE-XGENCLOUD: 8344670f-8322-4080-8897-44e5933ca425-0-0-200-0
X-TM-Deliver-Signature: B4899B4E973A1859EF802BF2E2558E18
X-TM-Addin-Auth: dNjv1J/Ej2J1iPHoYzBDipx/WRYBck5cJljAwZ+KJNsPmXcXIc2mk39LqfF
	emSK/dBCW8Mb5OsKjycn8duV1Q0WdvDV9/Guu8yDyBntonTizBSsXL863CSx49DSEdFbfhoPyIA
	oq1HNWMrD7xUeYDLSi9JO/NlB1dpGaNKSPE/EhZ1wfhl2jFZk+OT6f40uniRJjinzw9KiqR8LZe
	K8TIuwnj29nQGATTqjg4kieZuqW0qT1T7gK+VVl8z1Izx+skPk8bgXo/2kU3I4VvvlKPLpr9kGG
	bQ7oK5wo6hekSgZsLjn/TDU8uhyxRZnm9/7z.mDxidXan09WZUYcleqC+ATa4bOrubl9mMet9jd
	TpgCqEGW9gzNvWQMbzllo973Xu4nBSMNyDjzRkxeh4yKOtXNkwT5A7Rld/Vjan6awk3SAhxXbdf
	uXefGvvcjMSjKOTtvxk5M4a6SehS3ZhI3iHQsvK/2f7fueDeXt7Q+kGaeECCAY/jhG+2dmq5svG
	ehCzT3UqoAX99L6VKw/agZF3d5azHuuY7NH4KPuOyTa+Cvq0xzdsLQH7oNM7qVqPPSVS5c0o4nT
	x2EMS7j5qv7qjl2Oi/G/aWQTbkb2xOv8wdV20DmlU8iEr4hYXq9BN9DNhVzJvbn09d8qzEm218B
	Ebag==
X-TM-Addin-ProductCode: EMS
Subject: [virtio-dev] [RFC PATCH v7 1/1] virtio-video: Add virtio video device specification

Add the specification of the video decoder and encoder devices, which
can be used to provide host-accelerated video operations to the guest.

Signed-off-by: Alexander Gordeev <Alexander.Gordeev@opensynergy.com>
Co-authored-by: Keiichi Watanabe <keiichiw@chromium.org>
Co-authored-by: Alexandre Courbot <acourbot@chromium.org>
---
 conformance.tex                           |    4 +
 content.tex                               |    1 +
 device-types/video/description.tex        | 2005 +++++++++++++++++++++
 device-types/video/device-conformance.tex |   24 +
 device-types/video/driver-conformance.tex |   18 +
 introduction.tex                          |   21 +
 6 files changed, 2073 insertions(+)
 create mode 100644 device-types/video/description.tex
 create mode 100644 device-types/video/device-conformance.tex
 create mode 100644 device-types/video/driver-conformance.tex

diff --git a/conformance.tex b/conformance.tex
index 01ccd69..d719eda 100644
--- a/conformance.tex
+++ b/conformance.tex
@@ -34,6 +34,7 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
 \ref{sec:Conformance / Driver Conformance / SCMI Driver Conformance},
 \ref{sec:Conformance / Driver Conformance / GPIO Driver Conformance} or
 \ref{sec:Conformance / Driver Conformance / PMEM Driver Conformance}.
+\ref{sec:Conformance / Driver Conformance / Video Driver Conformance},
 
     \item Clause \ref{sec:Conformance / Legacy Interface: Transitional Device and Transitional Driver Conformance}.
   \end{itemize}
@@ -61,6 +62,7 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
 \ref{sec:Conformance / Device Conformance / SCMI Device Conformance},
 \ref{sec:Conformance / Device Conformance / GPIO Device Conformance} or
 \ref{sec:Conformance / Device Conformance / PMEM Device Conformance}.
+\ref{sec:Conformance / Device Conformance / Video Device Conformance},
 
     \item Clause \ref{sec:Conformance / Legacy Interface: Transitional Device and Transitional Driver Conformance}.
   \end{itemize}
@@ -152,6 +154,7 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
 \input{device-types/scmi/driver-conformance.tex}
 \input{device-types/gpio/driver-conformance.tex}
 \input{device-types/pmem/driver-conformance.tex}
+\input{device-types/video/driver-conformance.tex}
 
 \conformance{\section}{Device Conformance}\label{sec:Conformance / Device Conformance}
 
@@ -238,6 +241,7 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
 \input{device-types/scmi/device-conformance.tex}
 \input{device-types/gpio/device-conformance.tex}
 \input{device-types/pmem/device-conformance.tex}
+\input{device-types/video/device-conformance.tex}
 
 \conformance{\section}{Legacy Interface: Transitional Device and Transitional Driver Conformance}\label{sec:Conformance / Legacy Interface: Transitional Device and Transitional Driver Conformance}
 A conformant implementation MUST be either transitional or
diff --git a/content.tex b/content.tex
index cff548a..1255e6e 100644
--- a/content.tex
+++ b/content.tex
@@ -710,6 +710,7 @@ \chapter{Device Types}\label{sec:Device Types}
 \input{device-types/scmi/description.tex}
 \input{device-types/gpio/description.tex}
 \input{device-types/pmem/description.tex}
+\input{device-types/video/description.tex}
 
 \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
 
diff --git a/device-types/video/description.tex b/device-types/video/description.tex
new file mode 100644
index 0000000..43d368d
--- /dev/null
+++ b/device-types/video/description.tex
@@ -0,0 +1,2005 @@
+\section{Video Device}
+\label{sec:Device Types / Video Device}
+
+The virtio video encoder and decoder devices provide support for
+host-accelerated video encoding and decoding. Despite being different
+device types, they use the same protocol and general flow.
+
+\subsection{Device ID}
+\label{sec:Device Types / Video Device / Device ID}
+
+\begin{description}
+\item[30]
+  encoder device
+\item[31]
+  decoder device
+\end{description}
+
+\subsection{Virtqueues}
+\label{sec:Device Types / Video Device / Virtqueues}
+
+\begin{description}
+\item[0]
+  commandq - queue for driver commands and device responses to these commands
+\item[1]
+  eventq - queue for events sent by the device to the driver
+\end{description}
+
+\subsection{Feature bits}
+\label{sec:Device Types / Video Device / Feature bits}
+
+\begin{description}
+\item[VIRTIO_VIDEO_F_RESOURCE_GUEST_PAGES (0)]
+  Guest pages can be used as the backing memory of resources.
+\item[VIRTIO_VIDEO_F_RESOURCE_NON_CONTIG (1)]
+  The device can use non-contiguous guest memory as the backing memory of
+  resources. Only meaningful if VIRTIO_VIDEO_F_RESOURCE_GUEST_PAGES is also
+  set.
+\item[VIRTIO_VIDEO_F_RESOURCE_DYNAMIC (2)]
+  The device supports re-attaching memory to resources while streaming.
+% TODO this flag is not used anywhere at the moment.
+% Might be necessary with Android.
+\item[VIRTIO_VIDEO_F_RESOURCE_VIRTIO_OBJECT (3)]
+  Objects exported by another virtio device can be used as the backing memory
+  of resources.
+\end{description}
+
+\devicenormative{\subsubsection}{Feature bits}{Device Types / Video Device / Feature bits}
+
+The device MUST set at least one of VIRTIO_VIDEO_F_RESOURCE_GUEST_PAGES or
+VIRTIO_VIDEO_F_RESOURCE_VIRTIO_OBJECT, since the absence of both bits would
+mean that no memory can be used at all for resources.
+
+The device MUST NOT set VIRTIO_VIDEO_F_RESOURCE_NON_CONTIG unless it also sets
+VIRTIO_VIDEO_F_RESOURCE_GUEST_PAGES.
+
+\drivernormative{\subsubsection}{Feature bits}{Device Types / Video Device / Feature bits}
+
+The driver MUST negotiate at least one of the
+VIRTIO_VIDEO_F_RESOURCE_GUEST_PAGES and VIRTIO_VIDEO_F_RESOURCE_VIRTIO_OBJECT
+features.
+
+If VIRTIO_VIDEO_F_RESOURCE_GUEST_PAGES has been negotiated, but not
+VIRTIO_VIDEO_F_RESOURCE_NON_CONTIG, the driver MUST use physically
+contiguous memory for all the buffers it allocates.
+
+\subsection{Device configuration layout}
+\label{sec:Device Types / Video Device / Device configuration layout}
+
+The video device configuration space uses the following layout:
+
+\begin{lstlisting}
+struct virtio_video_config {
+        le32 caps_length;
+};
+\end{lstlisting}
+
+\begin{description}
+\item[\field{caps_length}]
+  is the minimum length in bytes that a device-writable buffer must have
+  in order to receive the response to VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS, see
+  \ref{sec:Device Types / Video Device / Device Operation / Device Operation: Device Commands / VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS}.
+\end{description}
+
+\devicenormative{\subsubsection}{Device configuration layout}{Device Types / Video Device / Device configuration layout}
+
+The device MUST set the \field{caps_length} field to a value equal to
+the response size of VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS.
+
+\subsection{Supported parameters}
+\label{sec:Device Types / Video Device / Supported parameters}
+
+\subsubsection{Supported coded formats}
+\label{sec:Device Types / Video Device / Supported parameters / Supported coded formats}
+
+The following coded formats are defined:
+\begin{lstlisting}
+#define VIRTIO_VIDEO_CODED_FORMAT_MPEG2  1  /* MPEG-2 Part 2  (V4L2_PIX_FMT_MPEG2) */
+#define VIRTIO_VIDEO_CODED_FORMAT_MPEG4  2  /* MPEG-4 Part 2  (V4L2_PIX_FMT_MPEG4) */
+#define VIRTIO_VIDEO_CODED_FORMAT_H264   3  /* H.264          (V4L2_PIX_FMT_H264)  */
+#define VIRTIO_VIDEO_CODED_FORMAT_HEVC   4  /* HEVC aka H.265 (V4L2_PIX_FMT_HEVC)  */
+#define VIRTIO_VIDEO_CODED_FORMAT_VP8    5  /* VP8            (V4L2_PIX_FMT_VP8)   */
+#define VIRTIO_VIDEO_CODED_FORMAT_VP9    6  /* VP9            (V4L2_PIX_FMT_VP9)   */
+\end{lstlisting}
+
+The above constants have two usages:
+\begin{enumerate}
+\item As bit numbers, used to tell the driver which coded formats are
+supported by the device, see
+\ref{sec:Device Types / Video Device / Device Operation / Device Operation: Device Commands / VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS}.
+\item As values, used to designate the coded format when working with
+stream parameters, see
+\ref{sec:Device Types / Video Device / Device Operation / Device Operation: Stream commands / VIRTIO_VIDEO_CMD_STREAM_SET_PARAMS}.
+\end{enumerate}
+
+The coded formats and the expected data units per buffer are documented in
+\hyperref[intro:V4L2]{V4L2 header} and
+\hyperref[intro:V4L2 compressed]{V4L2 compressed formats documentation}.
+
+\subsubsection{Supported raw formats}
+\label{sec:Device Types / Video Device / Supported parameters / Supported raw formats}
+
+The following raw formats are defined:
+\begin{lstlisting}
+#define VIRTIO_VIDEO_RAW_FORMAT_ARGB8888  1  /* DRM_FORMAT_ARGB8888 / V4L2_PIX_FMT_ABGR32 */
+#define VIRTIO_VIDEO_RAW_FORMAT_BGRA8888  2  /* DRM_FORMAT_BGRA8888 / V4L2_PIX_FMT_ARGB32 */
+#define VIRTIO_VIDEO_RAW_FORMAT_RGBA8888  3  /* DRM_FORMAT_RGBA8888 / V4L2_PIX_FMT_BGRA32 */
+#define VIRTIO_VIDEO_RAW_FORMAT_NV12      4  /* DRM_FORMAT_NV12     / V4L2_PIX_FMT_NV12   */
+#define VIRTIO_VIDEO_RAW_FORMAT_YUV420    5  /* DRM_FORMAT_YUV420   / V4L2_PIX_FMT_YUV420 */
+#define VIRTIO_VIDEO_RAW_FORMAT_YVU420    6  /* DRM_FORMAT_YVU420   / V4L2_PIX_FMT_YVU420 */
+#define VIRTIO_VIDEO_RAW_FORMAT_YUYV      7  /* DRM_FORMAT_YUYV     / V4L2_PIX_FMT_YUYV   */
+\end{lstlisting}
+
+The above constants have two usages:
+\begin{enumerate}
+\item As bit numbers, used to tell the driver which raw formats are
+supported by the device, see
+\ref{sec:Device Types / Video Device / Device Operation / Device Operation: Device Commands / VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS}.
+\item As values, used to designate the raw format when working with
+stream parameters, see
+\ref{sec:Device Types / Video Device / Device Operation / Device Operation: Stream commands / VIRTIO_VIDEO_CMD_STREAM_SET_PARAMS}.
+\end{enumerate}
+
+The layouts of raw formats are documented in \hyperref[intro:DRM formats]{DRM}
+and \hyperref[intro:V4L2]{V4L2} headers, as well as in
+\hyperref[intro:V4L2 RGB]{V4L2 RGB} and
+\hyperref[intro:V4L2 YUV]{planar YUV} formats documentation.
+
+\subsubsection{Supported stream parameters}
+\label{sec:Device Types / Video Device / Supported parameters / Supported stream parameters}
+
+The following stream parameters are defined:
+\begin{lstlisting}
+#define VIRTIO_VIDEO_PARAM_CODED_FORMAT       1
+#define VIRTIO_VIDEO_PARAM_RAW_FORMAT         2
+#define VIRTIO_VIDEO_PARAM_CODED_RESOURCES    3
+#define VIRTIO_VIDEO_PARAM_RAW_RESOURCES      4
+#define VIRTIO_VIDEO_PARAM_CROP               5
+#define VIRTIO_VIDEO_PARAM_BITRATE            6  /* Same as V4L2_CID_MPEG_VIDEO_BITRATE */
+#define VIRTIO_VIDEO_PARAM_GROUP_CODEC_MPEG2  7
+#define VIRTIO_VIDEO_PARAM_GROUP_CODEC_MPEG4  8
+#define VIRTIO_VIDEO_PARAM_GROUP_CODEC_H264   9
+#define VIRTIO_VIDEO_PARAM_GROUP_CODEC_HEVC   10
+#define VIRTIO_VIDEO_PARAM_GROUP_CODEC_VP8    11
+#define VIRTIO_VIDEO_PARAM_GROUP_CODEC_VP9    12
+\end{lstlisting}
+% TODO acourbot: See b/241492607 (fractional frame rates??)
+
+The above constants have two usages:
+\begin{enumerate}
+\item As bit numbers, used to tell the driver which stream parameters are
+supported by the device, see
+\ref{sec:Device Types / Video Device / Device Operation / Device Operation: Device Commands / VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS}.
+\item As values, used to designate the stream parameters when working with
+them, see
+\ref{sec:Device Types / Video Device / Device Operation / Device Operation: Stream commands / VIRTIO_VIDEO_CMD_STREAM_SET_PARAMS}.
+\end{enumerate}
+
+\subsection{Device Initialization}
+\label{sec:Device Types / Video Device / Device Initialization}
+
+\begin{enumerate}
+\def\labelenumi{\arabic{enumi}.}
+\item
+  The driver reads the feature bits and negotiates the features it needs.
+\item
+  The driver sets up the commandq.
+\item
+  The driver reads the \field{caps_length} field of the configuration
+  space and prepares a buffer of at least that size.
+\item
+  The driver sends that buffer on the commandq with the
+  VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS command.
+\item
+  The driver receives the response from the device, and parses its capabilities.
+\end{enumerate}
+
+\subsection{Device Operation}
+\label{sec:Device Types / Video Device / Device Operation}
+
+The commandq is used by the driver to send commands to the device and to
+receive the device's response via used buffers.
+
+The driver can create new streams using the
+VIRTIO_VIDEO_CMD_STREAM_CREATE command. Each stream has two resource
+queues (not to be confused with the virtio queues) called INPUT and
+OUTPUT, when the direction of the data flow matters. The INPUT queue accepts
+driver-filled input data for the device (coded data for a decoder;
+input frames for an encoder), while the OUTPUT queue receives resources to be
+filled by the device as a result of processing the INPUT queue (decoded raw
+frames for a decoder; encoded data for an encoder).
+
+These same queues can be also called CODED and RAW, when their content matters.
+The CODED queue is used to transfer compressed video data (INPUT for a decoder;
+OUTPUT for an encoder), while the RAW queue is used to transfer raw frames
+(OUTPUT for a decoder; INPUT for an encoder).
+
+The INPUT and OUTPUT queues are effectively independent, and the driver
+can fill them without caring about the other queue. In particular there
+is no need to queue input and output resources in pairs: one input
+resource can result in zero to many produced output resources.
+
+A resource is a set of memory buffers that contain a unit of data that
+the device can process or produce. Most resources will only have one
+buffer (like coded data and single-planar raw frames), but frames using a
+multi-planar format can have several.
+
+Parameters allow the driver to configure the stream for the decoding or
+encoding operation. The parameters can be obtained and configured using
+VIRTIO_VIDEO_CMD_STREAM_SET_PARAMS. Available parameters depend on
+the device type and are detailed in section
+\ref{sec:Device Types / Video Device / Supported parameters / Supported stream parameters}.
+
+Before resources can be submitted to a queue, backing memory must be
+attached to them using VIRTIO_VIDEO_CMD_RESOURCE_ATTACH_BACKING.
+The exact form of that memory is negotiated using the feature flags.
+
+In the case of a decoder device, the decoded frames are made available
+on the OUTPUT queue in presentation order.
+
+Resources are queued to the INPUT or OUTPUT queue using the
+VIRTIO_VIDEO_CMD_RESOURCE_QUEUE command. The device replies to this
+command when an input resource has been fully processed and can be
+reused by the driver, or when an output resource has been filled by the
+device as a result of processing.
+
+The device can detect stream-related events that require intervention
+from the driver and signals them on the eventq. One example is a dynamic
+resolution change while decoding a stream, which may require the driver
+to reallocate the backing memory of its output resources to fit the new
+resolution.
+
+\devicenormative{\subsubsection}{Device Operation}{Device Types / Video Device / Device Operation}
+
+Responses to a command MUST be written by the device in the first
+device-writable descriptor of the descriptor chain from which the
+command came.
+
+\drivernormative{\subsubsection}{Device Operation}{Device Types / Video Device / Device Operation}
+
+Descriptor chains sent to the commandq by the driver MUST include at
+least one device-writable descriptor of a size sufficient to receive the
+response to the queued command.
+
+\subsubsection{Device Operation: Command Virtqueue}
+\label{sec:Device Types / Video Device / Device Operation / Device Operation: Command Virtqueue}
+
+This section details the commands that can be sent on the commandq by
+the driver, as well as the responses that the device will write.
+
+Different structures are used for each command and response. A command
+structure starts with the requested command code, defined as follows:
+
+\begin{lstlisting}
+/* Device */
+#define VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS       0x100
+
+/* Stream */
+#define VIRTIO_VIDEO_CMD_STREAM_CREATE           0x200
+#define VIRTIO_VIDEO_CMD_STREAM_DESTROY          0x201
+#define VIRTIO_VIDEO_CMD_STREAM_SET_PARAMS       0x202
+#define VIRTIO_VIDEO_CMD_STREAM_DRAIN            0x203
+#define VIRTIO_VIDEO_CMD_STREAM_RESET            0x204
+
+/* Resource */
+#define VIRTIO_VIDEO_CMD_RESOURCE_ATTACH_BACKING 0x300
+#define VIRTIO_VIDEO_CMD_RESOURCE_QUEUE          0x301
+\end{lstlisting}
+
+A response structure starts with the result of the requested command,
+defined as follows:
+
+\begin{lstlisting}
+/* Success */
+#define VIRTIO_VIDEO_RESULT_OK                          0x000
+#define VIRTIO_VIDEO_RESULT_OK_ASYNC                    0x001
+
+/* Error */
+#define VIRTIO_VIDEO_RESULT_ERR_INVALID_COMMAND         0x100
+#define VIRTIO_VIDEO_RESULT_ERR_INVALID_OPERATION       0x101
+#define VIRTIO_VIDEO_RESULT_ERR_INVALID_STREAM_ID       0x102
+#define VIRTIO_VIDEO_RESULT_ERR_INVALID_RESOURCE_ID     0x103
+#define VIRTIO_VIDEO_RESULT_ERR_INVALID_ARGUMENT        0x104
+#define VIRTIO_VIDEO_RESULT_ERR_CANCELED                0x105
+#define VIRTIO_VIDEO_RESULT_ERR_OUT_OF_MEMORY           0x106
+\end{lstlisting}
+
+For response structures carrying an error code, the rest of the
+structure is considered invalid. Only response structures carrying
+VIRTIO_VIDEO_RESULT_OK shall be examined further by the driver.
+
+\devicenormative{\paragraph}{Device Operation: Command Virtqueue}{Device Types / Video Device / Device Operation / Device Operation: Command Virtqueue}
+
+The device MUST return VIRTIO_VIDEO_RESULT_ERR_INVALID_COMMAND to
+any command code it does not recognize.
+
+\drivernormative{\paragraph}{Device Operation: Command Virtqueue}{Device Types / Video Device / Device Operation / Device Operation: Command Virtqueue}
+
+The driver MUST NOT interpret the rest of a response whose result is not
+VIRTIO_VIDEO_RESULT_OK.
+
+\subsubsection{Device Operation: Device Commands}
+\label{sec:Device Types / Video Device / Device Operation / Device Operation: Device Commands}
+
+Device capabilities for all available stream parameters are retrieved using
+the VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS command.
+
+\paragraph{VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS}
+\label{sec:Device Types / Video Device / Device Operation / Device Operation: Device Commands / VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS}
+
+Retrieve device capabilities.
+
+The driver sends this command with
+\field{struct virtio_video_device_query_caps}:
+
+\begin{lstlisting}
+struct virtio_video_device_query_caps {
+        le32 cmd_type; /* VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS */
+};
+\end{lstlisting}
+
+The device responds with
+\field{struct virtio_video_device_query_caps_resp}:
+
+\begin{lstlisting}
+#define MASK(x) (1 << (x))
+
+struct virtio_video_device_query_caps_resp {
+        le32 result; /* VIRTIO_VIDEO_RESULT_* */
+        le32 stream_params_bitmask; /* Bitmask of MASK(VIRTIO_VIDEO_PARAM_*) */
+        le32 coded_formats_bitmask; /* Bitmaks of MASK(VIRTIO_VIDEO_CODED_FORMAT_*) */
+        le32 raw_formats_bitmask; /* Bitmask of MASK(VIRTIO_VIDEO_RAW_FORMAT_*) */
+        le32 num_format_deps;
+        le32 num_raw_format_caps;
+        le32 num_coded_resources_caps;
+        le32 num_raw_resources_caps;
+        le32 num_bitrate_caps; /* If MASK(VIRTIO_VIDEO_PARAM_BITRATE) is set. */
+        u8 padding[4];
+        /* If corresponding MASK(VIRTIO_VIDEO_PARAM_GROUP_CODEC_*) is set. */
+        struct virtio_video_mpeg2_caps mpeg2_caps;
+        struct virtio_video_mpeg4_caps mpeg4_caps;
+        struct virtio_video_h264_caps h264_caps;
+        struct virtio_video_hevc_caps hevc_caps;
+        struct virtio_video_vp8_caps vp8_caps;
+        struct virtio_video_vp9_caps vp9_caps;
+        /**
+         * Followed by
+         * struct virtio_video_format_dependency format_deps[num_format_deps];
+         */
+        /**
+         * Followed by
+         * struct virtio_video_raw_format_caps raw_format_caps[num_raw_format_caps];
+         */
+        /**
+         * Followed by
+         * struct virtio_video_coded_resources_caps
+         * coded_resources_caps[num_coded_resources_caps];
+         */
+        /**
+         * Followed by
+         * struct virtio_video_raw_resources_caps raw_resources_caps[num_raw_resources_caps];
+         */
+        /**
+         * Followed by if MASK(VIRTIO_VIDEO_PARAM_BITRATE) is set
+         * struct virtio_video_bitrate_caps bitrate_caps[num_bitrate_caps];
+         */
+};
+\end{lstlisting}
+
+\begin{description}
+\item[\field{result}]
+  is
+
+  \begin{description}
+  \item[VIRTIO_VIDEO_RESULT_OK]
+    if the operation succeeded,
+  \item[VIRTIO_VIDEO_RESULT_ERR_OUT_OF_MEMORY]
+    if the descriptor was smaller than the defined \field{caps_length} in
+    the video device configuration.
+  \end{description}
+\item[\field{stream_params_bitmask}]
+  is a bitmask of supported stream parameters.
+\item[\field{coded_formats_bitmask}]
+  is a bitmask of supported coded formats.
+\item[\field{raw_formats_bitmask}]
+  is a bitmask of supported raw formats.
+\item[\field{num_format_deps}]
+  is the number of elements in the format_deps array.
+\item[\field{num_raw_format_caps}]
+  is the number of elements in the raw_format_caps array.
+\item[\field{num_coded_resources_caps}]
+  is the number of elements in the coded_resources_caps array.
+\item[\field{num_raw_resources_caps}]
+  is the number of elements in the raw_resources_caps array.
+\item[\field{num_bitrate_caps}]
+  is the number of elements in the bitrate_caps array.
+\item[\field{mpeg2_caps}]
+  groups the capabilities of MPEG2 specific parameters.
+\item[\field{mpeg4_caps}]
+  groups the capabilities of MPEG4 specific parameters.
+\item[\field{h264_caps}]
+  groups the capabilities of H.264 specific parameters.
+\item[\field{hevc_caps}]
+  groups the capabilities of HEVC specific parameters.
+\item[\field{vp8_caps}]
+  groups the capabilities of VP8 specific parameters.
+\item[\field{vp9_caps}]
+  groups the capabilities of VP9 specific parameters.
+\item[\field{format_deps}]
+  is an array of size \field{num_format_deps} establishing dependencies
+  between coded and raw formats.
+\item[\field{raw_format_caps}]
+  is an array of size \field{num_raw_format_caps} containing the supported
+  raw formats capabilities.
+\item[\field{coded_resources_caps}]
+  is an array of size \field{num_coded_resources_caps}, that sets bounds for
+  the number of resources in the CODED queue.
+\item[\field{raw_resources_caps}]
+  is an array of size \field{num_raw_resources_caps}, that sets bounds for
+  the number of resources in the RAW queue.
+\item[\field{bitrate_caps}]
+  is an array of size \field{num_bitrate_caps} containing the supported
+  bitrates.
+\end{description}
+
+% TODO: V4L2 flow: 1. coded format without variants (maybe these flags
+% are relevant too: V4L2_FMT_FLAG_CONTINUOUS_BYTESTREAM?,
+% V4L2_FMT_FLAG_DYN_RESOLUTION?, V4L2_FMT_FLAG_ENC_CAP_FRAME_INTERVAL???),
+% also include variants (see VIDIOC_QUERYCTRL), then raw formats,
+% then resolutions (discrete or stepwise, see VIDIOC_ENUM_FRAMESIZES),
+% intervals are optional (see VIDIOC_ENUM_FRAMEINTERVALS)
+
+\devicenormative{\subparagraph}{VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS}{Device Types / Video Device / Device Operation / Device Operation: Device Commands / VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS}
+
+The device MUST support at least these parameters:
+VIRTIO_VIDEO_PARAM_CODED_FORMAT, VIRTIO_VIDEO_PARAM_RAW_FORMAT,
+VIRTIO_VIDEO_PARAM_CODED_RESOURCES, VIRTIO_VIDEO_PARAM_RAW_RESOURCES.
+
+The device MUST NOT mark codec-specific parameters
+(VIRTIO_VIDEO_PARAM_GROUP_CODEC_*) as supported unless the corresponding
+codecs are supported as well.
+
+The device MUST set to zero all fields with capabilities of unsupported
+parameters.
+
+The lengths \field{num_format_deps}, \field{num_raw_format_caps},
+\field{num_coded_resources_caps} and \field{num_raw_resources_caps} MUST be
+positive.
+
+The device MUST write the five \field{format_deps},
+\field{raw_format_caps}, \field{coded_resources_caps},
+\field{raw_resources_caps} and \field{bitrate_caps} arrays, of length
+\field{num_format_deps}, \field{num_raw_format_caps},
+\field{num_coded_resources_caps}, \field{num_raw_resources_caps} and
+\field{num_bitrate_caps}, respectively.
+
+For each coded format in the \field{coded_formats_bitmask} there MUST be
+at least one element of \field{format_deps} referencing it.
+
+For each raw format in the \field{raw_formats_bitmask} there MUST be
+at least one element of \field{format_deps} referencing it.
+
+For any coded and any raw format there MUST be at most one element of
+\field{format_deps} referencing both of them.
+
+Elements of \field{format_deps} SHOULD be ordered according to raw format
+preferences of the device from preferred to not preferred ones.
+
+For each raw format in the \field{raw_formats_bitmask} there MUST be
+exactly one element of \field{raw_format_caps} referencing it.
+
+For each coded format in the \field{coded_formats_bitmask} there MUST be
+exactly one element of \field{coded_resources_caps} referencing it.
+
+For each raw format in the \field{raw_formats_bitmask} there MUST be
+exactly one element of \field{raw_resources_caps} referencing it.
+
+If VIRTIO_VIDEO_PARAM_BITRATE is supported, then for each coded format in
+the \field{coded_formats_bitmask} there MUST be exactly one element of
+\field{bitrate_caps} referencing it.
+
+The total size of the response MUST be equal to \field{caps_length}
+bytes, as reported by the device configuration.
+
+\subparagraph{VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS: Format dependencies}
+
+The description of dependencies between coded and raw formats
+\field{virtio_video_format_dependency} is defined as follows:
+
+\begin{lstlisting}
+struct virtio_video_format_dependency {
+        le32 coded_formats_bitmask; /* Bitmask of MASK(VIRTIO_VIDEO_CODED_FORMAT_*) */
+        le32 raw_format; /* VIRTIO_VIDEO_RAW_FORMAT_* */
+};
+\end{lstlisting}
+
+\begin{description}
+\item[\field{coded_formats_bitmask}]
+  specifies coded formats, see
+  \ref{sec:Device Types / Video Device / Supported parameters / Supported coded formats}.
+  If a bit for a specific coded format is set, then this coded format can be
+  decoded into the specified raw format or encoded from it.
+\item[\field{raw_format}]
+  is a raw format, see
+  \ref{sec:Device Types / Video Device / Supported parameters / Supported raw formats}.
+\end{description}
+
+\devicenormative{\subparagraph}{VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS: Format dependencies}{Device Types / Video Device / Device Operation / Device Operation: Device Commands / VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS / VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS: Format dependencies}
+
+\field{coded_formats_bitmask} MUST be a subset of \field{coded_formats_bitmask}
+field of \field{struct virtio_video_device_query_caps_resp}.
+
+\field{coded_formats_bitmask} MUST specify at least one coded format.
+
+\field{raw_format} MUST be set to one of the supported raw formats according to
+the \field{raw_formats_bitmask} field of
+\field{struct virtio_video_device_query_caps_resp}.
+
+\subparagraph{VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS: Raw format capabilities}
+\label{sec:Device Types / Video Device / Device Operation / Device Operation: Device Commands / VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS / VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS: Raw format capabilities}
+
+The raw format capability description \field{virtio_video_raw_format_caps} is
+defined as follows:
+
+\begin{lstlisting}
+enum virtio_video_planes_layout {
+        VIRTIO_VIDEO_PLANES_LAYOUT_SINGLE_BUFFER = 1,
+        VIRTIO_VIDEO_PLANES_LAYOUT_MULTI_BUFFERS = 2,
+};
+
+struct virtio_video_range {
+        le32 min;
+        le32 max;
+        le32 step;
+        u8 padding[4];
+};
+
+struct virtio_video_raw_format_caps {
+        le32 raw_formats_bitmask; /* Bitmask of MASK(VIRTIO_VIDEO_RAW_FORMAT_*) */
+        le32 planes_layouts; /* Bitmask of VIRTIO_VIDEO_PLANES_LAYOUT_* */
+        le32 plane_align;
+        le32 stride_align_mask;
+        struct virtio_video_range width_range;
+        struct virtio_video_range height_range;
+};
+\end{lstlisting}
+
+\field{struct virtio_video_range} is used to represent a range of values.
+An integer \(x\) is within the range \field{r} if
+\(\field{r.min} \le x \le \field{r.max}\) holds and \(x\) equals to
+\((\field{min} + \field{step} * n)\) for some integer \(n\).
+
+\begin{description}
+\item[\field{raw_formats_bitmask}]
+  specifies raw formats, see
+  \ref{sec:Device Types / Video Device / Supported parameters / Supported raw formats},
+  to which these capabilities apply.
+\item[\field{planes_layouts}]
+  is a bitmask with the set of plane layout types from
+  \field{enum virtio_video_planes_layout}.
+\item[\field{plane_align}]
+  is the alignment of planes within a buffer in bytes. This field is valid
+  only if \field{planes_layouts} has the
+  \field{VIRTIO_VIDEO_PLANES_LAYOUT_SINGLE_BUFFER} bit set.
+\item[\field{stride_align_mask}]
+  is a mask of all supported power of two stride alignments.
+\item[\field{width_range}]
+  is a range of widths in pixels.
+\item[\field{height_range}]
+  is a range of heights in pixels.
+\end{description}
+
+\devicenormative{\subparagraph}{VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS: Raw format capabilities}{Device Types / Video Device / Device Operation / Device Operation: Device Commands / VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS / VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS: Raw format capabilities}
+
+\field{raw_formats_bitmask} MUST be a subset of \field{raw_formats_bitmask}
+field of \field{struct virtio_video_device_query_caps_resp}.
+
+\field{raw_formats_bitmask} MUST specify at least one raw format.
+
+The device MUST set \field{VIRTIO_VIDEO_PLANES_LAYOUT_SINGLE_BUFFER} bit in
+\field{planes_layouts} if the plane layout with planes of a frame laid out one
+after another in the same buffer is supported.
+
+The device MUST set \field{VIRTIO_VIDEO_PLANES_LAYOUT_MULTI_BUFFERS} bit in
+\field{planes_layouts} if the plane layout with planes of a frame laid out in
+separate buffers is supported.
+
+\field{plane_align} MUST be set to a power of two according to the device
+plane alignment requirements if \field{planes_layouts} has the
+\field{VIRTIO_VIDEO_PLANES_LAYOUT_SINGLE_BUFFER} bit set or to zero otherwise.
+
+\field{min}, \field{step} and \field{max} MUST be positive.
+
+\field{min} MUST be less then or equal to \field{max} within the same range.
+
+\subparagraph{VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS: Resource capabilities}
+
+The CODED resource capabilities \field{virtio_video_coded_resources_caps} is
+defined as follows:
+
+\begin{lstlisting}
+struct virtio_video_coded_resources_caps {
+        le32 coded_formats_bitmask; /* Bitmask of MASK(VIRTIO_VIDEO_CODED_FORMAT_*) */
+        le32 min_resources;
+        le32 max_resources;
+        le32 buffer_size;
+};
+\end{lstlisting}
+
+\begin{description}
+\item[\field{coded_formats_bitmask}]
+  specifies coded formats, see
+  \ref{sec:Device Types / Video Device / Supported parameters / Supported coded formats},
+  to which these capabilities apply.
+\item[\field{min_resources}]
+  is the minimum number of resources that the CODED queue supports for all
+  the specified coded formats.
+\item[\field{max_resources}]
+  is the maximum number of resources that the CODED queue supports for all
+  the specified coded formats.
+\item[\field{buffer_size}]
+  is the minimum size of the buffers that will back resources to be queued.
+\end{description}
+
+The RAW resource capabilities \field{virtio_video_raw_resources_caps} is
+defined as follows:
+
+\begin{lstlisting}
+struct virtio_video_raw_resources_caps {
+        le32 raw_formats_bitmask; /* Bitmask of MASK(VIRTIO_VIDEO_RAW_FORMAT_*) */
+        le32 min_resources;
+        le32 max_resources;
+        u8 padding[4];
+};
+\end{lstlisting}
+
+\begin{description}
+\item[\field{raw_formats_bitmask}]
+  specifies raw formats, see
+  \ref{sec:Device Types / Video Device / Supported parameters / Supported raw formats},
+  to which these capabilities apply.
+\item[\field{min_resources}]
+  is the minimum number of resources that the RAW queue supports for all
+  the specified raw formats.
+\item[\field{max_resources}]
+  is the maximum number of resources that the RAW queue supports for all
+  the specified raw formats.
+\end{description}
+
+\devicenormative{\subparagraph}{VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS: Resource capabilities}{Device Types / Video Device / Device Operation / Device Operation: Device Commands / VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS / VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS: Resource capabilities}
+
+\field{coded_formats_bitmask} MUST be a subset of \field{coded_formats_bitmask}
+field of \field{struct virtio_video_device_query_caps_resp}.
+
+\field{coded_formats_bitmask} MUST specify at least one coded format.
+
+\field{raw_formats_bitmask} MUST be a subset of \field{raw_formats_bitmask}
+field of \field{struct virtio_video_device_query_caps_resp}.
+
+\field{raw_formats_bitmask} MUST specify at least one raw format.
+
+\field{min_resources} MUST NOT be negative.
+
+\field{max_resources} MUST be greater then or equal to \field{min_resources}
+within the same struct instance.
+
+\subparagraph{VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS: Bitrates}
+
+The bitrate capabilities \field{virtio_video_bitrate_caps} is
+defined as follows:
+
+\begin{lstlisting}
+struct virtio_video_bitrate_caps {
+        le32 coded_formats_bitmask; /* Bitmask of MASK(VIRTIO_VIDEO_CODED_FORMAT_*) */
+        le32 min_bitrate;
+        le32 max_bitrate;
+        u8 padding[4];
+};
+\end{lstlisting}
+
+\begin{description}
+\item[\field{coded_formats_bitmask}]
+  specifies coded formats, see
+  \ref{sec:Device Types / Video Device / Supported parameters / Supported coded formats},
+  to which these capabilities apply.
+\item[\field{min_bitrate}]
+  is the minimum bitrate in bits per second supported by the encoder for all the specified coded
+  formats.
+\item[\field{max_bitrate}]
+  is the maximum bitrate in bits per second supported by the encoder for all the specified coded
+  formats.
+\end{description}
+
+\devicenormative{\subparagraph}{VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS: Bitrates}{Device Types / Video Device / Device Operation / Device Operation: Device Commands / VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS / VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS: Bitrates}
+
+\field{coded_formats_bitmask} MUST be a subset of \field{coded_formats_bitmask}
+field of \field{struct virtio_video_device_query_caps_resp}.
+
+\field{coded_formats_bitmask} MUST specify at least one coded format.
+
+\field{min_bitrate} MUST NOT be negative.
+
+\field{max_bitrate} MUST be greater then or equal to \field{min_bitrate}
+within the same \field{struct virtio_video_bitrate_caps} instance.
+
+\subsubsection{Device Operation: Stream commands}
+\label{sec:Device Types / Video Device / Device Operation / Device Operation: Stream commands}
+
+Stream commands allow the creation, destruction, and flow control of a
+stream.
+
+\paragraph{VIRTIO_VIDEO_CMD_STREAM_CREATE}
+\label{sec:Device Types / Video Device / Device Operation / Device Operation: Stream commands / VIRTIO_VIDEO_CMD_STREAM_CREATE}
+
+Create a new stream using the device.
+
+The driver sends this command with
+\field{struct virtio_video_stream_create}:
+
+\begin{lstlisting}
+struct virtio_video_stream_create {
+        le32 cmd_type; /* VIRTIO_VIDEO_CMD_STREAM_CREATE */
+};
+\end{lstlisting}
+
+The device responds with \field{struct virtio_video_stream_create_resp}:
+
+\begin{lstlisting}
+struct virtio_video_stream_create_resp {
+        le32 result; /* VIRTIO_VIDEO_RESULT_* */
+        le32 stream_id;
+};
+\end{lstlisting}
+
+\begin{description}
+\item[\field{result}]
+  is
+
+  \begin{description}
+  \item[VIRTIO_VIDEO_RESULT_OK]
+    if the operation succeeded,
+  \item[VIRTIO_VIDEO_RESULT_ERR_OUT_OF_MEMORY]
+    if the limit of simultaneous streams has been reached by the device and
+    no more can be created.
+  \item[VIRTIO_VIDEO_RESULT_ERR_INVALID_COMMAND]
+    if the stream cannot be created due to an unexpected device issue.
+  \end{description}
+\item[\field{stream_id}]
+  is the ID of the created stream allocated by the device.
+\end{description}
+
+\devicenormative{\subparagraph}{VIRTIO_VIDEO_CMD_STREAM_CREATE}{Device Types / Video Device / Device Operation / Device Operation: Stream commands / VIRTIO_VIDEO_CMD_STREAM_CREATE}
+
+\field{stream_id} MUST be set to a device-unique identifier that remains
+valid as long as the stream is alive.
+
+\paragraph{VIRTIO_VIDEO_CMD_STREAM_DESTROY}
+\label{sec:Device Types / Video Device / Device Operation / Device Operation: Stream commands / VIRTIO_VIDEO_CMD_STREAM_DESTROY}
+
+Destroy a video stream and all its resources. Any activity on the stream
+is halted and all resources released by the time the response is
+received by the driver.
+
+The driver sends this command with
+\field{struct virtio_video_stream_destroy}:
+
+\begin{lstlisting}
+struct virtio_video_stream_destroy {
+        le32 cmd_type; /* VIRTIO_VIDEO_CMD_STREAM_DESTROY */
+        le32 stream_id;
+};
+\end{lstlisting}
+
+\begin{description}
+\item[\field{stream_id}]
+  is the ID of the stream to be destroyed, as previously returned by
+  VIRTIO_VIDEO_CMD_STREAM_CREATE.
+\end{description}
+
+The device responds with
+\field{struct virtio_video_stream_destroy_resp}:
+
+\begin{lstlisting}
+struct virtio_video_stream_destroy_resp {
+        le32 result; /* VIRTIO_VIDEO_RESULT_* */
+};
+\end{lstlisting}
+
+\begin{description}
+\item[\field{result}]
+  is
+
+  \begin{description}
+  \item[VIRTIO_VIDEO_RESULT_OK]
+    if the operation succeeded,
+  \item[VIRTIO_VIDEO_RESULT_ERR_INVALID_STREAM_ID]
+    if the requested stream ID does not exist.
+  \end{description}
+\end{description}
+
+\devicenormative{\subparagraph}{VIRTIO_VIDEO_CMD_STREAM_DESTROY}{Device Types / Video Device / Device Operation / Device Operation: Stream commands / VIRTIO_VIDEO_CMD_STREAM_DESTROY}
+
+Before the device sends a response, it MUST respond with
+VIRTIO_VIDEO_RESULT_ERR_CANCELED to all pending commands.
+
+After responding to this command, the device MUST reply with
+VIRTIO_VIDEO_RESULT_ERR_INVALID_STREAM_ID to any command related
+to this stream ID.
+
+\drivernormative{\subparagraph}{VIRTIO_VIDEO_CMD_STREAM_DESTROY}{Device Types / Video Device / Device Operation / Device Operation: Stream commands / VIRTIO_VIDEO_CMD_STREAM_DESTROY}
+
+\field{stream_id} MUST be set to a valid stream ID previously returned
+by VIRTIO_VIDEO_CMD_STREAM_CREATE.
+
+The driver MUST stop using \field{stream_id} as a valid stream after it
+received the response to this command.
+
+\paragraph{VIRTIO_VIDEO_CMD_STREAM_SET_PARAMS}
+\label{sec:Device Types / Video Device / Device Operation / Device Operation: Stream commands / VIRTIO_VIDEO_CMD_STREAM_SET_PARAMS}
+
+Write values of selected parameters of a given stream, and return the values
+for all parameters supported by the device as reported by
+\ref{sec:Device Types / Video Device / Device Operation / Device Operation: Device Commands / VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS}.
+
+The driver sends this command with
+\field{struct virtio_video_stream_set_params}:
+
+\begin{lstlisting}
+struct virtio_video_stream_set_params {
+        le32 cmd_type; /* VIRTIO_VIDEO_CMD_STREAM_SET_PARAMS */
+        le32 stream_id;
+        struct virtio_video_params params;
+};
+\end{lstlisting}
+
+\begin{description}
+\item[\field{stream_id}]
+  is the ID of the stream we want to set a parameter for.
+\item[\field{params}]
+  is a container for the selected stream parameters to be set.
+\end{description}
+
+The device responds with \field{struct virtio_video_stream_set_params_resp}:
+
+\begin{lstlisting}
+struct virtio_video_stream_set_params_resp {
+        le32 result; /* VIRTIO_VIDEO_RESULT_* */
+        u8 padding[4];
+        struct virtio_video_params params;
+};
+\end{lstlisting}
+
+\begin{description}
+\item[\field{result}]
+  is
+
+  \begin{description}
+  \item[VIRTIO_VIDEO_RESULT_OK]
+    if the operation succeeded,
+  \item[VIRTIO_VIDEO_RESULT_ERR_INVALID_STREAM_ID]
+    if the requested stream does not exist,
+  \item[VIRTIO_VIDEO_RESULT_ERR_INVALID_ARGUMENT]
+    if the \field{param_type} argument is invalid for the device,
+  \item[VIRTIO_VIDEO_RESULT_ERR_INVALID_OPERATION]
+    if the requested parameter cannot be modified at this moment.
+  \end{description}
+\item[\field{params}]
+  is a container for the actual values of all the parameters supported by the
+  device, if \field{result} is VIRTIO_VIDEO_RESULT_OK. The values set by the
+  device may differ from the requested values depending on the device's
+  capabilities.
+\end{description}
+
+Outside of the error cases described above, setting a parameter does not
+fail. If the device cannot apply the parameter as requested, it will
+adjust it to the closest setting it supports, and return that value to
+the driver. It is then up to the driver to decide whether it can work
+within the range of parameters supported by the device.
+
+The \field{struct virtio_video_params} is defined as follows:
+
+\begin{lstlisting}
+struct virtio_video_raw_format {
+        le32 format;
+        le32 planes_layout; /* VIRTIO_VIDEO_PLANES_LAYOUT_* */
+        le32 stride;
+        le32 width;
+        le32 height;
+        u8 padding[4];
+};
+
+struct virtio_video_param_crop {
+        le32 left;
+        le32 top;
+        le32 width;
+        le32 height;
+};
+
+union virtio_video_codec_params {
+        struct virtio_video_mpeg2_params mpeg2;
+        struct virtio_video_mpeg4_params mpeg4;
+        struct virtio_video_h264_params h264;
+        struct virtio_video_hevc_params hevc;
+        struct virtio_video_vp8_params vp8;
+        struct virtio_video_vp9_params vp9;
+};
+
+struct virtio_video_params {
+        le32 stream_params_bitmask; /* Bitmask of MASK(VIRTIO_VIDEO_PARAM_*) */
+        le32 coded_format; /* If MASK(VIRTIO_VIDEO_PARAM_CODED_FORMAT) is set. */
+        /* If MASK(VIRTIO_VIDEO_PARAM_RAW_FORMAT) is set. */
+        struct virtio_video_raw_format raw_format;
+        /* If MASK(VIRTIO_VIDEO_PARAM_CODED_RESOURCES) is set. */
+        struct virtio_video_param_resources coded_resources;
+        /* If MASK(VIRTIO_VIDEO_PARAM_RAW_RESOURCES) is set. */
+        struct virtio_video_param_resources raw_resources;
+        struct virtio_video_param_crop crop; /* If MASK(VIRTIO_VIDEO_PARAM_CROP) is set. */
+        le32 bitrate; /* If MASK(VIRTIO_VIDEO_PARAM_BITRATE) is set. */
+        u8 padding[4];
+        /* If the corresponding MASK(VIRTIO_VIDEO_PARAM_GROUP_CODEC_*) is set
+        * depending on the coded_format. */
+        union virtio_video_codec_params codec;
+};
+\end{lstlisting}
+
+\begin{description}
+\item[\field{stream_params_bitmask}]
+  is a bitmask of supported stream parameters.
+\item[\field{coded_format}]
+  is a coded format of the CODED queue, see
+  \ref{sec:Device Types / Video Device / Supported parameters}.
+\item[\field{raw_format}]
+  is a raw format of the RAW queue including related parameters
+
+  \begin{description}
+  \item[\field{format}]
+    is the actual format, see
+    \ref{sec:Device Types / Video Device / Supported parameters / Supported raw formats}.
+  \item[\field{planes_layout}]
+    is the actual layout of the planes, see
+    \ref{sec:Device Types / Video Device / Device Operation / Device Operation: Device Commands / VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS / VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS: Raw format capabilities}.
+  \item[\field{stride}]
+    is the distance in bytes between two lines of data.
+  \item[\field{width}]
+    is the width in pixels of the stream frames.
+  \item[\field{height}]
+    is the height in pixels of the stream frames.
+  \end{description}
+\item[\field{coded_resources}]
+  is the CODED queue resources parameters, see
+  \ref{sec:Device Types / Video Device / Device Operation / Device Operation: Stream commands / VIRTIO_VIDEO_CMD_STREAM_SET_PARAMS / VIRTIO_VIDEO_CMD_STREAM_SET_PARAMS: Resources}.
+\item[\field{raw_resources}]
+  is the RAW queue resources parameters, see
+  \ref{sec:Device Types / Video Device / Device Operation / Device Operation: Stream commands / VIRTIO_VIDEO_CMD_STREAM_SET_PARAMS / VIRTIO_VIDEO_CMD_STREAM_SET_PARAMS: Resources}.
+\item[\field{crop}]
+  is the rectangle covering the visible size of the frame, i.e the part of
+  the frame that should be displayed, \field{width} and \field{height} are
+  relative to \field{left} and \field{top}.
+\item[\field{bitrate}]
+  is the current desired bitrate for the encoder. This can be changed at
+  any moment by the driver and will apply to subsequently submitted frames.
+\item[\field{codec}]
+  consists of codec-specific parameters, see
+  \ref{sec:Device Types / Video Device / Codec-specific parameters} for the
+  definitions. Not available until \field{coded_format} is set.
+\end{description}
+
+\devicenormative{\subparagraph}{VIRTIO_VIDEO_CMD_STREAM_SET_PARAMS}{Device Types / Video Device / Device Operation / Device Operation: Stream commands / VIRTIO_VIDEO_CMD_STREAM_SET_PARAMS}
+
+The device MUST initialize each parameter to a valid default value.
+
+The device MUST allow each parameter to be read even without the driver
+explicitly setting a value for them beforehand.
+
+The device MAY adjust any requested parameter to a closest supported
+value if the requested one is not supported with the current settings.
+
+\field{stream_params_bitmask} MUST be a subset of \field{stream_params_bitmask}
+field of \field{struct virtio_video_device_query_caps_resp}.
+
+The fields \field{coded_format}, \field{raw_format}, \field{coded_resources},
+\field{raw_resources}, \field{bitrate}, \field{codec} MUST be set according
+to the capabilities returned by VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS, see
+\ref{sec:Device Types / Video Device / Device Operation / Device Operation: Device Commands / VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS}.
+
+\field{stream_params_bitmask} MAY contain at most one of
+VIRTIO_VIDEO_PARAM_GROUP_CODEC_* bits. This bit MUST correspond to the
+coded format selected with \field{coded_format}.
+
+The parameters MUST be applied in the same order as in
+\ref{sec:Device Types / Video Device / Supported parameters / Supported stream parameters}.
+
+The device MUST return all the available parameters in response to the
+command. \field{codec} is not available until \field{coded_format} is set.
+
+% TODO define when changing these parameters is allowed.
+
+\drivernormative{\subparagraph}{VIRTIO_VIDEO_CMD_STREAM_SET_PARAMS}{Device Types / Video Device / Device Operation / Device Operation: Stream commands / VIRTIO_VIDEO_CMD_STREAM_SET_PARAMS}
+
+\field{stream_id} MUST be set to a valid stream ID previously returned
+by VIRTIO_VIDEO_CMD_STREAM_CREATE.
+
+The driver MUST fill the fields according to the parameters selected with
+\field{stream_params_bitmask}. All the other fields MUST be set to zero.
+
+The driver MUST check the actual values of the parameters as set by the
+device and work with these values, or try to set a different one if it
+cannot, or fail properly.
+
+After creating a new stream, the initial value of all parameters is
+undefined to the driver. Thus, the driver MUST NOT assume the default
+value of any parameter and MAY use VIRTIO_VIDEO_CMD_STREAM_SET_PARAMS
+in order to get the values of the parameters it needs.
+
+% TODO acourbot: for the decoder, resolution can be set manually by the driver
+% (useful for codecs that do not embed this information). When this is done,
+% an implicit drain is triggered and the reply to the SET_CONTROL command is
+% only sent after the drain is completed by the device. Upon receiving the
+% reply from the SET_CONTROL, the driver can reallocate the output buffers
+% and attach their backing memory.
+
+\subparagraph{VIRTIO_VIDEO_CMD_STREAM_SET_PARAMS: Resources}
+\label{sec:Device Types / Video Device / Device Operation / Device Operation: Stream commands / VIRTIO_VIDEO_CMD_STREAM_SET_PARAMS / VIRTIO_VIDEO_CMD_STREAM_SET_PARAMS: Resources}
+
+\field{struct virtio_video_param_resources} is used to control the
+number of resources and their backing memory type for the INPUT and
+OUTPUT queues:
+
+\begin{lstlisting}
+#define VIRTIO_VIDEO_MEM_TYPE_GUEST_PAGES       0x1
+#define VIRTIO_VIDEO_MEM_TYPE_VIRTIO_OBJECT     0x2
+
+struct virtio_video_param_resources {
+        le32 num_resources;
+        u8 mem_type; /* VIRTIO_VIDEO_MEM_TYPE_* */
+        u8 padding[3];
+};
+\end{lstlisting}
+
+\begin{description}
+\item[\field{num_resources}]
+  is the number of resources that can be addressed for the queue, numbered
+  from \(0\) to \(num\_resources - 1\). Can be equal to zero if no
+  resources are allocated, otherwise will be comprised between
+  \field{min_resources} and \field{max_resources}.
+\item[\field{mem_type}]
+  is the memory type that will be used to back these resources.
+\end{description}
+
+Successfully setting this parameter results in all currently attached
+resources of the corresponding queue to become detached, i.e. the driver
+cannot queue a resource to the queue without attaching some backing
+memory first. All currently queued resources for the queue are returned
+with the VIRTIO_VIDEO_RESULT_ERR_CANCELED error before the response
+to the VIRTIO_VIDEO_CMD_STREAM_SET_PARAMS is returned.
+
+This parameter can only be changed during the following times:
+
+\begin{itemize}
+\item
+  After creating a stream and before queuing any resource on a given
+  queue,
+\item
+  For the INPUT queue, after receiving the response to a
+  VIRTIO_VIDEO_CMD_STREAM_RESET and before queueing any input
+  resource,
+\item
+  For the OUTPUT queue, after receiving a DRC event and before queueing
+  any output resource.
+\end{itemize}
+
+Attempts to change this parameter outside of these times will result in
+VIRTIO_VIDEO_RESULT_ERR_INVALID_OPERATION to be returned.
+
+\paragraph{VIRTIO_VIDEO_CMD_STREAM_DRAIN}
+\label{sec:Device Types / Video Device / Device Operation / Device Operation: Stream commands / VIRTIO_VIDEO_CMD_STREAM_DRAIN}
+
+Complete processing of all currently queued input resources.
+
+VIRTIO_VIDEO_CMD_STREAM_DRAIN ensures that all sent
+VIRTIO_VIDEO_CMD_RESOURCE_QUEUE commands on the INPUT queue are
+processed by the device and that the resulting output resources are
+available to the driver.
+
+The driver sends this command with
+\field{struct virtio_video_stream_drain}:
+
+\begin{lstlisting}
+struct virtio_video_stream_drain {
+        le32 cmd_type; /* VIRTIO_VIDEO_CMD_STREAM_DRAIN */
+        le32 stream_id;
+};
+\end{lstlisting}
+
+\begin{description}
+\item[\field{stream_id}]
+  is the ID of the stream to drain, as previously returned by
+  VIRTIO_VIDEO_CMD_STREAM_CREATE.
+\end{description}
+
+The device responds with \field{struct virtio_video_stream_drain_resp}
+once the drain operation is completed:
+
+\begin{lstlisting}
+struct virtio_video_stream_drain_resp {
+        le32 result; /* VIRTIO_VIDEO_RESULT_* */
+};
+\end{lstlisting}
+
+\begin{description}
+\item[\field{result}]
+  is
+
+  \begin{description}
+  \item[VIRTIO_VIDEO_RESULT_OK]
+    if the operation succeeded,
+  \item[VIRTIO_VIDEO_RESULT_ERR_INVALID_STREAM_ID]
+    if the requested stream does not exist,
+  \item[VIRTIO_VIDEO_RESULT_ERR_INVALID_OPERATION]
+    if a drain operation is already in progress for this stream,
+  \item[VIRTIO_VIDEO_RESULT_ERR_CANCELED]
+    if the operation has been canceled by a
+    VIRTIO_VIDEO_CMD_STREAM_RESET or VIRTIO_VIDEO_CMD_STREAM_DESTROY
+    command.
+  \end{description}
+\end{description}
+
+\devicenormative{\subparagraph}{VIRTIO_VIDEO_CMD_STREAM_DRAIN}{Device Types / Video Device / Device Operation / Device Operation: Stream commands / VIRTIO_VIDEO_CMD_STREAM_DRAIN}
+
+Before the device sends the response, it MUST process and respond to all
+the VIRTIO_VIDEO_CMD_RESOURCE_QUEUE commands on the INPUT queue that
+were sent before the drain command, and make all the corresponding
+output resources available to the driver by responding to their
+VIRTIO_VIDEO_CMD_RESOURCE_QUEUE command.
+
+The device MUST be able to accept input work while a drain is ongoing,
+but the output of this work MUST NOT be made available before the
+response to the drain command.
+
+While the device is processing the command, it MUST return
+VIRTIO_VIDEO_RESULT_ERR_INVALID_OPERATION to the
+VIRTIO_VIDEO_CMD_STREAM_DRAIN command.
+
+If the command is interrupted due to a VIRTIO_VIDEO_CMD_STREAM_RESET
+or VIRTIO_VIDEO_CMD_STREAM_DESTROY operation, the device MUST
+respond with VIRTIO_VIDEO_RESULT_ERR_CANCELED.
+
+\drivernormative{\subparagraph}{VIRTIO_VIDEO_CMD_STREAM_DRAIN}{Device Types / Video Device / Device Operation / Device Operation: Stream commands / VIRTIO_VIDEO_CMD_STREAM_DRAIN}
+
+\field{stream_id} MUST be set to a valid stream ID previously returned
+by VIRTIO_VIDEO_CMD_STREAM_CREATE.
+
+The driver MUST keep queueing output resources until it gets the
+response to this command or cancels it using
+VIRTIO_VIDEO_CMD_STREAM_RESET or
+VIRTIO_VIDEO_CMD_STREAM_DESTROY. Failure to do so may result in the
+device stalling as it waits for output resources to write into.
+
+The driver MUST account for the fact that the response to this command
+might come out-of-order (i.e. after other commands sent to the device),
+and that it can be interrupted.
+
+The driver MUST send a DRAIN command when it does not have any further
+input, in order to ensure it receives all the output corresponding to
+the stream.
+
+\paragraph{VIRTIO_VIDEO_CMD_STREAM_RESET}
+\label{sec:Device Types / Video Device / Device Operation / Device Operation: Stream commands / VIRTIO_VIDEO_CMD_STREAM_RESET}
+
+Immediately return all queued input resources without processing them
+and stop operation until new input resources are queued.
+
+This command is mostly useful for decoders that need to quickly jump
+from one point of the stream to another (i.e. seeking), or in order to
+stop processing as quickly as possible.
+
+The driver sends this command with
+\field{struct virtio_video_stream_reset}:
+
+\begin{lstlisting}
+struct virtio_video_stream_reset {
+        le32 cmd_type; /* VIRTIO_VIDEO_CMD_STREAM_RESET */
+        le32 stream_id;
+};
+\end{lstlisting}
+
+\begin{description}
+\item[\field{stream_id}]
+  is the ID of the stream to reset, as previously returned by
+  VIRTIO_VIDEO_CMD_STREAM_CREATE.
+\end{description}
+
+The device responds with \field{struct virtio_video_stream_reset_resp}
+after the response for all previously queued input resources has been
+sent:
+
+\begin{lstlisting}
+struct virtio_video_stream_reset_resp {
+        le32 result; /* VIRTIO_VIDEO_RESULT_* */
+};
+\end{lstlisting}
+
+\begin{description}
+\item[\field{result}]
+  is
+
+  \begin{description}
+  \item[VIRTIO_VIDEO_RESULT_OK]
+    if the operation succeeded,
+  \item[VIRTIO_VIDEO_RESULT_ERR_INVALID_STREAM_ID]
+    if the requested stream does not exist,
+  \end{description}
+\end{description}
+
+\devicenormative{\subparagraph}{VIRTIO_VIDEO_CMD_STREAM_RESET}{Device Types / Video Device / Device Operation / Device Operation: Stream commands / VIRTIO_VIDEO_CMD_STREAM_RESET}
+
+The device MUST return VIRTIO_VIDEO_RESULT_ERR_CANCELED to any
+pending VIRTIO_VIDEO_CMD_STREAM_DRAIN and
+VIRTIO_VIDEO_CMD_RESOURCE_QUEUE command on the INPUT queue before
+responding to this command. Pending commands on the output queue are not
+affected.
+
+The device MUST interrupt operation as quickly as possible, and not be
+dependent on output resources being queued by the driver.
+
+Upon resuming processing, the device MAY skip input data until it finds
+a point that allows it to resume operation properly (e.g. until a
+keyframe is found in the input stream of a decoder).
+
+\drivernormative{\subparagraph}{VIRTIO_VIDEO_CMD_STREAM_RESET}{Device Types / Video Device / Device Operation / Device Operation: Stream commands / VIRTIO_VIDEO_CMD_STREAM_RESET}
+
+\field{stream_id} MUST be set to a valid stream ID previously returned
+by VIRTIO_VIDEO_CMD_STREAM_CREATE.
+
+Upon receiving the response to this command, the driver SHOULD process
+(or drop) any output resource before resuming operation by queueing new
+input resources.
+
+Upon receiving the response to this command, the driver MAY modify the
+\field{struct virtio_video_param_resources} parameter corresponding to
+the INPUT queue, and subsequently attach new backing memory to the input
+resources using the VIRTIO_VIDEO_CMD_RESOURCE_ATTACH_BACKING
+command.
+
+\subsubsection{Device Operation: Resource Commands}
+\label{sec:Device Types / Video Device / Device Operation / Device Operation: Resource Commands}
+
+Resource commands manage the memory backing of individual resources and
+queue them for the device to process.
+
+\paragraph{VIRTIO_VIDEO_CMD_RESOURCE_ATTACH_BACKING}
+\label{sec:Device Types / Video Device / Device Operation / Device Operation: Resource Commands / VIRTIO_VIDEO_CMD_RESOURCE_ATTACH_BACKING}
+
+Attach backing memory to a resource.
+
+The driver sends this command with
+\field{struct virtio_video_resource_attach_backing}:
+
+\begin{lstlisting}
+#define VIRTIO_VIDEO_QUEUE_TYPE_INPUT       0
+#define VIRTIO_VIDEO_QUEUE_TYPE_OUTPUT      1
+
+struct virtio_video_resource_attach_backing {
+        le32 cmd_type; /* VIRTIO_VIDEO_CMD_RESOURCE_ATTACH_BACKING */
+        le32 stream_id;
+        le32 queue_type; /* VIRTIO_VIDEO_QUEUE_TYPE_* */
+        le32 resource_id;
+        union virtio_video_resource resources[];
+};
+\end{lstlisting}
+
+\begin{description}
+\item[\field{stream_id}]
+  is the ID of a valid stream.
+\item[\field{queue_type}]
+  is the direction of the queue.
+\item[\field{resource_id}]
+  is the ID of the resource to be attached to.
+\item[\field{resources}]
+  specifies memory regions to attach.
+\end{description}
+
+The union \field{virtio_video_resource} is defined as follows:
+
+\begin{lstlisting}
+union virtio_video_resource {
+        struct virtio_video_resource_sg_list sg_list;
+        struct virtio_video_resource_object object;
+};
+\end{lstlisting}
+
+\begin{description}
+\item[\field{sg_list}]
+  represents a scatter-gather list. This variant can be used when the
+  \field{mem_type} member of the \field{virtio_video_param_resources}
+  corresponding to the queue is set to
+  VIRTIO_VIDEO_MEM_TYPE_GUEST_PAGES, see
+  \ref{sec:Device Types / Video Device / Device Operation / Device Operation: Stream commands / VIRTIO_VIDEO_CMD_STREAM_SET_PARAMS / VIRTIO_VIDEO_CMD_STREAM_SET_PARAMS: Resources}.
+\item[\field{object}]
+  represents an object exported from another virtio device as defined in
+  \ref{sec:Basic Facilities of a Virtio Device / Exporting Objects}.
+  This variant can be used when the \field{mem_type} member of the
+  \field{virtio_video_param_resources} corresponding to the queue is set
+  to VIRTIO_VIDEO_MEM_TYPE_VIRTIO_OBJECT, see
+  \ref{sec:Device Types / Video Device / Device Operation / Device Operation: Stream commands / VIRTIO_VIDEO_CMD_STREAM_SET_PARAMS / VIRTIO_VIDEO_CMD_STREAM_SET_PARAMS: Resources}.
+\end{description}
+
+The struct \field{virtio_video_resource_sg_list} is defined as follows:
+
+\begin{lstlisting}
+struct virtio_video_resource_sg_entry {
+        le64 addr;
+        le32 length;
+        u8 padding[4];
+};
+
+struct virtio_video_resource_sg_list {
+        le32 num_entries;
+        u8 padding[4];
+        /* Followed by num_entries instances of
+           virtio_video_resource_sg_entry */
+};
+\end{lstlisting}
+
+Within \field{struct virtio_video_resource_sg_entry}:
+
+\begin{description}
+\item[\field{addr}]
+  is a guest physical address to the start of the SG entry. Must be
+  aligned to the size of physical guest pages.
+\item[\field{length}]
+  is the length of the SG entry in bytes. Must be aligned to the size
+  of physical guest pages.
+\end{description}
+
+Finally, for \field{struct virtio_video_resource_sg_list}:
+
+\begin{description}
+\item[\field{num_entries}]
+  is the number of \field{struct virtio_video_resource_sg_entry} instances
+  that follow.
+\end{description}
+
+\field{struct virtio_video_resource_object} is defined as follows:
+
+\begin{lstlisting}
+struct virtio_video_resource_object {
+        u8 uuid[16];
+};
+\end{lstlisting}
+
+\begin{description}
+\item[uuid]
+  is a version 4 UUID specified by \hyperref[intro:rfc4122]{[RFC4122]}.
+\end{description}
+
+The device responds with
+\field{struct virtio_video_resource_attach_backing_resp}:
+
+\begin{lstlisting}
+struct virtio_video_resource_attach_backing_resp {
+        le32 result; /* VIRTIO_VIDEO_RESULT_* */
+};
+\end{lstlisting}
+
+\begin{description}
+\item[\field{result}]
+  is
+
+  \begin{description}
+  \item[VIRTIO_VIDEO_RESULT_OK]
+    if the operation succeeded,
+  \item[VIRTIO_VIDEO_RESULT_ERR_INVALID_STREAM_ID]
+    if the mentioned stream does not exist,
+  \item[VIRTIO_VIDEO_RESULT_ERR_INVALID_ARGUMENT]
+    if \field{queue_type}, \field{resource_id}, or \field{resources} have an
+    invalid value,
+  \item[VIRTIO_VIDEO_RESULT_ERR_INVALID_OPERATION]
+    if the operation is performed at a time when it is non-valid.
+  \end{description}
+\end{description}
+
+VIRTIO_VIDEO_CMD_RESOURCE_ATTACH_BACKING can only be called during
+the following times:
+
+\begin{itemize}
+\item
+  AFTER a VIRTIO_VIDEO_CMD_STREAM_CREATE and BEFORE invoking
+  VIRTIO_VIDEO_CMD_RESOURCE_QUEUE for the first time on the
+  resource,
+\item
+  AFTER successfully changing the \field{virtio_video_param_resources}
+  parameter corresponding to the queue and BEFORE
+  VIRTIO_VIDEO_CMD_RESOURCE_QUEUE is called again on the resource.
+\end{itemize}
+
+This is to ensure that the device can rely on the fact that a given
+resource will always point to the same memory for as long as it may be
+used by the video device. For instance, a decoder may use returned
+decoded frames as reference for future frames and won't overwrite the
+backing resource of a frame that is being referenced. It is only before
+a stream is started and after a Dynamic Resolution Change event has
+occurred that we can be sure that all resources won't be used in that
+way.
+
+% TODO add a requirement for the driver or the device to handle a case
+% when a still referenced frame is queued again. So that it is less likely
+% to be forgotten.
+
+\devicenormative{\subparagraph}{VIRTIO_VIDEO_CMD_RESOURCE_ATTACH_BACKING}{Device Types / Video Device / Device Operation / Device Operation: Resource Commands / VIRTIO_VIDEO_CMD_RESOURCE_ATTACH_BACKING}
+
+At any time other than the times valid for calling this command, the
+device MUST return VIRTIO_VIDEO_RESULT_ERR_INVALID_OPERATION.
+
+\drivernormative{\subparagraph}{VIRTIO_VIDEO_CMD_RESOURCE_ATTACH_BACKING}{Device Types / Video Device / Device Operation / Device Operation: Resource Commands / VIRTIO_VIDEO_CMD_RESOURCE_ATTACH_BACKING}
+
+\field{stream_id} MUST be set to a valid stream ID previously returned
+by VIRTIO_VIDEO_CMD_STREAM_CREATE.
+
+\field{queue_type} MUST be set to a valid queue type.
+
+\field{resource_id} MUST be an integer inferior to the number of
+resources currently allocated for the queue.
+
+The length of the \field{resources} array of
+\field{struct virtio_video_resource_attach_backing} MUST be equal to the
+number of resources required by the format currently set on the queue,
+as described in
+\ref{sec:Device Types / Video Device / Device Operation / Device Operation: Stream commands / VIRTIO_VIDEO_CMD_STREAM_SET_PARAMS}.
+
+\paragraph{VIRTIO_VIDEO_CMD_RESOURCE_QUEUE}
+\label{sec:Device Types / Video Device / Device Operation / Device Operation: Resource Commands / VIRTIO_VIDEO_CMD_RESOURCE_QUEUE}
+
+Add a resource to the device's queue.
+
+\begin{lstlisting}
+#define VIRTIO_VIDEO_MAX_PLANES                    8
+
+#define VIRTIO_VIDEO_ENQUEUE_FLAG_FORCE_KEY_FRAME  (1 << 0)
+
+struct virtio_video_resource_queue {
+        le32 cmd_type; /* VIRTIO_VIDEO_CMD_RESOURCE_QUEUE */
+        le32 stream_id;
+        le32 queue_type; /* VIRTIO_VIDEO_QUEUE_TYPE_* */
+        le32 resource_id;
+        le32 flags; /* Bitmask of VIRTIO_VIDEO_ENQUEUE_FLAG_* */
+        u8 padding[4];
+        le64 timestamp;
+        le32 offsets[VIRTIO_VIDEO_MAX_PLANES];
+        le32 data_sizes[VIRTIO_VIDEO_MAX_PLANES];
+};
+\end{lstlisting}
+
+\begin{description}
+\item[\field{stream_id}]
+  is the ID of a valid stream.
+\item[\field{queue_type}]
+  is the direction of the queue.
+\item[\field{resource_id}]
+  is the ID of the resource to be queued.
+\item[\field{flags}]
+  is a bitmask of VIRTIO_VIDEO_ENQUEUE_FLAG_* values.
+
+  \begin{description}
+  \item[\field{VIRTIO_VIDEO_ENQUEUE_FLAG_FORCE_KEY_FRAME}]
+    The submitted frame is to be encoded as a key frame. Only valid for the
+    encoder's INPUT queue.
+  \end{description}
+\item[\field{timestamp}]
+  is an abstract sequence counter that can be used on the INPUT queue for
+  synchronization. Resources produced on the output queue will carry the
+  \field{timestamp} of the first input resource they have been produced
+  from.
+% TODO take note about timestamps from V4L2 spec
+\item[\field{offsets}]
+  is the starting offset for the data in the buffer for each plane.
+  The number of planes depends on the format. Set by the driver for input
+  resources.
+\item[\field{data_sizes}]
+  is number of data bytes used for each plane. Set by the driver for input
+  resources.
+\end{description}
+
+The device responds with
+\field{struct virtio_video_resource_queue_resp}:
+
+\begin{lstlisting}
+#define VIRTIO_VIDEO_DEQUEUE_FLAG_ERR           (1 << 0)
+/* Encoder only */
+#define VIRTIO_VIDEO_DEQUEUE_FLAG_KEY_FRAME     (1 << 1)
+#define VIRTIO_VIDEO_DEQUEUE_FLAG_P_FRAME       (1 << 2)
+#define VIRTIO_VIDEO_DEQUEUE_FLAG_B_FRAME       (1 << 3)
+
+struct virtio_video_resource_queue_resp {
+        le32 result;
+        le32 flags;
+        le64 timestamp;
+        le32 offsets[VIRTIO_VIDEO_MAX_PLANES];
+        le32 data_sizes[VIRTIO_VIDEO_MAX_PLANES];
+};
+\end{lstlisting}
+
+\begin{description}
+\item[\field{result}]
+  is
+
+  \begin{description}
+  \item[VIRTIO_VIDEO_RESULT_OK]
+    if the operation succeeded,
+  \item[VIRTIO_VIDEO_RESULT_ERR_INVALID_STREAM_ID]
+    if the requested stream does not exist,
+  \item[VIRTIO_VIDEO_RESULT_ERR_INVALID_ARGUMENT]
+    if the \field{queue_type}, \field{resource_id} or \field{flags}
+    parameters have an invalid value,
+  \item[VIRTIO_VIDEO_RESULT_ERR_INVALID_OPERATION]
+    if VIRTIO_VIDEO_CMD_RESOURCE_ATTACH_BACKING has not been
+    successfully called on the resource prior to queueing it.
+  \item[VIRTIO_VIDEO_RESULT_ERR_CANCELED]
+    if the resource has not been processed, not because of an error but
+    because of a change in the state of the codec. The driver is expected to
+    take action and address the condition before submitting the resource
+    again.
+  \end{description}
+\item[\field{flags}]
+  is a bitmask of VIRTIO_VIDEO_DEQUEUE_FLAG_* flags.
+
+  \begin{description}
+  \item[VIRTIO_VIDEO_DEQUEUE_FLAG_ERR]
+    is set on output resources when a non-fatal processing error has
+    happened and the data contained by the resource is likely to be
+    corrupted,
+  \item[VIRTIO_VIDEO_DEQUEUE_FLAG_KEY_FRAME]
+    is set on output resources when the resource contains an encoded key
+    frame (only for encoders).
+  \item[VIRTIO_VIDEO_DEQUEUE_FLAG_P_FRAME]
+    is set on output resources when the resource contains only differences
+    to a previous key frame (only for encoders).
+  \item[VIRTIO_VIDEO_DEQUEUE_FLAG_B_FRAME]
+    is set on output resources when the resource contains only the
+    differences between the current frame and both the preceding and
+    following key frames (only for encoders).
+  \end{description}
+\item[\field{timestamp}]
+  is set on output resources to the \field{timestamp} value of the input
+  resource that produced the resource.
+\item[\field{offsets}]
+  is set on output resources to the starting offset for the data in the
+  buffer for each plane.
+\item[\field{data_sizes}]
+  is set on output resources to the amount of data written by the device,
+  for each plane.
+\end{description}
+
+\devicenormative{\subparagraph}{VIRTIO_VIDEO_CMD_RESOURCE_QUEUE}{Device Types / Video Device / Device Operation / Device Operation: Resource Commands / VIRTIO_VIDEO_CMD_RESOURCE_QUEUE}
+
+The device MUST mark output resources that might contain corrupted
+content due to an error with the VIRTIO_VIDEO_BUFFER_FLAG_ERR flag.
+
+For output resources, the device MUST copy the \field{timestamp}
+parameter of the input resource that produced it into its response.
+% TODO rephrase?
+
+In case of encoder, the device MUST mark each output resource with one
+of VIRTIO_VIDEO_DEQUEUE_FLAG_KEY_FRAME,
+VIRTIO_VIDEO_DEQUEUE_FLAG_P_FRAME, or
+VIRTIO_VIDEO_DEQUEUE_FLAG_B_FRAME.
+
+If the processing of a resource was stopped due to a stream event, a
+VIRTIO_VIDEO_CMD_STREAM_RESET, or a
+VIRTIO_VIDEO_CMD_STREAM_DESTROY, the device MUST set \field{result}
+to VIRTIO_VIDEO_RESULT_ERR_CANCELED.
+
+\drivernormative{\subparagraph}{VIRTIO_VIDEO_CMD_RESOURCE_QUEUE}{Device Types / Video Device / Device Operation / Device Operation: Resource Commands / VIRTIO_VIDEO_CMD_RESOURCE_QUEUE}
+
+\field{stream_id} MUST be set to a valid stream ID previously returned
+by VIRTIO_VIDEO_CMD_STREAM_CREATE.
+
+\field{queue_type} MUST be set to a valid queue type.
+
+\field{resource_id} MUST be an integer inferior to the number of
+resources currently allocated for the queue.
+
+The driver MUST account for the fact that the response to this command
+might come out-of-order (i.e. after other commands sent to the device),
+and that it can be interrupted.
+
+% TODO acourbot: The driver and device MUST follow requirements about
+% buffer ownership explained in
+% \ref{sec:Device Types / Video Device / Device Operation / Buffer lifecycle}.
+
+\subsubsection{Device Operation: Event Virtqueue}
+\label{sec:Device Types / Video Device / Device Operation / Device Operation: Event Virtqueue}
+
+The eventq is used by the device to signal stream events that are not a
+direct result of a command queued by the driver on the commandq. Since
+these events affect the device operation, the driver is expected to
+react to them and resume streaming afterwards.
+
+There are currently two supported events: device error, and Dynamic
+Resolution Change.
+
+\begin{lstlisting}
+#define VIRTIO_VIDEO_EVENT_ERROR    1
+#define VIRTIO_VIDEO_EVENT_DRC      2
+
+struct virtio_video_event {
+        le32 event_type; /* VIRTIO_VIDEO_EVENT_* */
+        union {
+                struct virtio_video_event_err err;
+                struct virtio_video_event_drc drc;
+        }
+}
+\end{lstlisting}
+% TODO define struct virtio_video_event_err and struct virtio_video_event_drc
+
+\drivernormative{\paragraph}{Device Operation: Event Virtqueue}{Device Types / Video Device / Device Operation / Device Operation: Event Virtqueue}
+
+The driver MUST at any time have at least one descriptor with a used
+buffer large enough to contain a \field{struct virtio_video_event}
+queued on the eventq.
+
+\paragraph{Error Event}
+\label{sec:Device Types / Video Device / Device Operation / Device Operation: Event Virtqueue / Error Event}
+
+The error event is queued by the device when an unrecoverable error
+occurred during processing. The stream is considered invalid (as if
+subjected to a VIRTIO_VIDEO_CMD_STREAM_DESTROY command) from that
+point and is automatically closed. Pending
+VIRTIO_VIDEO_CMD_STREAM_DRAIN and
+VIRTIO_VIDEO_CMD_RESOURCE_QUEUE commands are canceled, and further
+commands will fail with VIRTIO_VIDEO_RESULT_INVALID_STREAM_ID.
+
+Note that this is different from dequeued resources carrying the
+VIRTIO_VIDEO_DEQUEUE_FLAG_ERR flag. This flag indicates that the
+output might be corrupted, but the stream in itself can continue and
+might recover.
+
+This event should only be used for catastrophic errors, e.g. a host
+driver failure that cannot be recovered.
+
+\paragraph{Dynamic Resolution Change Event}
+\label{sec:Device Types / Video Device / Device Operation / Device Operation: Event Virtqueue / Dynamic Resolution Change Event}
+
+A Dynamic Resolution Change (or DRC) event happens when a decoder device
+detects that the resolution of the stream being decoded has changed.
+This event is emitted after processing all the input resources preceding
+the resolution change, and as a result all the output resources
+corresponding to these pre-DRC input resources are available to the
+driver by the time it receives the DRC event.
+
+A DRC event automatically detaches the backing memory of all output
+resources. Upon receiving the DRC event and processing all pending
+output resources, the driver is responsible for querying the new output
+resolution and re-attaching suitable backing memory to the output
+resources before queueing them again. Streaming resumes when the first
+output resource is queued with memory properly attached.
+
+\devicenormative{\subparagraph}{Dynamic Resolution Change Event}{Device Types / Video Device / Device Operation / Device Operation: Event Virtqueue / Dynamic Resolution Change Event}
+
+The device MUST make all the output resources that correspond to frames
+before the resolution change point available to the driver BEFORE it
+sends the resolution change event to the driver.
+
+After the event is emitted, the device MUST reject all output resources
+for which VIRTIO_VIDEO_CMD_RESOURCE_ATTACH_BACKING has not been
+successfully called again with
+VIRTIO_VIDEO_RESULT_ERR_INVALID_OPERATION.
+
+\drivernormative{\subparagraph}{Dynamic Resolution Change Event}{Device Types / Video Device / Device Operation / Device Operation: Event Virtqueue / Dynamic Resolution Change Event}
+
+The driver MUST query the new output resolution parameter and call
+VIRTIO_VIDEO_CMD_RESOURCE_ATTACH_BACKING with suitable memory for
+each output resource before queueing them again.
+
+\subsection{Codec-specific parameters}
+\label{sec:Device Types / Video Device / Codec-specific parameters}
+
+The codec-specific controls follow V4L2 controls definitions, that can be
+found in \hyperref[intro:V4L2 controls]{V4L2 controls header}.
+Human-readable descriptions for the codec-specific V4L2 controls can be found
+in \hyperref[intro:V4L2 codec controls]{V4L2 documentation}.
+
+\subsubsection{MPEG2}
+
+MPEG2 capabilities are defined as follows:
+
+\begin{lstlisting}
+#define VIRTIO_VIDEO_MPEG2_PARAM_PROFILE  1  /* Same as V4L2_CID_MPEG_VIDEO_MPEG2_PROFILE */
+#define VIRTIO_VIDEO_MPEG2_PARAM_LEVEL    2  /* Same as V4L2_CID_MPEG_VIDEO_MPEG2_LEVEL */
+
+struct virtio_video_mpeg2_caps {
+        le32 mpeg2_params_bitmask; /* Bitmask of MASK(VIRTIO_VIDEO_MPEG2_PARAM_*) */
+        le32 mpeg2_profiles_bitmask; /* Bitmask of MASK(V4L2_MPEG_VIDEO_MPEG2_PROFILE_*) */
+        le32 mpeg2_levels_bitmask; /* Bitmask of MASK(V4L2_MPEG_VIDEO_MPEG2_LEVEL_*) */
+        u8 padding[4];
+};
+\end{lstlisting}
+
+\begin{description}
+\item[\field{mpeg2_params_bitmask}]
+  is a bitmask of supported MPEG2 codec parameters.
+\item[\field{mpeg2_profiles_bitmask}]
+  is a bitmask of supported MPEG2 profiles used as bit numbers, see
+  \field{enum v4l2_mpeg_video_mpeg2_profile} in
+  \hyperref[intro:V4L2 controls]{V4L2 controls header}.
+\item[\field{mpeg2_levels_bitmask}]
+  is a bitmask of supported MPEG2 levels used as bit numbers, see
+  \field{enum v4l2_mpeg_video_mpeg2_level} in
+  \hyperref[intro:V4L2 controls]{V4L2 controls header}.
+\end{description}
+
+MPEG2 parameters are defined as follows:
+
+\begin{lstlisting}
+struct virtio_video_mpeg2_params {
+        le32 mpeg2_params_bitmask; /* Bitmask of MASK(VIRTIO_VIDEO_MPEG2_PARAM_*) */
+        le32 mpeg2_profile; /* V4L2_MPEG_VIDEO_MPEG2_PROFILE_* */
+        le32 mpeg2_level; /* V4L2_MPEG_VIDEO_MPEG2_LEVEL_* */
+        u8 padding[4];
+};
+\end{lstlisting}
+
+\begin{description}
+\item[\field{mpeg2_params_bitmask}]
+  is a bitmask of supported MPEG2 codec parameters.
+\item[\field{mpeg2_profile}]
+  is one of the supported MPEG2 profiles, see
+  \field{enum v4l2_mpeg_video_mpeg2_profile} in
+  \hyperref[intro:V4L2 controls]{V4L2 controls header}.
+\item[\field{mpeg2_level}]
+  is one of the supported MPEG2 levels, see
+  \field{enum v4l2_mpeg_video_mpeg2_level} in
+  \hyperref[intro:V4L2 controls]{V4L2 controls header}.
+\end{description}
+
+\subsubsection{MPEG4}
+
+MPEG4 capabilities are defined as follows:
+
+\begin{lstlisting}
+#define VIRTIO_VIDEO_MPEG4_PARAM_PROFILE  1  /* Same as V4L2_CID_MPEG_VIDEO_MPEG4_PROFILE */
+#define VIRTIO_VIDEO_MPEG4_PARAM_LEVEL    2  /* Same as V4L2_CID_MPEG_VIDEO_MPEG4_LEVEL */
+
+struct virtio_video_mpeg4_caps {
+        le32 mpeg4_params_bitmask; /* Bitmask of MASK(VIRTIO_VIDEO_MPEG4_PARAM_*) */
+        le32 mpeg4_profiles_bitmask; /* Bitmask of MASK(V4L2_MPEG_VIDEO_MPEG4_PROFILE_*) */
+        le32 mpeg4_levels_bitmask; /* Bitmask of MASK(V4L2_MPEG_VIDEO_MPEG4_LEVEL_*) */
+        u8 padding[4];
+};
+\end{lstlisting}
+
+\begin{description}
+\item[\field{mpeg4_params_bitmask}]
+  is a bitmask of supported MPEG4 codec parameters.
+\item[\field{mpeg4_profiles_bitmask}]
+  is a bitmask of supported MPEG4 profiles used as bit numbers, see
+  \field{enum v4l2_mpeg_video_mpeg4_profile} in
+  \hyperref[intro:V4L2 controls]{V4L2 controls header}.
+\item[\field{mpeg4_levels_bitmask}]
+  is a bitmask of supported MPEG4 levels used as bit numbers, see
+  \field{enum v4l2_mpeg_video_mpeg4_level} in
+  \hyperref[intro:V4L2 controls]{V4L2 controls header}.
+\end{description}
+
+MPEG4 parameters are defined as follows:
+
+\begin{lstlisting}
+struct virtio_video_mpeg4_params {
+        le32 mpeg4_params_bitmask; /* Bitmask of MASK(VIRTIO_VIDEO_MPEG4_PARAM_*) */
+        le32 mpeg4_profile; /* V4L2_MPEG_VIDEO_MPEG4_PROFILE_* */
+        le32 mpeg4_level; /* V4L2_MPEG_VIDEO_MPEG4_LEVEL_* */
+        u8 padding[4];
+};
+\end{lstlisting}
+
+\begin{description}
+\item[\field{mpeg4_params_bitmask}]
+  is a bitmask of supported MPEG4 codec parameters.
+\item[\field{mpeg4_profile}]
+  is one of the supported MPEG4 profiles, see
+  \field{enum v4l2_mpeg_video_mpeg4_profile} in
+  \hyperref[intro:V4L2 controls]{V4L2 controls header}.
+\item[\field{mpeg4_level}]
+  is one of the supported MPEG4 levels, see
+  \field{enum v4l2_mpeg_video_mpeg4_level} in
+  \hyperref[intro:V4L2 controls]{V4L2 controls header}.
+\end{description}
+
+\subsubsection{H.264}
+
+H.264 capabilities are defined as follows:
+
+\begin{lstlisting}
+#define VIRTIO_VIDEO_H264_PARAM_PROFILE  1  /* Same as V4L2_CID_MPEG_VIDEO_H264_PROFILE */
+#define VIRTIO_VIDEO_H264_PARAM_LEVEL    2  /* Same as V4L2_CID_MPEG_VIDEO_H264_LEVEL */
+
+struct virtio_video_h264_caps {
+        le32 h264_params_bitmask; /* Bitmask of MASK(VIRTIO_VIDEO_H264_PARAM_*) */
+        le32 h264_profiles_bitmask; /* Bitmask of MASK(V4L2_MPEG_VIDEO_H264_PROFILE_*) */
+        le32 h264_levels_bitmask; /* Bitmask of MASK(V4L2_MPEG_VIDEO_H264_LEVEL_*) */
+        u8 padding[4];
+};
+\end{lstlisting}
+
+\begin{description}
+\item[\field{h264_params_bitmask}]
+  is a bitmask of supported H.264 codec parameters.
+\item[\field{h264_profiles_bitmask}]
+  is a bitmask of supported H.264 profiles used as bit numbers, see
+  \field{enum v4l2_mpeg_video_h264_profile} in
+  \hyperref[intro:V4L2 controls]{V4L2 controls header}.
+\item[\field{h264_levels_bitmask}]
+  is a bitmask of supported H.264 levels used as bit numbers, see
+  \field{enum v4l2_mpeg_video_h264_level} in
+  \hyperref[intro:V4L2 controls]{V4L2 controls header}.
+\end{description}
+
+H.264 parameters are defined as follows:
+
+\begin{lstlisting}
+struct virtio_video_h264_params {
+        le32 h264_params_bitmask; /* Bitmask of MASK(VIRTIO_VIDEO_H264_PARAM_*) */
+        le32 h264_profile; /* V4L2_MPEG_VIDEO_H264_PROFILE_* */
+        le32 h264_level; /* V4L2_MPEG_VIDEO_H264_LEVEL_* */
+        u8 padding[4];
+};
+\end{lstlisting}
+
+\begin{description}
+\item[\field{h264_params_bitmask}]
+  is a bitmask of supported H.264 codec parameters.
+\item[\field{h264_profile}]
+  is one of the supported H.264 profiles, see
+  \field{enum v4l2_mpeg_video_h264_profile} in
+  \hyperref[intro:V4L2 controls]{V4L2 controls header}.
+\item[\field{h264_level}]
+  is one of the supported H.264 levels, see
+  \field{enum v4l2_mpeg_video_h264_level} in
+  \hyperref[intro:V4L2 controls]{V4L2 controls header}.
+\end{description}
+
+\subsubsection{HEVC}
+
+HEVC capabilities are defined as follows:
+
+\begin{lstlisting}
+#define VIRTIO_VIDEO_HEVC_PARAM_PROFILE  1  /* Same as V4L2_CID_MPEG_VIDEO_HEVC_PROFILE */
+#define VIRTIO_VIDEO_HEVC_PARAM_LEVEL    2  /* Same as V4L2_CID_MPEG_VIDEO_HEVC_LEVEL */
+
+struct virtio_video_hevc_caps {
+        le32 hevc_params_bitmask; /* Bitmask of MASK(VIRTIO_VIDEO_HEVC_PARAM_*) */
+        le32 hevc_profiles_bitmask; /* Bitmask of MASK(V4L2_MPEG_VIDEO_HEVC_PROFILE_*) */
+        le32 hevc_levels_bitmask; /* Bitmask of MASK(V4L2_MPEG_VIDEO_HEVC_LEVEL_*) */
+        u8 padding[4];
+};
+\end{lstlisting}
+
+\begin{description}
+\item[\field{hevc_params_bitmask}]
+  is a bitmask of supported HEVC codec parameters.
+\item[\field{hevc_profiles_bitmask}]
+  is a bitmask of supported HEVC profiles used as bit numbers, see
+  \field{enum v4l2_mpeg_video_hevc_profile} in
+  \hyperref[intro:V4L2 controls]{V4L2 controls header}.
+\item[\field{hevc_levels_bitmask}]
+  is a bitmask of supported HEVC levels used as bit numbers, see
+  \field{enum v4l2_mpeg_video_hevc_level} in
+  \hyperref[intro:V4L2 controls]{V4L2 controls header}.
+\end{description}
+
+HEVC parameters are defined as follows:
+
+\begin{lstlisting}
+struct virtio_video_hevc_params {
+        le32 hevc_params_bitmask; /* Bitmask of MASK(VIRTIO_VIDEO_HEVC_PARAM_*) */
+        le32 hevc_profile; /* V4L2_MPEG_VIDEO_HEVC_PROFILE_* */
+        le32 hevc_level; /* V4L2_MPEG_VIDEO_HEVC_LEVEL_* */
+        u8 padding[4];
+};
+\end{lstlisting}
+
+\begin{description}
+\item[\field{hevc_params_bitmask}]
+  is a bitmask of supported HEVC codec parameters.
+\item[\field{hevc_profile}]
+  is one of the supported HEVC profiles, see
+  \field{enum v4l2_mpeg_video_hevc_profile} in
+  \hyperref[intro:V4L2 controls]{V4L2 controls header}.
+\item[\field{hevc_level}]
+  is one of the supported HEVC levels, see
+  \field{enum v4l2_mpeg_video_hevc_level} in
+  \hyperref[intro:V4L2 controls]{V4L2 controls header}.
+\end{description}
+
+\subsubsection{VP8}
+
+VP8 capabilities are defined as follows:
+
+\begin{lstlisting}
+#define VIRTIO_VIDEO_VP8_PARAM_PROFILE  1  /* Same as V4L2_CID_MPEG_VIDEO_VP8_PROFILE */
+
+struct virtio_video_vp8_caps {
+        le32 vp8_params_bitmask; /* Bitmask of MASK(VIRTIO_VIDEO_VP8_PARAM_*) */
+        le32 vp8_profiles_bitmask; /* Bitmask of MASK(V4L2_MPEG_VIDEO_VP8_PROFILE_*) */
+};
+\end{lstlisting}
+
+\begin{description}
+\item[\field{vp8_params_bitmask}]
+  is a bitmask of supported VP8 codec parameters.
+\item[\field{vp8_profiles_bitmask}]
+  is a bitmask of supported VP8 profiles used as bit numbers, see
+  \field{enum v4l2_mpeg_video_vp8_profile} in
+  \hyperref[intro:V4L2 controls]{V4L2 controls header}.
+\end{description}
+
+VP8 parameters are defined as follows:
+
+\begin{lstlisting}
+struct virtio_video_vp8_params {
+        le32 vp8_params_bitmask; /* Bitmask of MASK(VIRTIO_VIDEO_VP8_PARAM_*) */
+        le32 vp8_profile; /* V4L2_MPEG_VIDEO_VP8_PROFILE_* */
+};
+\end{lstlisting}
+
+\begin{description}
+\item[\field{vp8_params_bitmask}]
+  is a bitmask of supported VP8 codec parameters.
+\item[\field{vp8_profile}]
+  is one of the supported VP8 profiles, see
+  \field{enum v4l2_mpeg_video_vp8_profile} in
+  \hyperref[intro:V4L2 controls]{V4L2 controls header}.
+\end{description}
+
+\subsubsection{VP9}
+
+VP9 capabilities are defined as follows:
+
+\begin{lstlisting}
+#define VIRTIO_VIDEO_VP9_PARAM_PROFILE  1  /* Same as V4L2_CID_MPEG_VIDEO_VP9_PROFILE */
+#define VIRTIO_VIDEO_VP9_PARAM_LEVEL    2  /* Same as V4L2_CID_MPEG_VIDEO_VP9_LEVEL */
+
+struct virtio_video_vp9_caps {
+        le32 vp9_params_bitmask; /* Bitmask of MASK(VIRTIO_VIDEO_VP9_PARAM_*) */
+        le32 vp9_profiles_bitmask; /* Bitmask of MASK(V4L2_MPEG_VIDEO_VP9_PROFILE_*) */
+        le32 vp9_levels_bitmask; /* Bitmask of MASK(V4L2_MPEG_VIDEO_VP9_LEVEL_*) */
+        u8 padding[4];
+};
+\end{lstlisting}
+
+\begin{description}
+\item[\field{vp9_params_bitmask}]
+  is a bitmask of supported VP9 codec parameters.
+\item[\field{vp9_profiles_bitmask}]
+  is a bitmask of supported VP9 profiles used as bit numbers, see
+  \field{enum v4l2_mpeg_video_vp9_profile} in
+  \hyperref[intro:V4L2 controls]{V4L2 controls header}.
+\item[\field{vp9_levels_bitmask}]
+  is a bitmask of supported VP9 levels used as bit numbers, see
+  \field{enum v4l2_mpeg_video_vp9_level} in
+  \hyperref[intro:V4L2 controls]{V4L2 controls header}.
+\end{description}
+
+VP9 parameters are defined as follows:
+
+\begin{lstlisting}
+struct virtio_video_vp9_params {
+        le32 vp9_params_bitmask; /* Bitmask of MASK(VIRTIO_VIDEO_VP9_PARAM_*) */
+        le32 vp9_profile; /* V4L2_MPEG_VIDEO_VP9_PROFILE_* */
+        le32 vp9_level; /* V4L2_MPEG_VIDEO_VP9_LEVEL_* */
+        u8 padding[4];
+};
+\end{lstlisting}
+
+\begin{description}
+\item[\field{vp9_params_bitmask}]
+  is a bitmask of supported VP9 codec parameters.
+\item[\field{vp9_profile}]
+  is one of the supported VP9 profiles, see
+  \field{enum v4l2_mpeg_video_vp9_profile} in
+  \hyperref[intro:V4L2 controls]{V4L2 controls header}.
+\item[\field{vp9_level}]
+  is one of the supported VP9 levels, see
+  \field{enum v4l2_mpeg_video_vp9_level} in
+  \hyperref[intro:V4L2 controls]{V4L2 controls header}.
+\end{description}
diff --git a/device-types/video/device-conformance.tex b/device-types/video/device-conformance.tex
new file mode 100644
index 0000000..9c1cec4
--- /dev/null
+++ b/device-types/video/device-conformance.tex
@@ -0,0 +1,24 @@
+\conformance{\subsection}{Video Device Conformance}
+\label{sec:Conformance / Device Conformance / Video Device Conformance}
+
+A video device MUST conform to the following normative statements:
+
+\begin{itemize}
+\item \ref{devicenormative:Device Types / Video Device / Feature bits}
+\item \ref{devicenormative:Device Types / Video Device / Device configuration layout}
+\item \ref{devicenormative:Device Types / Video Device / Device Operation}
+\item \ref{devicenormative:Device Types / Video Device / Device Operation / Device Operation: Command Virtqueue}
+\item \ref{devicenormative:Device Types / Video Device / Device Operation / Device Operation: Device Commands / VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS}
+\item \ref{devicenormative:Device Types / Video Device / Device Operation / Device Operation: Device Commands / VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS / VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS: Format dependencies}
+\item \ref{devicenormative:Device Types / Video Device / Device Operation / Device Operation: Device Commands / VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS / VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS: Raw format capabilities}
+\item \ref{devicenormative:Device Types / Video Device / Device Operation / Device Operation: Device Commands / VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS / VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS: Resource capabilities}
+\item \ref{devicenormative:Device Types / Video Device / Device Operation / Device Operation: Device Commands / VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS / VIRTIO_VIDEO_CMD_DEVICE_QUERY_CAPS: Bitrates}
+\item \ref{devicenormative:Device Types / Video Device / Device Operation / Device Operation: Stream commands / VIRTIO_VIDEO_CMD_STREAM_CREATE}
+\item \ref{devicenormative:Device Types / Video Device / Device Operation / Device Operation: Stream commands / VIRTIO_VIDEO_CMD_STREAM_DESTROY}
+\item \ref{devicenormative:Device Types / Video Device / Device Operation / Device Operation: Stream commands / VIRTIO_VIDEO_CMD_STREAM_SET_PARAMS}
+\item \ref{devicenormative:Device Types / Video Device / Device Operation / Device Operation: Stream commands / VIRTIO_VIDEO_CMD_STREAM_DRAIN}
+\item \ref{devicenormative:Device Types / Video Device / Device Operation / Device Operation: Stream commands / VIRTIO_VIDEO_CMD_STREAM_RESET}
+\item \ref{devicenormative:Device Types / Video Device / Device Operation / Device Operation: Resource Commands / VIRTIO_VIDEO_CMD_RESOURCE_ATTACH_BACKING}
+\item \ref{devicenormative:Device Types / Video Device / Device Operation / Device Operation: Resource Commands / VIRTIO_VIDEO_CMD_RESOURCE_QUEUE}
+\item \ref{devicenormative:Device Types / Video Device / Device Operation / Device Operation: Event Virtqueue / Dynamic Resolution Change Event}
+\end{itemize}
diff --git a/device-types/video/driver-conformance.tex b/device-types/video/driver-conformance.tex
new file mode 100644
index 0000000..669bcb9
--- /dev/null
+++ b/device-types/video/driver-conformance.tex
@@ -0,0 +1,18 @@
+\conformance{\subsection}{Video Driver Conformance}
+\label{sec:Conformance / Driver Conformance / Video Driver Conformance}
+
+A video driver MUST conform to the following normative statements:
+
+\begin{itemize}
+\item \ref{drivernormative:Device Types / Video Device / Feature bits}
+\item \ref{drivernormative:Device Types / Video Device / Device Operation}
+\item \ref{drivernormative:Device Types / Video Device / Device Operation / Device Operation: Command Virtqueue}
+\item \ref{drivernormative:Device Types / Video Device / Device Operation / Device Operation: Stream commands / VIRTIO_VIDEO_CMD_STREAM_DESTROY}
+\item \ref{drivernormative:Device Types / Video Device / Device Operation / Device Operation: Stream commands / VIRTIO_VIDEO_CMD_STREAM_SET_PARAMS}
+\item \ref{drivernormative:Device Types / Video Device / Device Operation / Device Operation: Stream commands / VIRTIO_VIDEO_CMD_STREAM_DRAIN}
+\item \ref{drivernormative:Device Types / Video Device / Device Operation / Device Operation: Stream commands / VIRTIO_VIDEO_CMD_STREAM_RESET}
+\item \ref{drivernormative:Device Types / Video Device / Device Operation / Device Operation: Resource Commands / VIRTIO_VIDEO_CMD_RESOURCE_ATTACH_BACKING}
+\item \ref{drivernormative:Device Types / Video Device / Device Operation / Device Operation: Resource Commands / VIRTIO_VIDEO_CMD_RESOURCE_QUEUE}
+\item \ref{drivernormative:Device Types / Video Device / Device Operation / Device Operation: Event Virtqueue}
+\item \ref{drivernormative:Device Types / Video Device / Device Operation / Device Operation: Event Virtqueue / Dynamic Resolution Change Event}
+\end{itemize}
diff --git a/introduction.tex b/introduction.tex
index 287c5fc..68bd2aa 100644
--- a/introduction.tex
+++ b/introduction.tex
@@ -98,6 +98,15 @@ \section{Normative References}\label{sec:Normative References}
 	\phantomsection\label{intro:SEC1}\textbf{[SEC1]} &
     Standards for Efficient Cryptography Group(SECG), ``SEC1: Elliptic Cureve Cryptography'', Version 1.0, September 2000.
 	\newline\url{https://www.secg.org/sec1-v2.pdf}\\
+	\phantomsection\label{intro:V4L2}\textbf{[V4L2]} &
+	Linux V4L2 interface.
+	\newline\url{https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/uapi/linux/videodev2.h}\\
+	\phantomsection\label{intro:V4L2 controls}\textbf{[V4L2 Controls]} &
+	Linux V4L2 controls definitions.
+	\newline\url{https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/uapi/linux/v4l2-controls.h}\\
+	\phantomsection\label{intro:DRM formats}\textbf{[DRM Formats]} &
+	Linux DRM format definitions.
+	\newline\url{https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/uapi/drm/drm_fourcc.h}\\
 
 \end{longtable}
 
@@ -107,6 +116,18 @@ \section{Non-Normative References}
 	\phantomsection\label{intro:Virtio PCI Draft}\textbf{[Virtio PCI Draft]} &
 	Virtio PCI Draft Specification
 	\newline\url{http://ozlabs.org/~rusty/virtio-spec/virtio-0.9.5.pdf}\\
+	\phantomsection\label{intro:V4L2 compressed}\textbf{[V4L2 compressed formats]} &
+	Detailed descriptions of V4L2 compressed formats
+	\newline\url{https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst}\\
+	\phantomsection\label{intro:V4L2 RGB}\textbf{[V4L2 RGB formats]} &
+	Detailed descriptions of V4L2 RGB formats
+	\newline\url{https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/userspace-api/media/v4l/pixfmt-rgb.rst}\\
+	\phantomsection\label{intro:V4L2 YUV}\textbf{[V4L2 planar YUV formats]} &
+	Detailed descriptions of V4L2 planar YUV formats
+	\newline\url{https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst}\\
+	\phantomsection\label{intro:V4L2 codec controls}\textbf{[V4L2 codec controls]} &
+	Detailed descriptions of V4L2 controls
+	\newline\url{https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst}\\
 \end{longtable}
 
 \section{Terminology}\label{Terminology}
-- 
2.34.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

