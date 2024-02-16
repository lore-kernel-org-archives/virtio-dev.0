Return-Path: <virtio-dev-return-14320-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E96D4C48BEB
	for <virtio-dev@archiver.kernel.org>; Fri, 16 Feb 2024 08:24:44 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 349C7144A69
	for <virtio-dev@archiver.kernel.org>; Fri, 16 Feb 2024 08:24:44 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1A117986660
	for <virtio-dev@archiver.kernel.org>; Fri, 16 Feb 2024 08:24:44 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id E3C629865F9; Fri, 16 Feb 2024 08:24:43 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D04239865FD
	for <virtio-dev@lists.oasis-open.org>; Fri, 16 Feb 2024 08:24:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708071882; x=1708676682;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3xYACjPWkkgOpI/tB7l8FQsUwj5cHnCmM6DknQTodTk=;
        b=kw84Lrmnu5UZ+u36OZMPHz3Py3UKe9fbM8Q7WYsKqVjtGPQfwrFda4B1VsXTji6zXi
         qk6rtS+h7Mp3D5UlfYz8I5sTIdFQWHvADMBbEl9dc+qIIQkJwz6vjUY8FtHqsI3q7R6o
         Rn5ehYzrgBGmAZ8sKciUsLM8RTbheIld+/sx8pIcgQy69r1mnIv19kDzO/383xdh5Hz1
         jSECq4ka0QzC11rjDRQdTx5PjTnCzlwqlx5rPwgTB4JpyHdiWhuDhO26jak7p2tOJqwT
         56HWG+k7OBFtD5CkuTG09rsXQRBKj5vDb/ALX4xyj5qCF2AewkrevHNUYqe0owTZUb28
         spXA==
X-Forwarded-Encrypted: i=1; AJvYcCVb8v4bh0sEW1Lmz1kgkB5l45WQS0TrT0LpGGQGBp61sS+gLSP5sqbnNb6A0JT3ZNKY1NfoJ1j4XPSkVy9vhO09845zS/Eblix7mh3boSiP
X-Gm-Message-State: AOJu0Yy+E67iDiKwXf8q6LW1ylmsgVJlH/52lipWIygtSHn8SLWg+yRC
	wQC3Ofom47+4F4mrbykmCKP8pHwHu3NzPeHMzqyQ4HHXMZPLSLq9DIq9VvoMUQ==
X-Google-Smtp-Source: AGHT+IEPTEh5AsW/CjpM/SdLOPLI18oY3up9l/pRZM9f37+AJl6bvYqznQGVEgzgo7WcVTJos2ln/g==
X-Received: by 2002:a05:6358:8187:b0:17a:fa59:bb87 with SMTP id r7-20020a056358818700b0017afa59bb87mr4206297rwk.16.1708071882439;
        Fri, 16 Feb 2024 00:24:42 -0800 (PST)
From: David Stevens <stevensd@chromium.org>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	virtio-comment@lists.oasis-open.org,
	virtio-dev@lists.oasis-open.org
Cc: parav@nvidia.com,
	David Stevens <stevensd@chromium.org>
Date: Fri, 16 Feb 2024 17:24:31 +0900
Message-ID: <20240216082432.709956-1-stevensd@chromium.org>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] [PATCH v4 0/1] Define a low power mode for devices

The Linux patch [1] added support for suspending virtio devices using
native PCI power management. However, Linux does PCI power management
during the noirq phase of suspend and resume. Without a mechanism to
suspend/resume virtio devices when the driver is suspended/resumed in
the early phase of suspend/late phase of resume, there is a window where
interrupts can be lost.

[1] https://lore.kernel.org/lkml/20231208070754.3132339-1-stevensd@chromium.org/

v3 -> v4:
 - Define virtio-pci specific power management that can be used in
   conjunction with PCI power management.
v2 -> v3:
 - Use different words for some concepts to avoid conflicts with other
   parts of the spec.
 - Rewrite various sentences to improve clarity.
v1 -> v2:
 - Define virtio-pci support on top of PCI power management.
 - Add more conformance requirements.

David Stevens (1):
  Add suspend support for virtio PCI devices

 transport-pci.tex | 51 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

-- 
2.44.0.rc0.258.g7320e95886-goog


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

