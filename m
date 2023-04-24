Return-Path: <virtio-dev-return-12371-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D4D1C77B61
	for <virtio-dev@archiver.kernel.org>; Mon, 24 Apr 2023 16:44:52 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 7AE72335C8
	for <virtio-dev@archiver.kernel.org>; Mon, 24 Apr 2023 16:44:39 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6819B98644C
	for <virtio-dev@archiver.kernel.org>; Mon, 24 Apr 2023 16:44:39 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 5C62D986350; Mon, 24 Apr 2023 16:44:39 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3DFA498635B
	for <virtio-dev@lists.oasis-open.org>; Mon, 24 Apr 2023 16:44:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: Y2Guk0HzOM6aR0-tGID57A-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682354661; x=1684946661;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vrisbuyN1hGASdP4WSq3lkqt2yuQlBOtvrIYeac1E4E=;
        b=lzjwiZTv6I3+3e8u7VMuExEtdo8yymzfjt/1nmDA82/2gAarUkJ531JHJbG8cDZRsV
         4+xEbuxm+HQ7caNwNtpvri0zmjnBHY96G7YhShtpF2nNbt2OHyBl0JUpIz99q//eqmQb
         QYNsdAa+z8qrcpzg+nMBWPeb2t445lH1cEfoKIiI0mi231pj6w+IljFbm4N0XEhO7mku
         ZBzlF/FqhhdpUT/nEu8tayG8PohhxvBbpLrylGNCTuV8Bw7sCPcCDPwmDnPni+TKAMWM
         /DiwT2UI3E6xMPOI7UI0R8/jg8QvyJKpOla4JtsZk+kJN6+ZrBsPThZloo4UKlT5+SYD
         LhuA==
X-Gm-Message-State: AAQBX9d2LFKPtnspErRjUHKkDr69/rSChUvyvP4vDOwYOUemz8CHtNcG
	su3QgnWndFNNR5rD7wxFT43wlD4g2Qshc9mO18ca7Fxto+D8BTf21U4ii2VDoLMDhsm9WaESEFC
	cDVaE/Aofmo1/yiVgF8NpfwwMp6Dv
X-Received: by 2002:a05:6000:1809:b0:2fb:c131:ad12 with SMTP id m9-20020a056000180900b002fbc131ad12mr9875705wrh.63.1682354660935;
        Mon, 24 Apr 2023 09:44:20 -0700 (PDT)
X-Google-Smtp-Source: AKy350atEjEYiqQN21/ApUrnOiF966WYjwJzVr/46rKN5LkCXpP0TiqYAWfNmYkk8WRWIiEs2T0hPw==
X-Received: by 2002:a05:6000:1809:b0:2fb:c131:ad12 with SMTP id m9-20020a056000180900b002fbc131ad12mr9875682wrh.63.1682354660622;
        Mon, 24 Apr 2023 09:44:20 -0700 (PDT)
Date: Mon, 24 Apr 2023 12:44:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
	jasowang@redhat.com, mst@redhat.com, cohuck@redhat.com,
	sgarzare@redhat.com, stefanha@redhat.com, nrupal.jani@intel.com,
	Piotr.Uminski@intel.com, hang.yuan@intel.com
Cc: virtio@lists.oasis-open.org, Jiri Pirko <jiri@nvidia.com>,
	Zhu Lingshan <lingshan.zhu@intel.com>, pasic@linux.ibm.com,
	Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <d65af1b2219150f5b26488f2e777504de44a6923.1682354275.git.mst@redhat.com>
References: <cover.1682354275.git.mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <cover.1682354275.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] [PATCH v12 01/10] virtio: document forward compatibility guarantees

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
Reviewed-by: Zhu Lingshan <lingshan.zhu@intel.com>
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

