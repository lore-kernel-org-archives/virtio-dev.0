Return-Path: <virtio-dev-return-14357-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53E94C5478C
	for <virtio-dev@archiver.kernel.org>; Tue, 27 Feb 2024 01:54:11 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 88C0D2AFCE
	for <virtio-dev@archiver.kernel.org>; Tue, 27 Feb 2024 01:54:10 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 66FBA9865C9
	for <virtio-dev@archiver.kernel.org>; Tue, 27 Feb 2024 01:54:10 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 477859863AB; Tue, 27 Feb 2024 01:54:10 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 350409863DE
	for <virtio-dev@lists.oasis-open.org>; Tue, 27 Feb 2024 01:54:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708998847; x=1709603647;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ir8KOJyTG35oHOK6cwt0T+Sr/hs8fYARHDnxd5lWN0w=;
        b=MzdmeJxVQY1PWqIRjAMLdd0KTi029nByaMqBAtREdqr7Rly2inFmtU04oXhMUeuLEQ
         L8Z5f7kKvbxWO+Pblt7txRVvgN418dmZCucpC5MDRwKlt5wMcepHipvzZxf+7l7TMZxq
         YyLrl0cSt8sRJ5f+Q9jj2fG5b9jhJ2NCUVz/xnSiUErN+/IiV829bvPBBg1KgujBbuZq
         w6SFkQEmz3I5y07Tb4wQgwJPM3sTgDAglFFnkkomL5uiOgtUT2hOOi1J7djiHFKDXdQv
         ZOc//COcBrfQNO1FL1qUJoWKXSJR0NtdQxDEbzjXTvVDckX1hxC6uevTiDuQVwcGQOhW
         Bupg==
X-Forwarded-Encrypted: i=1; AJvYcCV2M1iRq3TC5D2opk9GvXkEP0qxL+UTwimHfKbuWg/qx+jZPdIYYTyqKAqxP13j0CUoglAUrDeBxW54EgOCYeDdS430ZCutgryO2OWbYFs5
X-Gm-Message-State: AOJu0YyJXVn7sUHzIMIoYrAJ3bVrbUycAO2EazLDC9naKFaL5M9Eflc+
	SGoIwmMVkQhV3PecWQhJoYBXvjdppVYB93wWqur7hMZTd+z9251MaRcbR7hrQQ==
X-Google-Smtp-Source: AGHT+IG1kghKSW/J7cyRPf0d3dYoN5c3ExOUNsJD2LOk9tDJkqkFCDQ3VlsvmxbPm43kC9SJvvtuyw==
X-Received: by 2002:a17:902:ec8b:b0:1db:2ad9:9393 with SMTP id x11-20020a170902ec8b00b001db2ad99393mr11736234plg.48.1708998847242;
        Mon, 26 Feb 2024 17:54:07 -0800 (PST)
From: David Stevens <stevensd@chromium.org>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Zhu Lingshan <lingshan.zhu@intel.com>,
	virtio-comment@lists.oasis-open.org,
	virtio-dev@lists.oasis-open.org
Cc: parav@nvidia.com,
	David Stevens <stevensd@chromium.org>
Date: Tue, 27 Feb 2024 10:53:44 +0900
Message-ID: <20240227015345.3614965-1-stevensd@chromium.org>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] [PATCH v5 0/1] Define a low power mode for devices

The Linux patch [1] added support for suspending virtio devices using
native PCI power management. However, Linux does PCI power management
during the noirq phase of suspend and resume. Without a mechanism to
suspend/resume virtio devices when the driver is suspended/resumed in
the early phase of suspend/late phase of resume, there is a window where
interrupts can be lost.

This revision of the patch tries to reconcile with the similar proposal
[2], which was pulled out of one of a patch series attempting to add
live migration support to virtio [3].

[1] https://lore.kernel.org/lkml/20231208070754.3132339-1-stevensd@chromium.org/
[2] https://lore.kernel.org/all/20240218132306.83456-1-lingshan.zhu@intel.com/
[3] https://lore.kernel.org/all/20231103103437.72784-1-lingshan.zhu@intel.com/

v4 -> v5:
 - Use a device status bit instead of a pci capability.
 - Reconcile differences with [2] by specifying that devices should
   finish processing buffers before suspending and that devices
   shouldn't access virtqueues while suspended.
 - Add more details about state transition acknowledgment.
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
  Add SUSPEND bit to device status

 content.tex | 89 ++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 84 insertions(+), 5 deletions(-)

-- 
2.44.0.rc0.258.g7320e95886-goog


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

