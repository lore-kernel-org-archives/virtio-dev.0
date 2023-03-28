Return-Path: <virtio-dev-return-11804-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80A28C6FD1D
	for <virtio-dev@archiver.kernel.org>; Tue, 28 Mar 2023 02:29:35 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 8F7CEC622F
	for <virtio-dev@archiver.kernel.org>; Tue, 28 Mar 2023 02:29:34 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7281198633D
	for <virtio-dev@archiver.kernel.org>; Tue, 28 Mar 2023 02:29:34 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 55FC2983F7B; Tue, 28 Mar 2023 02:29:34 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3E5EB98625A
	for <virtio-dev@lists.oasis-open.org>; Tue, 28 Mar 2023 02:29:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-IronPort-AV: E=Sophos;i="5.98,295,1673884800"; 
   d="scan'208";a="226460232"
IronPort-SDR: H9ExMg9nS9uHs9PiYpVtYQb1U8ESkzCV0AlEhT9jIhVF+98EWmJ3oo+G09ULI/sDMakjln+s7h
 /HzZZLkohr0ZymX0zXamj2F534NggE9Dw0ZcIVSI1WJyqKb3kbaZRjZ9caxShusdlj0r8Vt/5+
 dEjcwfOEAXmZrWi17qmggwc9pVb+FTheB1qmLv0uXg4hBec0ZLR5W2KHsQi7ypYvARzea0NsVa
 K4i6NHh1JJxShe6vkeG4m9QlsLbA6HpQkW+p/rI+sC+AcfPI6V7fNYpGaguEAxSXtsLZCMR3ee
 f8w=
IronPort-SDR: gdiKj1A7cHqqjia4MjqjvtsIhfWj27XdYBOV4aWrKa7/EvJIiZ6FW1NSrrL4AzH3MxGXeIMBjd
 hVwkPKL/QHR2yNKXmp8UlN0gdZ2rSc796eCeWVPQHMnEqO3f+PGGUF3aUMPqr2wypv1g9XhgYJ
 GcWWQYEPpYb8FdlVJEQTgRJYUiYCSQ53LBMcas7yahoTNPcsIbtw2sbDYr0aFoMgh8ttoJ8Ggj
 hlSooQDwkZu6HDwvkVf7tmXf/zo2jy4xPye1MelyVTHsYVbojLSAzsTPvmlxrvHr54a7oZGgZE
 GOw=
WDCIronportException: Internal
From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	Stefan Hajnoczi <stefanha@gmail.com>,
	Hannes Reinecke <hare@suse.de>,
	Sam Li <faithilikerun@gmail.com>
Cc: virtio-dev@lists.oasis-open.org,
	virtualization@lists.linux-foundation.org,
	Dmitry Fomichev <dmitry.fomichev@wdc.com>
Date: Mon, 27 Mar 2023 22:29:26 -0400
Message-Id: <20230328022928.1003996-1-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] [PATCH 0/2] virtio-blk: fix a few problems in ZBD-related code

This two-part series contains code fixes that are related to the
recently added support for zoned block devices in virtio-blk
driver.

The original ZBD patchset that was merged to the kernel -next was not
the latest and greatest version. The first patch of this series is
essentially a diff between the current code and the final revision of
the original patchset.

The second patch fixes a problem that is observed when a host-managed
zoned device is virtualized via virtio-blk and the driver kernel is
configured without ZBD support (CONFIG_BLK_DEV_ZONED not set). In this
case, the driver must not allow the device scan to succeed in order to
avoid erroneous device operation that may cause data loss. The
second patch adds this currently missing functionality.

Dmitry Fomichev (2):
  virtio-blk: migrate to the latest patchset version
  virtio-blk: fix ZBD probe in kernels without ZBD support

 drivers/block/virtio_blk.c      | 268 ++++++++++++++++++++------------
 include/uapi/linux/virtio_blk.h |  18 +--
 2 files changed, 181 insertions(+), 105 deletions(-)

-- 
2.34.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

