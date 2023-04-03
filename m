Return-Path: <virtio-dev-return-11894-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34C6DC76196
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 15:03:16 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 7CF1C26D7
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 15:03:15 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 744F39865A1
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 15:03:15 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 66ACC9863F0; Mon,  3 Apr 2023 15:03:15 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 55F9A98658D
	for <virtio-dev@lists.oasis-open.org>; Mon,  3 Apr 2023 15:03:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: FEB4AzqrPRqiHKkp8J2X_Q-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680534189;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gzplKRTHu/vMCvc4t33dvK+D04mJ7A3AvZe8fbWJ/Hw=;
        b=uZuedCI0oo8+MpZntag4/EtwoBGYeg3eC8MymaGzDv+Fl3i09zA1jQvTBIMKJRbqIa
         TJwxKdBaw5+faeX9CgsJPZeW6AiSFjJ4Pbw4bKbCNn5agy0hSeZ0KfR10TTw5GzcW2Yj
         H2dcPr44qxHZBG8J7WEajW4e4n8akgz0IRP7mhR66u8dZUjMEvEBp7NgMcCIBVXqx1g3
         43SerBTN0y9PYrztWADVnolOPiYyrZe7Ol3LUiKmrGlUfPDnEOzIyPaQFEJEAWOkeeZL
         FKdUosX1OxHHalFvgUTSLSFrFPZPBLXibp5BS4pec1xK8fwFa8meiWZY1PvgSm20FNQR
         Wx+A==
X-Gm-Message-State: AAQBX9eF4aXPJmZh9ODGOh+p+bb7etzMjCzxVYyT7ByuRbJdJsKU/MZg
	vLAGf+0Kl1unmowBu+WwNQxeWdk8epE9JYXU7ARXSHcX5tvesOri/bx9UjdDvbU9BnmgOJem+9G
	6sWlsqhUuRz1rRt5NK6cy7PfGAcecwSwIXJHAe8fIWg==
X-Received: by 2002:a17:906:278a:b0:8b1:fc1a:7d21 with SMTP id j10-20020a170906278a00b008b1fc1a7d21mr39083351ejc.5.1680534189331;
        Mon, 03 Apr 2023 08:03:09 -0700 (PDT)
X-Google-Smtp-Source: AKy350at1aJMML/Z3NZGIq/6S7hzFRR83vxe2/zhMW0tqvyjVbLiPduQyvmuypgKpVp3zSQ0RxAPVg==
X-Received: by 2002:a17:906:278a:b0:8b1:fc1a:7d21 with SMTP id j10-20020a170906278a00b008b1fc1a7d21mr39083317ejc.5.1680534189020;
        Mon, 03 Apr 2023 08:03:09 -0700 (PDT)
Date: Mon, 3 Apr 2023 11:03:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
	jasowang@redhat.com, mst@redhat.com, cohuck@redhat.com,
	sgarzare@redhat.com, stefanha@redhat.com, nrupal.jani@intel.com,
	Piotr.Uminski@intel.com, hang.yuan@intel.com
Cc: virtio@lists.oasis-open.org, Jiri Pirko <jiri@nvidia.com>,
	Zhu Lingshan <lingshan.zhu@intel.com>, pasic@linux.ibm.com,
	Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <984303d7cd2413b00873a3cea803c2fa17108e83.1680533760.git.mst@redhat.com>
References: <cover.1680533760.git.mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <cover.1680533760.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] [PATCH v11 01/10] virtio: document forward compatibility guarantees

Feature negotiation forms the basis of forward compatibility
guarantees of virtio but has never been properly documented.
Do it now.

Suggested-by: Halil Pasic <pasic@linux.ibm.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
---

Changes in v11:
	make explanation about not using any unspecified bits
	more detailed as suggested by Cornelia and David
---
 content.tex | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/content.tex b/content.tex
index 0e474dd..8098988 100644
--- a/content.tex
+++ b/content.tex
@@ -114,21 +114,65 @@ \section{Feature Bits}\label{sec:Basic Facilities of a Virtio Device / Feature B
 In particular, new fields in the device configuration space are
 indicated by offering a new feature bit.
 
+To keep the feature negotiation mechanism extensible, it is
+important that devices \em{do not} offer any feature bits that
+they would not be able to handle if the driver accepted them
+(even though drivers are not supposed to accept any unspecified,
+reserved, or unsupported features even if offered, according to
+the specification.) Likewise, it is important that drivers \em{do
+not} accept feature bits they do not know how to handle (even
+though devices are not supposed to offer any unspecified,
+reserved, or unsupported features in the first place,
+according to the specification.) The preferred
+way for handling reserved and unexpected features is that the
+driver ignores them.
+
+In particular, this is
+especially important for features limited to specific transports,
+as enabling these for more transports in future versions of the
+specification is highly likely to require changing the behaviour
+from drivers and devices.  Drivers and devices supporting
+multiple transports need to carefully maintain per-transport
+lists of allowed features.
+
 \drivernormative{\subsection}{Feature Bits}{Basic Facilities of a Virtio Device / Feature Bits}
 The driver MUST NOT accept a feature which the device did not offer,
 and MUST NOT accept a feature which requires another feature which was
 not accepted.
 
+The driver MUST validate the feature bits offered by the device.
+The driver MUST ignore and MUST NOT accept any feature bit that is
+\begin{itemize}
+\item not described in this specification,
+\item marked as reserved,
+\item not supported for the specific transport,
+\item not defined for the device type.
+\end{itemize}
+
 The driver SHOULD go into backwards compatibility mode
 if the device does not offer a feature it understands, otherwise MUST
 set the FAILED \field{device status} bit and cease initialization.
 
+By contrast, the driver MUST NOT fail solely because a feature
+it does not understand has been offered by the device.
+
 \devicenormative{\subsection}{Feature Bits}{Basic Facilities of a Virtio Device / Feature Bits}
 The device MUST NOT offer a feature which requires another feature
 which was not offered.  The device SHOULD accept any valid subset
 of features the driver accepts, otherwise it MUST fail to set the
 FEATURES_OK \field{device status} bit when the driver writes it.
 
+The device MUST NOT offer feature bits corresponding to features
+it would not support if accepted by the driver (even if the
+driver is prohibited from accepting the feature bits by the
+specification); for the sake of clarity, this refers to feature
+bits not described in this specification, reserved feature bits
+and feature bits reserved or not supported for the specific
+transport or the specific device type, but this does not preclude
+devices written to a future version of this specification from
+offering such feature bits should such a specification have a
+provision for devices to support the corresponding features.
+
 If a device has successfully negotiated a set of features
 at least once (by accepting the FEATURES_OK \field{device
 status} bit during device initialization), then it SHOULD
-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

