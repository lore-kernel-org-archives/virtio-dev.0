Return-Path: <virtio-dev-return-11365-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAF28C6FA8E
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 13:05:37 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id EF2152B35B
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 13:05:29 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E591098669D
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 13:05:29 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id D9D77986674; Thu,  2 Mar 2023 13:05:29 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BC626986672
	for <virtio-dev@lists.oasis-open.org>; Thu,  2 Mar 2023 13:05:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: TIm8aIJENFuZ6V51J8ls4w-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677762297;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pEPlGcw2yod3MCEhIj3ZwcmWZS3U+lgcxD66oHp8Ww4=;
        b=EH3wQF09LvDHjPI+N5SHxw35bwJ75GoGLJXtegtq8q16d8NAcy/2wQ9/nMkmpHyWx1
         yaEDrtM0GGMZ1P1QOMzZXWlWAe8BLH0Kxfyu243dW9SqqexRhd/LHAS+/IOr7lGc/YO6
         r7bOoV3QI/YmBBh7o8OS+N2lcqb6bkhF/cAs4OyxdMGmfm71AYifJ3tq8jd9rL+4Ezgp
         aLjy3z3eMT2usa2DqxvvZUDy1LTGqJFso8FQJeIHfWfoZPkXqC9gGT2llf+XjZdYQmL2
         /yXerBWoeLyZ0U5UN+8HAOlfGh/F88+LMXwdhsOOKCWHnp8KQ/DnXn1M39WSGYOHp+kF
         q6EA==
X-Gm-Message-State: AO0yUKX9mrHJr0emM2W58VpHZAt9F8oNFtPjCDkNLnB5MmCUeNIMTadV
	Cdm+haVYnQwDIff5HuRkWDC9giv6+6UE4psFMxGmAoKTC6PizaVhIsMSO+R/iEUlGvNrAEULLpd
	eqdJFmiCIRUFPxO2rrsPbdqi07FhU
X-Received: by 2002:a05:600c:548c:b0:3eb:55d2:9c4c with SMTP id iv12-20020a05600c548c00b003eb55d29c4cmr1429904wmb.16.1677762297797;
        Thu, 02 Mar 2023 05:04:57 -0800 (PST)
X-Google-Smtp-Source: AK7set8ntCAQ9x2+2DpPrvTE+LBLIUKUzkIF485oQBWDV5kLdCC+KBPe3cqHfmP50CyWEnfsphy4fA==
X-Received: by 2002:a05:600c:548c:b0:3eb:55d2:9c4c with SMTP id iv12-20020a05600c548c00b003eb55d29c4cmr1429886wmb.16.1677762297436;
        Thu, 02 Mar 2023 05:04:57 -0800 (PST)
Date: Thu, 2 Mar 2023 08:04:53 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
	jasowang@redhat.com, mst@redhat.com, cohuck@redhat.com,
	sgarzare@redhat.com, stefanha@redhat.com, nrupal.jani@intel.com,
	Piotr.Uminski@intel.com, hang.yuan@intel.com
Cc: virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>,
	pasic@linux.ibm.com, Shahaf Shuler <shahafs@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <0a784140387c2a592f7e1e7bbc5ae926ec5b45da.1677761896.git.mst@redhat.com>
References: <cover.1677761896.git.mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <cover.1677761896.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] [PATCH v10 01/10] virtio: document forward compatibility guarantees

Feature negotiation forms the basis of forward compatibility
guarantees of virtio but has never been properly documented.
Do it now.

Suggested-by: Halil Pasic <pasic@linux.ibm.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 content.tex | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/content.tex b/content.tex
index 0e474dd..0c2d917 100644
--- a/content.tex
+++ b/content.tex
@@ -114,21 +114,63 @@ \section{Feature Bits}\label{sec:Basic Facilities of a Virtio Device / Feature B
 In particular, new fields in the device configuration space are
 indicated by offering a new feature bit.
 
+To keep the feature negotiation mechanism extensible, it is important
+that devices \em{do not} offer any feature bits that they would not be
+able to handle if the driver accepted them (even though drivers are not
+supposed to accept them in the first place even if offered, according to
+this version of the specification.) Likewise, it is important that
+drivers \em{do not} accept feature bits they do not know how to handle
+(even though devices are not supposed to offer them in the first place,
+according to this version of the specification.) The preferred way for
+handling reserved and unexpected features is that the driver ignores
+them.
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

