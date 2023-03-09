Return-Path: <virtio-dev-return-11563-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BA70C61DA4
	for <virtio-dev@archiver.kernel.org>; Thu,  9 Mar 2023 08:51:15 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 7D2781FF8F
	for <virtio-dev@archiver.kernel.org>; Thu,  9 Mar 2023 08:51:14 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7317098670C
	for <virtio-dev@archiver.kernel.org>; Thu,  9 Mar 2023 08:51:14 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 67AA29866C1; Thu,  9 Mar 2023 08:51:14 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 55E069866F6
	for <virtio-dev@lists.oasis-open.org>; Thu,  9 Mar 2023 08:51:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678351870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+i0w9WqIL9ZPbYW/Yv5TskuJR8MxXHPruOqgSTtE0fY=;
        b=BmX2Ghra925M7NxGOfK0ZzusSgDA3T2ENPB1CTA3BhojjgT5//Xgpf6DERx6vkR4jh
         gS+14LefTgl4f5ayQwYvSHX4NEWNbgo1o6w4O6RVJyrqs51u+CGMJLI4uvOXM8B6Mlpx
         MQCTbSEZuIttWpJVNGhCNh+FF6wenNj6aQKsvwdLTl6uhWdTYEcDQHh7B/HZNwjf+ebL
         iYysPRitZwBAuUCFwDV5iYdPbetlZNMuXemLNG7q34BLDlDoRJxxioJDkyqovBouBW5W
         XFoRnc0lUgwUUDgsXA1dR/shmSAB8CVeYJoxrCH6BXJHrFazQbWK51nz+I6dkB+G7r6f
         fu7A==
X-Gm-Message-State: AO0yUKXTia4qJAlewwEPyIIAXhRaZcorSHmTnMOXc8p+2jfWJxyN1V1Q
	p4mSQwf2feS/81tkyHjfXx8gwA==
X-Google-Smtp-Source: AK7set8ftWQHv1D5/0RoFpnuh7BmT9reUnqkwdpkJf4bmvLnd2t//tccurlO9OTQd3vpqPWi5PediQ==
X-Received: by 2002:a05:6a20:6a9e:b0:cc:f047:afaf with SMTP id bi30-20020a056a206a9e00b000ccf047afafmr18297962pzb.11.1678351869994;
        Thu, 09 Mar 2023 00:51:09 -0800 (PST)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: qemu-devel@nongnu.org,
	virtio-dev@lists.oasis-open.org,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	stratos-dev@op-lists.linaro.org,
	Oleksandr Tyshchenko <olekstysh@gmail.com>,
	xen-devel@lists.xen.org,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Juergen Gross <jgross@suse.com>,
	Sebastien Boeuf <sebastien.boeuf@intel.com>,
	Liu Jiang <gerry@linux.alibaba.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Thu,  9 Mar 2023 14:21:00 +0530
Message-Id: <7c3718e5eb99178b22696682ae73aca6df1899c7.1678351495.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1678351495.git.viresh.kumar@linaro.org>
References: <cover.1678351495.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] [PATCH V3 1/2] docs: vhost-user: Define memory region separately

The same layout is defined twice, once in "single memory region
description" and then in "memory regions description".

Separate out details of memory region from these two and reuse the same
definition later on.

While at it, also rename "memory regions description" to "multiple
memory regions description", to avoid potential confusion around similar
names. And define single region before multiple ones.

This is just a documentation optimization, the protocol remains the same.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 docs/interop/vhost-user.rst | 39 +++++++++++++++++--------------------
 1 file changed, 18 insertions(+), 21 deletions(-)

diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
index 8a5924ea75ab..1720d681264d 100644
--- a/docs/interop/vhost-user.rst
+++ b/docs/interop/vhost-user.rst
@@ -130,18 +130,8 @@ A vring address description
 Note that a ring address is an IOVA if ``VIRTIO_F_IOMMU_PLATFORM`` has
 been negotiated. Otherwise it is a user address.
 
-Memory regions description
-^^^^^^^^^^^^^^^^^^^^^^^^^^
-
-+-------------+---------+---------+-----+---------+
-| num regions | padding | region0 | ... | region7 |
-+-------------+---------+---------+-----+---------+
-
-:num regions: a 32-bit number of regions
-
-:padding: 32-bit
-
-A region is:
+Memory region description
+^^^^^^^^^^^^^^^^^^^^^^^^^
 
 +---------------+------+--------------+-------------+
 | guest address | size | user address | mmap offset |
@@ -158,19 +148,26 @@ Memory regions description
 Single memory region description
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
-+---------+---------------+------+--------------+-------------+
-| padding | guest address | size | user address | mmap offset |
-+---------+---------------+------+--------------+-------------+
++---------+--------+
+| padding | region |
++---------+--------+
 
 :padding: 64-bit
 
-:guest address: a 64-bit guest address of the region
+A region is represented by Memory region description.
 
-:size: a 64-bit size
+Multiple Memory regions description
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
-:user address: a 64-bit user address
++-------------+---------+---------+-----+---------+
+| num regions | padding | region0 | ... | region7 |
++-------------+---------+---------+-----+---------+
 
-:mmap offset: 64-bit offset where region starts in the mapped memory
+:num regions: a 32-bit number of regions
+
+:padding: 32-bit
+
+A region is represented by Memory region description.
 
 Log description
 ^^^^^^^^^^^^^^^
@@ -952,8 +949,8 @@ Front-end message types
 ``VHOST_USER_SET_MEM_TABLE``
   :id: 5
   :equivalent ioctl: ``VHOST_SET_MEM_TABLE``
-  :request payload: memory regions description
-  :reply payload: (postcopy only) memory regions description
+  :request payload: multiple memory regions description
+  :reply payload: (postcopy only) multiple memory regions description
 
   Sets the memory map regions on the back-end so it can translate the
   vring addresses. In the ancillary data there is an array of file
-- 
2.31.1.272.g89b43f80a514


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

