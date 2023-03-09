Return-Path: <virtio-dev-return-11562-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DE07C61DA4
	for <virtio-dev@archiver.kernel.org>; Thu,  9 Mar 2023 08:51:10 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 4C3BD2B057
	for <virtio-dev@archiver.kernel.org>; Thu,  9 Mar 2023 08:51:09 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 26D239866FD
	for <virtio-dev@archiver.kernel.org>; Thu,  9 Mar 2023 08:51:09 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 0BB559866C1; Thu,  9 Mar 2023 08:51:09 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EB70C9866F3
	for <virtio-dev@lists.oasis-open.org>; Thu,  9 Mar 2023 08:51:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678351867;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YtzXHGHMS64VogkrKd3Ei8P73aUrg9lW5cX1ATCVQYo=;
        b=Xgjm84HlL+ReFOxpU8KHjdFgYRvCgU/hcpKl9ww+mr8HXdbzK+vRHmOjE0hGgvnyyS
         z96c4hScokM+Mf2eP7HyrZOYHMEOxaWAWgjIHxN1YDpapiFpxJMaEs1I+gzWVVjYYZ17
         5vlZZtaYNAb2f9Hwqy4y7KDQaFimpXM4eTpmHpHAHmninBZl6znpWj03+cHsL3Xau7ap
         G/1XH7vyF6U821LW9AIXMuxyRVpUg/OrhfrEMrR/vRat88AytSaLiktsPdN9+IDOIG6P
         A7gbSHCrhGR1iBFIA4TG6fN5TzWy3qSPEKOu25Gj36QSdkT4unkZfQFDREEf4RXWwnBC
         uczg==
X-Gm-Message-State: AO0yUKXeEtf6fA8PVuA7K28AFv8Ehpng6hZ6OQtan1G03pVMlRkAE+M3
	LPNTdu1lvx+NEXDTiUvlZJaRTw==
X-Google-Smtp-Source: AK7set82c8nTI8LDr+yjMnggASdbq6ivX+wK6RPkhvCxpvT+V+TAj3Gj4shp7wy6TtmXW50qCtK/Eg==
X-Received: by 2002:a17:90b:4a4c:b0:237:9cc7:28a4 with SMTP id lb12-20020a17090b4a4c00b002379cc728a4mr22372080pjb.14.1678351867185;
        Thu, 09 Mar 2023 00:51:07 -0800 (PST)
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
Date: Thu,  9 Mar 2023 14:20:59 +0530
Message-Id: <cover.1678351495.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] [PATCH V3 0/2] qemu: vhost-user: Support Xen memory mapping quirks

Hello,

This patchset tries to update the vhost-user protocol to make it support special
memory mapping required in case of Xen hypervisor.

The first patch is mostly cleanup and second one introduces a new xen specific
feature.

V2->V3:
- Remove the extra message and instead update the memory regions to carry
  additional data.

- Drop the one region one mmap relationship and allow back-end to map only parts
  of a region at once, required for Xen grant mappings.

- Additional cleanup patch 1/2.

V1->V2:
- Make the custom mmap feature Xen specific, instead of being generic.
- Clearly define which memory regions are impacted by this change.
- Allow VHOST_USER_SET_XEN_MMAP to be called multiple times.
- Additional Bit(2) property in flags.

Viresh Kumar (2):
  docs: vhost-user: Define memory region separately
  docs: vhost-user: Add Xen specific memory mapping support

 docs/interop/vhost-user.rst | 60 ++++++++++++++++++++++++-------------
 1 file changed, 39 insertions(+), 21 deletions(-)

-- 
2.31.1.272.g89b43f80a514


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

